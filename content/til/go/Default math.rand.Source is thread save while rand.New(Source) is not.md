---
layout: post
title: "Default math.rand.Source is thread save while rand.New(Source) is not"
date: 2016-03-13T00:00:00+02:00
language: en
comments: true
tags: til go
description: Default math.rand.Source is thread save while rand.New(Source) is not
keywords: go random
---
Default pacakge rand uses Source that is thread safe with default seed `1`

we can use the pacakge's method to have thread safe random number generation

```go
package main

import (
  "fmt"
  "math/rand"
  "time"
)

func main() {
  seed := time.Now().UnixNano()
  rand.Seed(seed)
  fmt.Println(rand.Int63())
}
```

But the `rand.NewSource()` offers thread unsafe implementation.
One of the reason to choose the unsafe implementation to avoid
synchronization, especially when you have only single go routine.

```go
package main

import (
  "fmt"
  "math/rand"
  "time"
)

func main() {
  seed := time.Now().UnixNano()
  r := rand.New(rand.NewSource(seed))
  fmt.Println(r.Int63())
}
```
