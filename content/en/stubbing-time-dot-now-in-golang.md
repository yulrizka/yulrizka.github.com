---
layout: post
title: "Stubbing Time.Now() in golang"
date: 2014-10-27T16:42:00+02:00
language: en
comments: true
tags:
  - golang
  - testing
description: Stubbing or mokcing Time.Now() in go for testing
keywords: golang test, time stubbing, golang stub time, golang test time, mocking
aliases:
    - /en/2014/10/stubbing-time-dot-now-in-golang.html
---

Sometimes it's really hard to test functionality that involve with system time.
Especially when we want to test the function with a specific time. For example testing
whether today is end of month or test 2 different behavior at a different time

Below we look into different ways we can mock or stub the time. Each with it's own
advantages and disadvantages.  

## Passing the time instance

```go
func CheckEndOfMonth(now time.Time) {
    // business process
}

func main() {
	CheckEndOfMonth(time.Now())
}

// for test
func TestCheckEndOfMonth(t *testing.T) {
	CheckEndOfMonth(time.Date(2019, 1, 1, 0, 0, 0, 0, time.UTC))
}
```

This way you can either pass `time.Now()` in your main pacakge
or call it with something like `time.Date(t.Year(), t.Month(), 1, 0, 0, 0, 0, time.UTC)` in your test.

Advantages:

- Simple, no extra generator necessary
- Easy to test, no need to wire mock function or struct
  
  
Disadvantages:

- Caller need to pass instance of everywhere

## Passing a function that generate time

```go
func CheckEndOfMonth(now func() time.Time) {
	// ...
	x := now() // runs at this moment, not at the caller time
}

func main() {
	CheckEndOfMonth(time.Now) // instead of time.Now()
}

// for test
func TestCheckEndOfMonth(t *testing.T) {
	loc := time.UTC // closure can be used if necessary
	timeFn := func() time.Time {
		return time.Date(2019, 1, 1, 0, 0, 0, 0, loc)
	}
	CheckEndOfMonth(timeFn)
}

```

Advantages:

- This method allows you to have more control over how and when the time is generated.
  For example the time is generated inside the `CheckEndOfMonth` not at the _caller_.
- Allows the mock function to use closure inside the function
  
  
Disadvantages:

- Caller needs to pass function 

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
type mockClock struct {
    t time.Time
}
func NewMockClock(t time.Time) mockClock {
    return mocktime{t}
}

func (m mockClock) Now() time.Time {
	return m.t
}

func TestCheckEndOfMonth(t *testing.T) {
	mc := NewMockClock(time.Date(2019, 1, 1, 0, 0, 0, 0, time.UTC))
	CheckEndOfMonth(mc)
}
```

Advantages:

- Control the generator method 
- Interface can be defined small with only needed functions
- Easily switch to different implementation
  
  
Disadvantages:

- Caller need to pass instance that implements the interface

##  Package level time generator

Previous examples require you to pass in either concrete instance or a function on the caller.


Another approach you can use is to create a package level function to generate current time. 
You can change the implementation during test.

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

Advantages:

- No need to pass instance of time or generator 
  
Disadvantages:

- Caller need to pass instance 
- Global variable
- Not thread safe
- Need to remember to call `resetClockImplementation`

## Embed time generator in struct

If you are lucky enough to work in a _struct_, you can do this

```go
// TimeValidator contains business logic to CheckEndOfMonth
type TimeValidator struct {
	// .. your fields
	clock func() time.Time
}

func (t TimeValidator) CheckEndOfMonth()  {
	x := t.now()
	// ...
}

// now is time generator that by default fall back to standard library
func (t TimeValidator) now() time.Time  {
	if t.clock == nil {
		return time.Now() // default implementation which fall back to standard library
	}

	return t.clock()
}

func main() {
	tv := TimeValidator{}
	tv.CheckEndOfMonth()
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

**Make this pattern reusable**  
If you do this more often, you can also easily reuse the functionality into other struct
by creating embeddable 
```go
// TimeMock embeddable structure that provides ability to inject time to the parent struct
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

// Use in the business logic

// TimeValidator contains business logic that uses time.Now
type TimeValidator struct {
	clock TimeMock 
}

func (t TimeValidator) CheckEndOfMonth()  {
	x := t.clock.Now()
	// ...
}

func main () {
    tv := TimeValidator{} // empty clock field gives implementation with standard lib
    tv.CheckEndOfMonth()
}
```

in test 
```go
func TestCheckEndOfMonth(t *testing.T) {
	tv := TimeValidator{
		clock: TimeMock{
			NowFn: func() time.Time {
				return time.Date(2000, 12, 15, 17, 8, 00, 0, time.UTC)	
		},
	}}
	tv.CheckEndOfMonth()
}
```

Advantages:

- No need to pass instance of time or generator
- Fall back to default standard library time implementation 
- Easily extend `TimeMock` by adding more function that is needed

Disadvantages:

- The caller needs to be a struct

## Better way to write test function with time

Function with time is usually hard to test because it dependency with  on _time_ package.

A different way to test is to separate the function that generate the time with the function
that process the time value. For example

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

this way you don't test the `CheckEndOfMonth()` but `processEndOfMonth`. This way you can easily
mock time without the need to do some wiring.

