---
layout: post
title: "Homeward light indicator with RaspberryPi and CommonSense"
date: 2013-02-26 20:33
language: en
comments: true
tags: [web, raspberrypi]
description: Creating Light that turn on when you return from office with raspberry pi and CommonSense
keywords: raspberrypi, raspberry, light, commonsense, sensor,
published: true
---

<div class="row">
  <div class="span8 offset1">
    <iframe align="center" width="628" height="400" src="http://www.youtube.com/embed/35ylS4IX_mc" frameborder="0" allowfullscreen></iframe>
  </div>
</div><br/>
I've been tinkering with my [raspberry-pi][raspberry-pi] for quite some time now. What I like about it because it is cheap ($25),
it's run Linux (especially debian based) and most of all it's have General Purpose Input Output pin. Since I was a kid, I always
wanted to control electronic appliance remotely. Luckily my friend [@pimnijdam][pimnijdam] thought me how to control a relay board.
Basically it's just like an electric switch that connect/disconnect current when you supply a low voltage.


So I connect one of the GPIO pin to the relay board and from the relay board to the lamp. Now I can control the desk lamp through
my raspberry-pi by issuing a linux command. Had been successfully doing this, I wanted to the lamp not only from the raspberry pi
but anywhere. The easiest way that I could think of is running a web server inside the raspberry-pi. The debian repository is
quite awesome. So I could install a ruby/python and it only took a single command.

So I did create a [project][pi-sinatra-github]  with ruby/sinatra to control this light. Its really small (30 lines of code, 80 lines html + js) and with this project I can control up to 3 light, one of those eventually control the light. In case you are interested, I put the source on [github][pi-sinatra-github].
This project uses [pi-piper][pi-piper] a ruby library that wrap [wiringPi][wiringPi], which is library that is used to control the GPIO pin.

<div class="row">
<div class="span8 offset1">
<div class="thumbnail">
  <img src="/images/post/2013/02/homeward-indicator-project.jpg" alt="homeward indicator">
  <div class="caption">
    The light will turn on whenever I leave the office at noon.
  </div>
</div>
</div>
</div><br/>

<div class="row">
  <div class="span4 offset1">
    <div class="thumbnail">
      <img src="/images/post/2013/02/lamp-off.jpg" alt="lamp off">
      <div class="caption">
        Controlling Lamp with Raspberry-pi + ruby/sinatra
      </div>
    </div>
  </div>
  <div class="span4">
    <div class="thumbnail">
      <img src="/images/post/2013/02/lamp-on.jpg">
      <div class="caption">
        The phone open a web browser to the raspberry pi
      </div>
    </div>
  </div>
</div><br/>

Now, turning a desk lamp with pi is something; But it's quite boring and not really useful. Now let us make something a bit
interesting. Instead of controlling it manually, The light be trigger on my activity. In this case I the light to turn on
when ever I came back from the office on every working day. So at home my wife know exactly when I leave the office. I already
have it running a web server, so basically I can control it from my mobile phone. But I don't want to do this every single day.
And this is where [ComonSense][CommonSense] really makes thing easy for me.

[CommonSense][CommonSense] is a platform to store, retrieve, analyze and interpret our sensory data. What is a sensor ? well anything could be a sensor. From physical sensor on our mobile phone like accelerometer, noise, position, cell network, light, ambience and more sophisticated sensor like sensor that tell your quality of sleep. By using one or more sensor, it could create more intelligent sensor. For example a sensor that tell wether you are standing or sitting by analyzing the accelerometer data. CommonSense is Awesome!, but for this experiment we will be using a simple location sensor. It will tell where is my current location by GPS or
wifi-network.

What is make it easy is I don't have to create an application on my mobile phone. CommonSense already have a platform that run on
[Android][Android] or [iOs][iOs]. The application act as an agent that collect and sample sensor data from the mobile phone. By it self it's not really doing much right now but combine with the [CommonSense] make it really easy for a developer like me to
easily experiment with my data. So with this sense app, the raspberry-pi could easily get data from my mobile phone through the
[CommonSense API][CommonSense-API].

<div class="row">
  <div class="span3 offset1">
    <div class="thumbnail">
      <img src="/images/post/2013/02/sense-app.jpg" alt="sense app">
      <div class="caption">
        Sense Android App - Works as an aggent of CommonSense
      </div>
    </div>
  </div>
  <div class="span7">
    <div class="thumbnail">
      <img src="/images/post/2013/02/biking-out-of-the-office.jpg" alt="biking out of the office">
      <div class="caption">
        The light will turn on when I'm 200m away from the office
      </div>
    </div>
  </div>
</div><br/>
Again, my awesome colleague [@pim][pimnijdam] create a prototype of [python framework][python framework] that make it very easy for me to
implement my project. You should definitely [chek it out!][python framework]. I've created the _homeward light indicator_ project
using the early version of the framework. This is actually my first encounter with Python. Although I still prefer doing my
project with Ruby, I'm really enjoying working with Python.

[raspberry-pi]: http://www.raspberrypi.org/
[pi-sinatra-github]: https://github.com/yulrizka/pi-sinatra-gpio/blob/master/app.rb
[CommonSense]: http://www.sense-os.nl/commonsense
[Android]: https://play.google.com/store/apps/details?id=nl.sense_os.app
[iOs]: https://itunes.apple.com/nl/app/senseplatform/id447552125?mt=8&uo=4
[CommonSense-API]: http://developer.sense-os.nl
[python framework]: https://github.com/pimnijdam/eventScripting
[pimnijdam]: https://github.com/pimnijdam
[pi-piper]: https://github.com/jwhitehorn/pi_piper
[wiringPi]: https://projects.drogon.net/raspberry-pi/wiringpi/
