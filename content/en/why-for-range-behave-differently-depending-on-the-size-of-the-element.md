---
title: "Why for-range behaves differently depending on the size of the element (A peek into go compiler optimization)"
date: 2020-04-25T15:47:49+02:00
draft: false
language: en
comments: true
tags: 
  - golang
description: Understanding the go SSA optimization using for-range example
keywords: golang, ssa, optimization

twitter:
  card: "summary"
  site: "@yulrizka"
  title: "Why for-range behaves differently (A peek into go compiler optimization)"
  description: "Understanding the go SSA optimization using for-range example"
  image: "https://labs.yulrizka.com/images/twitter-go-card.jpg"
---

It's all started when my colleague asked this question.

```go
package main

import "testing"

const size = 1000000

type SomeStruct struct {
	ID0 int64
	ID1 int64
	ID2 int64
	ID3 int64
	ID4 int64
	ID5 int64
	ID6 int64
	ID7 int64
	ID8 int64
}

func BenchmarkForVar(b *testing.B) {
    slice := make([]SomeStruct, size)
    b.ReportAllocs()
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        for _, s := range slice { // index and value
            _ = s
        }
    }
}
func BenchmarkForCounter(b *testing.B) {
    slice := make([]SomeStruct, size)
    b.ReportAllocs()
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        for i := range slice { // only use the index
            s := slice[i]
            _ = s
        }
    }
}
```

Which one do you think is faster?

```
$ go test -bench .
goos: linux
goarch: amd64
BenchmarkForVar-4       	    4363	    269711 ns/op	       0 B/op	       0 allocs/op
BenchmarkForCounter-4   	    4195	    285952 ns/op	       0 B/op	       0 allocs/op
PASS
ok  	_/test1	2.685s
```

It's pretty much the same. However, if we increase the size of the struct by adding another field `ID9 int64`
The result becomes significantly different.

```
$ go test -bench .
goos: linux
goarch: amd64
BenchmarkForVar-4       	     282	   4264872 ns/op	       0 B/op	       0 allocs/op
BenchmarkForCounter-4   	    4363	    269761 ns/op	       0 B/op	       0 allocs/op
PASS
ok  	_/test1	3.255s
```
<br />
This problem become intriguing, so I dig a little deeper. I would like to point out that the code is a contrived example.
It would probably not applied in a production code. I am **not** going to focus on the benchmark or which for-range works
better but rather exploring how Go compiles and demonstrating useful Go tools in the process.

The code below also contains some assembly code. I am not going into too much detail, so I would not worry if you are not familiar with it.
My intention is to show how the generated code differs and what could be the reason for it.

I am going to focus on `for _, s = range slice` loop (ForVar). To make it simpler I create a `main.go` and `struct.go`

**main.go**
```go
package main

func main() {
	const size = 1000000

	slice := make([]SomeStruct, size)
	for _, s := range slice {
		_ = s
	}
}
```

I'll skip the `struct.go` here since it's pretty trivial.

## Generating Assembly Code
To look into what instructions are generated, we can use `go tool compile -S`. This will print out the generated
assembly code to stdout. I also Skipped some lines that are not directly related to our code.
 
