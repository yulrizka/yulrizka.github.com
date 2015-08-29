---
layout: post
title: "Testing go 1.5 cross compilation on raspberry pi"
date: 2015-08-29 17:28
language: en
comments: true
tags: go
description: testing cross compilation in go 1.5
keywords: go, golang, cross compilation
---

I'm so excited with the new release of golang. One particular feature
is now very easy to build for multiple architecture. If you seen my other posts,
I also like to tinker with my raspberry-pi. On my previous project I use either ruby
or python for building some stuff. One annoying thing is dependency, setup and compilation
is usually quite slow. Would be cool if I could just create some stuff in desktop and just
*scp* the binary to pi and everything should work!

There is [this nice](http://dave.cheney.net/2015/03/03/cross-compilation-just-got-a-whole-lot-better-in-go-1-5) article that explain the process. Let's start there and create simple application

```go
package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello. I'm running %s on %s architecture\n", runtime.GOOS, runtime.GOARCH)
}
```

Let's try to build it

```bash
# create binary called 'main' for raspberry-pi (1gen)
$ env GOOS=linux GOARCH=arm GOARM=6 go build main.go

# transfer the binary to pi
$ scp main pi:
```

Now, crossing my finger, and run it on my pi

``` bash
$ ssh pi

pi@raspbmc:~$ ./main 
Hello. I'm running linux on arm architecture
pi@raspbmc:~$ 
```

Holy crap, it's that easy. I'm excited. Let's see if go routine works

```go
package main

import (
	"fmt"
	"sync"
)

func main() {
	var wg sync.WaitGroup
	nWorker := 2
	c := make(chan string)

	// write 10 message to channel c
	go func() {
		defer close(c)
		for i := 0; i < 10; i++ {
			c <- fmt.Sprintf("item sequence %d", i)
		}
	}()

	// create n worker to read from channel c
	for i := 0; i < nWorker; i++ {
		wg.Add(1)
		go func(worker int) {
			for msg := range c {
				fmt.Printf("worker %d: msg %s\n", worker, msg)
			}
			wg.Done()
		}(i)
	}

	wg.Wait()
	fmt.Println("That's super awesome!!, cee ya!")
}
```

Again, build and *scp*, and cross some more fingers

```bash

@raspbmc:~$ ls -alh main
-rwxr-xr-- 1 pi pi 1.9M Aug 29 18:08 main
pi@raspbmc:~$ ./main 
worker 1: msg item sequence 0
worker 0: msg item sequence 1
worker 1: msg item sequence 2
worker 0: msg item sequence 3
worker 0: msg item sequence 4
worker 0: msg item sequence 5
worker 0: msg item sequence 6
worker 0: msg item sequence 7
worker 0: msg item sequence 8
worker 1: msg item sequence 9
That's super awesome!!, cee ya!
```

Super awesome indeed, it just works!. Oh and the binary is not that big *1.9M*
considering it statically include the library.

Hmm let's try something fun that fiddle with the *gpio* pin. Let's create something that
what raspberry-pi made for.. blinking led :p

There is already [library](https://github.com/davecheney/gpio). Let's starts there.

```go
package main

import (
	"fmt"
	"os"
	"os/signal"
	"time"

	"github.com/davecheney/gpio"
	"github.com/davecheney/gpio/rpi"
)

func main() {
	// set GPIO25 to output mode
	pin, err := gpio.OpenPin(rpi.GPIO25, gpio.ModeOutput)
	if err != nil {
		fmt.Printf("Error opening pin! %s\n", err)
		return
	}

	// turn the led off on exit
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	go func() {
		for _ = range c {
			fmt.Printf("\nClearing and unexporting the pin.\n")
			pin.Clear()
			pin.Close()
			os.Exit(0)
		}
	}()

	dance(pin)
}

func dance(pin gpio.Pin) {
	for {
		pin.Set()
		time.Sleep(500 * time.Millisecond)
		pin.Clear()
		time.Sleep(500 * time.Millisecond)
	}
}
```

Dayuumm.. It's that easy. No more pip install or bundle install on pi. Just *scp* the binary!

Of course we've got this far, we must try to control it remotely via HTTP.

<div class="row">
  <div class="span8 offset1">
<iframe width="628" height="400" src="https://www.youtube.com/embed/QkHu2-cgauU" frameborder="0" allowfullscreen></iframe align="center">
  </div>
</div><br/>

```go
package main

import (
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/davecheney/gpio"
	"github.com/davecheney/gpio/rpi"
)

// channel to control start blinking or not
var ctrlChan = make(chan bool)

func main() {
	// set GPIO25 to output mode
	pin, err := gpio.OpenPin(rpi.GPIO25, gpio.ModeOutput)
	if err != nil {
		fmt.Printf("Error opening pin! %s\n", err)
		return
	}

	// turn the led off on exit
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	go func() {
		for _ = range c {
			fmt.Printf("\nClearing and unexporting the pin.\n")
			pin.Clear()
			pin.Close()
			os.Exit(0)
		}
	}()

	go dance(pin, ctrlChan)
	ctrlChan <- true

	// http listen
	http.HandleFunc("/dance", danceHandler)
	http.ListenAndServe(":8080", nil)
}

func dance(pin gpio.Pin, ctrlChan chan bool) {
	enabled := false
	for {
		select {
		case val := <-ctrlChan:
      // got value from danceHandler via the channel
			fmt.Printf("dancing? %+v\n", val)
			enabled = val
		default:
			if enabled {
				pin.Set()
				time.Sleep(500 * time.Millisecond)
				pin.Clear()
				time.Sleep(500 * time.Millisecond)
			}
		}
	}
}

func danceHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received request")
	s := r.URL.Query().Get("s")
	ctrlChan <- s == "1" // tell dance to enable or not
}
```

Look at that. All it takes to do that is just 67 lines of code. The main 
logic just about 31 lines. That's including the fancy dancing blinking.
No framework, only *gpio* dependency. Everything else is go *stdlib*.

Ok, let's do one other thing. The reverse!
Trigger something when button is pressed. For this let's just use
*websocket*, and see how hard it is to implement this. What this mean that
if you have websocket client (web browser) you could listen to event and stream it
  directly from your raspberry-pi to your computer.

<div class="row">
  <div class="span8 offset1">
<iframe width="628" height="400" src="https://www.youtube.com/embed/QkHu2-cgauU" frameborder="0" allowfullscreen></iframe align="center">
  </div>
</div><br/>

```go
package main

import (
	"bufio"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/davecheney/gpio"
	"github.com/davecheney/gpio/rpi"
	"golang.org/x/net/websocket"
)

// channel to control start blinking or not
var ctrlChan = make(chan bool)

func main() {
	// set GPIO25 to output mode
	pin, err := gpio.OpenPin(rpi.GPIO25, gpio.ModeOutput)
	if err != nil {
		fmt.Printf("Error opening pin! %s\n", err)
		return
	}

	// turn the led off on exit
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	go func() {
		for _ = range c {
			fmt.Printf("\nClearing and unexporting the pin.\n")
			pin.Clear()
			pin.Close()
			os.Exit(0)
		}
	}()

	go buttonHandler(pin)

	// http listen
	http.Handle("/", websocket.Handler(EchoServer))
	http.ListenAndServe(":8080", nil)
}

// handle websocket connection
func EchoServer(ws *websocket.Conn) {
	w := bufio.NewWriter(ws)
	w.WriteString("Hello, i will tell you if button is pressed\n\n")
	w.Flush()

	for {
		<-ctrlChan
		w.WriteString("Kachhinggg... somebody pressed the button\n")
		w.Flush()
	}
}

// check if button is pressed
func buttonHandler(p gpio.Pin) {
	for {
		if p.Get() {
			ctrlChan <- true
		}
		time.Sleep(150 * time.Millisecond)
	}
}
```

You see there I connect 2 client. One browser and the other one is *cli app* that I created.
Notice that they got their messages alternately between each other. This is because
they are sharing the same channel. I will leave it to you my kind reader as an exercise
to make it broadcast the message instead of distributing them :)

all source are available at [https://github.com/yulrizka/go-pi-experiments](https://github.com/yulrizka/go-pi-experiments)
