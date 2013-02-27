---
layout: post
title: "Homeward light indicator with RaspberryPi and CommonSense"
date: 2013-02-26 20:33
language: en
comments: true
tags: [web, raspberrypi]
description: Creating Light that turn on when returing from office with raspbery pi and CommonSense
keywords: raspberrypi, raspberry, light, commonsense, sensor,
published: true
---
I've been tinkering with my raspberry-pi for quite some time now. Just like an Arduino, it has a General Purpose IO pin 
that let me send electrical signal.

## The Technical parts
One of the benefit of my jobs (besides working in the Europe of course) is I get to work with so many smart people.
People that have understand electronics and embedded systems. Ever since I was a kid, I've always wanted to control home applience with electronic. so I'm really excited when my collague teach me how to use a `relay` circuit.

I'm pretty new at this kind of things, from what I understand that a `relay` circuit is something like a on/off swtich that you can control by sending electrical signal. In this case I connect the `relay` circuit attached to my raspberry-pi to a desk lamp. That way i can send electical signal from the raspbery pi to turn on/off the lamp using the GPIO pin. I don't even have to solder the `relay` board. They already an arduino module that I can use. The one I use is prety cheap and I bought it [here](relay).

[relay] http://relay-link