according to [asm package doc](https://golang.org/doc/asm)

> The FUNCDATA and PCDATA directives contain information for use by the garbage collector; they are introduced by the compiler. 

```bash
$  go tool compile -S main.go type.go | grep -v FUNCDATA | grep -v PCDATA
```

Here are the generated assembly code for both version.

**version with 9 int64**

This struct contains 9 int64 and has the size 72 bytes

```asm
"".main STEXT size=93 args=0x0 locals=0x28
    ...
	0x0024 00036 (main_var.go:6)	MOVQ	AX, (SP)
	0x0028 00040 (main_var.go:6)	MOVQ	$1000000, 8(SP)
	0x0031 00049 (main_var.go:6)	MOVQ	$1000000, 16(SP)
	0x003a 00058 (main_var.go:6)	CALL	runtime.makeslice(SB)
	0x003f 00063 (main_var.go:6)	XORL	AX, AX       # set AX = 0
	0x0041 00065 (main_var.go:7)	INCQ	AX           # AX++
	0x0044 00068 (main_var.go:7)	CMPQ	AX, $1000000 # AX < 1000000
	0x004a 00074 (main_var.go:7)	JLT	65               # JUMP to 00065 (next iteration)
    ...
```
Here you can see that at line `00065`, the loop does nothing except increasing the counter. Let's compare it with the
larger struct.

<br/>
**version with 10 int64**

The struct now contains 10 int64 and has the size 80 bytes
```asm
0x0000 00000 (main_var.go:3)	TEXT	"".main(SB), ABIInternal, $120-0
    ...
	0x0044 00068 (main_var.go:6)	XORL	CX, CX # CX = 0
	0x0046 00070 (main_var.go:7)	JMP	76
	0x0048 00072 (main_var.go:7)	ADDQ	$80, AX
	0x004c 00076 (main_var.go:7)	PCDATA	$0, $2 # setup temporary variable autotmp_7
	0x004c 00076 (main_var.go:7)	LEAQ	""..autotmp_7+32(SP), DI
	0x0051 00081 (main_var.go:7)	PCDATA	$0, $3
	0x0051 00081 (main_var.go:7)	MOVQ	AX, SI
	0x0054 00084 (main_var.go:7)	PCDATA	$0, $1
	0x0054 00084 (main_var.go:7)	DUFFCOPY	$826 # copy content of the struct
	0x0067 00103 (main_var.go:7)	INCQ	CX           # CX++
	0x006a 00106 (main_var.go:7)	CMPQ	CX, $1000000 # CX < 1000000
	0x0071 00113 (main_var.go:7)	JLT	72               # JUMP to 0072 (next iteration)
    ...
```
The conclusion is that with 80 bytes struct, every iteration copies the value of the element.

## SSA Optimization
To understand how this code is generated, we first need to understand how GO compile a source code.

_Stream_ wrote a very good introduction to the topic on 
[How a Go Program Compiles down to Machine Code](https://getstream.io/blog/how-a-go-program-compiles-down-to-machine-code/).   
The short version is the compiler does:

1. break up the source code content into tokens (Scanning)
2. Construct Abstract Syntax Tree using the tokens (Parsing)
3. Generate Intermediate Representation (IR) with [Static Single Assignment (SSA) form](https://en.wikipedia.org/wiki/Static_single_assignment_form)
4. Iteratively optimize the IR with [multiple pass](https://github.com/golang/go/blob/go1.14.1/src/cmd/compile/internal/ssa/compile.go#L398-L451)

<br/>
Fortunately GO provides amazing tool that helps us getting more insight into the optimization process.
We can generate the SSA output for each stage of transformation with:

```bash
$ GOSSAFUNC=main go tool compile -S main_var.go type_small.go
```

<br/>
The command will generate `ssa.html` in the same folder.

Each column represents the optimization pass, and the result of the IR code.
When we click on a block, variable, or line. It will colorize the associated element, so we can track changes easily.

<a href="forVar_small_ssa.png">
![Generated SSA HTML](forVar_small_ssa.png)
</a>

<br/>

After comparing each step, I found out that the generated code was identical until the `writebarrier` pass.
let's focus on block `b6`

**`writebarrier`** (identical on both versions)
```
b6: ← b3 b4
    v22 (7) = Phi <*SomeStruct> v14 v45
    v28 (7) = Phi <int> v16 v37
    v23 (7) = Phi <mem> v12 v27
    v37 (+7) = Add64 <int> v28 v36
    v39 (7) = Less64 <bool> v37 v8
    v25 (7) = VarDef <mem> {.autotmp_7} v23
    v26 (7) = LocalAddr <*SomeStruct> {.autotmp_7} v2 v25
    v27 (+7) = Move <mem> {SomeStruct} [72] v26 v22 v25
```
If you see on `v26 & v27`, it does `Move` (or Copy) the content of the struct to local variable `autotmp_7`. 

The `lower` pass basically convert the IR code into specific architecture low level code. Let's have a look at the generated output.
Don't be afraid if you don't really understand the assembly. What I wanted to show is the different code that was generated during
the `lower` pass.

**`lower` with 9 int64**
```
b6: ← b3 b4

    v22 (7) = Phi <*SomeStruct> v14 v45
    v28 (7) = Phi <int> v16 v37
    v23 (7) = Phi <mem> v12 v27
    v37 (+7) = ADDQconst <int> [1] v28
    v25 (7) = VarDef <mem> {.autotmp_7} v23
    v26 (7) = LEAQ <*SomeStruct> {.autotmp_7} v2
    v44 (7) = CMPQconst <flags> [1000000] v37 
    v32 (+7) = LEAQ <*SomeStruct> {.autotmp_7} [8] v2
    v31 (+7) = ADDQconst <*SomeStruct> [8] v22
    v29 (+7) = MOVQload <uint64> v22 v25
    v24 (+7) = LEAQ <*SomeStruct> {.autotmp_7} [40] v2
    v15 (+7) = ADDQconst <*SomeStruct> [40] v22
    v46 (+7) = LEAQ <*SomeStruct> {.autotmp_7} [56] v2
    v35 (+7) = ADDQconst <*SomeStruct> [56] v22
    v21 (+7) = LEAQ <*SomeStruct> {.autotmp_7} [24] v2
    v17 (+7) = ADDQconst <*SomeStruct> [24] v22
    v39 (7) = SETL <bool> v44
    v42 (7) = TESTB <flags> v39 v39
    v30 (+7) = MOVQstore <mem> {.autotmp_7} v2 v29 v25  # <-- start translated Move instruction
    v41 (+7) = MOVOload <int128> [8] v22 v30
    v20 (+7) = MOVOstore <mem> {.autotmp_7} [8] v2 v41 v30
    v34 (+7) = MOVOload <int128> [24] v22 v20
    v19 (+7) = MOVOstore <mem> {.autotmp_7} [24] v2 v34 v20
    v33 (+7) = MOVOload <int128> [40] v22 v19
    v38 (+7) = MOVOstore <mem> {.autotmp_7} [40] v2 v33 v19
    v47 (+7) = MOVOload <int128> [56] v22 v38
    v27 (+7) = MOVOstore <mem> {.autotmp_7} [56] v2 v47 v38
```

<br/>
**`lower` with 10 int64**

```
b6: ← b3 b4

    v22 (7) = Phi <*SomeStruct> v14 v45
    v28 (7) = Phi <int> v16 v37
    v23 (7) = Phi <mem> v12 v27
    v37 (+7) = ADDQconst <int> [1] v28
    v25 (7) = VarDef <mem> {.autotmp_7} v23
    v26 (7) = LEAQ <*SomeStruct> {.autotmp_7} v2
    v44 (7) = CMPQconst <flags> [1000000] v37
    v32 (+7) = LEAQ <*SomeStruct> {.autotmp_7} [8] v2
    v31 (+7) = ADDQconst <*SomeStruct> [8] v22
    v29 (+7) = MOVQload <uint64> v22 v25
    v39 (7) = SETL <bool> v44
    v42 (7) = TESTB <flags> v39 v39
    v30 (+7) = MOVQstore <mem> {.autotmp_7} v2 v29 v25 # <-- start translated Move instruction
    v27 (+7) = DUFFCOPY <mem> [826] v32 v31 v30

LT v44 → b4 b2 (likely) (7)
```

<br/>

The later version uses `DUFFCOPY` to perform the Move operation. This logic I believe is due to a rewrite rule 
[rewriteAMD64.go](https://golang.org/src/cmd/compile/internal/ssa/rewriteAMD64.go#L54445). It's an optimization
to Move a large byte on memory.

```
// match: (Move [s] dst src mem)
// cond: s > 64 && s <= 16*64 && s%16 == 0 && !config.noDuffDevice
// result: (DUFFCOPY [14*(64-s/16)] dst src mem)
```

<br/>

At a later SSA pass (`elim unread autos`) the compiler can detect that there are unused temporary
variable for the first version (9 int64 struct). Thus, the `Move` instruction can be removed.
This is not the case with for the `DUFFCOPY' version.
That's why the generated machine code is less optimized than the previous. 

Note: 
A [Duff Device](https://en.wikipedia.org/wiki/Duff%27s_device) is a loop optimization by splitting the task
and reduce the number of loop.

## Conclusion
`for-range` behaves differently depending on the struct size is due to Compiler SSA optimization. The compiler generated
a different machine code for the larger struct where at a later pass it did not detect unused variable. The opposite happen
for the smaller struct. At a later pass, it detected that some variables are un used. It removes the copy of element
instruction on each iteration.
