---
layout: post
title: "Stubbing Time.Now() in golang"
date: 2014-10-27T16:42:00+02:00
language: en
comments: true
tags: golang testing
description: Stubbing or mokcing Time.Now() in go for testing
keywords: golang test, time stubbing, golang stub time, golang test time, mocking
aliases:
    - /en/2014/10/stubbing-time-dot-now-in-golang.html
---

Some time it's really hard to test functionality that involves with system time.
Especially when we wanted to test specific functionality. For example testing
whether today is end of month. It's unrealistic to run this test case once every month.

I can think of multiple ways to address this issue. It depends on the use case where it
may apply to the usecase  

## Passing the time object

```go
func CheckEndOfMonth(now time.Time) {
  ...
}
```

This way you can either pass `time.Now()` in your main pacakge
or call it with something like `time.Date(t.Year(), t.Month(), 1, 0, 0, 0, 0, time.UTC)` in your test.
This work well but it's a bit cumbersome to pas it ever time we call the function

## Passing a function that generate time

```go
func CheckEndOfMonth(now func() time.Time) {
	// ...
	x := now()
}

func main() {
	CheckEndOfMonth(time.Now)
}

// for test
func TestCheckEndOfMonth(t *testing.T) {
	// you can access closure here if needed    
	timeFn := func() time.Time {
		return time.Date(2019, 1, 1,0,0,0,0, time.UTC)
	}
	CheckEndOfMonth(timeFn)
}

```

This method allow you to have more control over how and when the time is generated.
For example the time is generated inside the `CheckEndOfMonth` not at the _caller_

## Abstract the time generator as an interface
```go
type Clock interface {
	Now() time.Time
}

type realClock struct {}
func (realClock) Now() time.Time { return time.Now() }

func CheckEndOfMonth(clock Clock) {
	// ...
	x := clock.Now()
}

func main() {
	CheckEndOfMonth(realClock{})
}
```

on the test code
```go
type mockClock struct {}
func (mockClock) Now() time.Time {
	return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)
}

func TestCheckEndOfMonth(t *testing.T) {
	mc := mockClock{}
	CheckEndOfMonth(mc)
}
```

This has disadvantage that for each different time to test we must create a separate struct

##  Package level time generator

Previous examples require you to pass in either concrete instance or a function on the caller
that can be sometime cumbersome.

Another approach you can use, is to create a function to generate current time. And during the test
you can change the implementation of the function.

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

func CheckEndOfMonth() {
	// ...
	x := now()
}
```

now in your test you could do something like this:

```go
func TestCheckEndOfMonth(t *testing.T) {
    // change implementation of clock in the beginning of the test
    nowFunc = func() time.Time {
        return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)
    }

    // after finish with the test, reset the time implementation
    defer resetClockImplementation()
    
    CheckEndOfMonth()
    //...
}
```

Now that we hide from the caller but it became a package level function. Beside the fact
that we always remember to call `resetClockImplementation`, this package is not thread
safe. Tests can't be executed in parallel

## Embed time generator in struct

If you are lucky enough to work in a _struct_, you can do this

```go
// TimeValidator contains business logic to CheckEndOfMonth
type TimeValidator struct {
	// .. your fields
	clock func() time.Time
}

func (t TimeValidator) CheckEndOfMonth()  {
	x := t.clock()
	// ...
}

// now is time generator that by default fall back to standard library
func (t TimeValidator) now() time.Time  {
	if t.clock == nil {
		return time.Now() // default implementation
	}

	return t.clock()
}
```

And the test can be
```go
func TestCheckEndOfMonth(t *testing.T) {
	tv := TimeValidator{
		clock: func() time.Time {
			return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)
	}}
	tv.CheckEndOfMonth()
}
```

I like this method because you don't have to pass instance of time or function all over the place
but still have it easily create an arbitrary time mock/stub

If you do this more often, you can also easily reuse the functionality in other struct
```go
type TimeMock struct {
	NowFn func() time.Time

	// can be extended to mock other time function
	AfterFn func() <-chan time.Time
}

func (t TimeMock) Now() time.Time  {
	if t.NowFn == nil {
		return time.Now() // default implementation
	}

	return t.NowFn()
}

type TimeValidator struct {
	TimeMock
}
```

in test 
```go
func TestCheckEndOfMonth(t *testing.T) {
	tv := TimeValidator{
		TimeMock: TimeMock{
			NowFn: func() time.Time {
				return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)	
		},
	}}
	tv.CheckEndOfMonth()
}
```

## Better way to write test function with time

Function with time is usually hard to test because it dependency with functions on package time.

A different way to test is to separate the function that generate the time with the function
that process the time. For example

```go
func CheckEndOfMonth()  {
	now :=  time.Now()
	
	d := endOfMonth(now)
	if now == d {
		// do some business logic
	} 
}
```

Instead of testing that function, extract the logic of processing time
```go
func CheckEndOfMonth()  {
	now :=  time.Now()

	processEndOfMonth(now)
	
}

func processEndOfMonth(t time.Time) {
	d := endOfMonth(t)
	if t == d {
		// do some business logic
	}
}
```

this way you don't test the `CheckEndOfMonth()` function but `processEndOfMonth`. The downside is
you will not have 100% test coverage :wink:

