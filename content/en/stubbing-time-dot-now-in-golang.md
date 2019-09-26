---
layout: post
title: "Stubbing Time.Now() in golang"
date: 2014-10-27T16:42:00+02:00
language: en
comments: true
tags: [golang]
description: Testing functionality that using system time
keywords: golang test, time stubbing, golang stub time, golang test time
aliases:
    - /en/2014/10/stubbing-time-dot-now-in-golang.html
---

Some time it's really hard to test functionality that involves with system time.
Especially when we wanted to test specific functionality. For example testing
whether today is end of month. It's unrealistic to run this test case once every month.

If you are coming from ruby land, you might familiar with some test library that solve
this problem like [timecop][timecop]. Actually it's not that hard to do it in Go also.
There is couple of approach you can use.

First approach is passing the `time.Time` object to every function.

```go
func CheckEndOfMonth(now time.Time) {
  ...
}
```

This way you can either pass `time.Now()` in your main pacakge
or call it with something like `time.Date(t.Year(), t.Month(), 1, 0, 0, 0, 0, time.UTC)` in your test.
This work well but it's a bit cumbersome to pas it evertime we call the function

Another approach you can use, is to create a function to generate current time. And during the test
you can change the implementation of the function. Here is how i do it (and a bonus function to
generate begining of month and end of month)

```go
package main

import "time"

type nowFuncT func() time.Time

var nowFunc nowFuncT

func init() {
    resetClockImplementation()
}

func resetClockImplementation() {
    nowFunc = func() time.Time {
        return time.Now()
    }
}

// function to return current time stamp in UTC
func now() time.Time {
    return nowFunc().UTC()
}

// return beginning of month in UTC
func beginningOfMonth(t time.Time) time.Time {
    return time.Date(t.Year(), t.Month(), 1, 0, 0, 0, 0, time.UTC)
}

// return end of month in utc
func endOfMonth(t time.Time) time.Time {
    return time.Date(t.Year(), t.Month()+1, 1, 0, 0, 0, 0, time.UTC).Add(-1 * time.Nanosecond)
}

```

now in your test you could do something like this:

```go
// change implementation of clock in the beginning of the test
nowFunc = func() time.Time {
    return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)
}

//...

// after finish with the test, reset the time implementation
resetClockImplementation()

```

now to the process that, it will see that currently it's 15 December 2000 8:00 UTC

[timecop]: https://github.com/travisjeffery/timecop
