---
layout: post
title: "osx-push-to-talk App"
date: 2015-03-22 00:26
language: en
comments: true
tags: [web]
description: Push to Talk app mute microphone with keyboard 
keywords: push-to-talk, ptt, push to talk, osx push to talk
---

Push To Talk app for OSX

<div class="thumbnail" align="center">
  <img src="/images/post/ptt/ptt-installer.png" alt="PushToTalk App">
  <div class="caption">PushToTalk App installer</div>
</div>
<br/>

As part of scrum team, every day i need to give update to my team via Google Hangout.
We have a team here in the Netherlands and also in Indonesia.
Some times I am in the same room as a colleague of mine. This sometimes quite annoying
because I can hear my self (with a delay) from this mic. This somehow messed up my brain.
Google Hangout already has a 'auto adjust mic volume' that is really great which cancel the noise.
But we still have a problem and end-up muting each other when we want to talk.

There are currently app that does this already on Apple store, and pretty cheap too. 
Example [this](https://itunes.apple.com/us/app/push-to-talk/id547067197), but reading from the comment
I believe it doesn't suits me very well because you have to assign F-Key, or combination with Command, Shift etc.
But it's a great software also, i has functionality to assign custom key and star-up.

So i decided to create my own, because I've never create program for OSX before. And I wanted to find out how hard it is.
Actually It's pretty easy. Although I kinda have this hate-love relationship with XCode. But It's quite easy to build app like this. 

<div class="" align="center">
  <img src="/images/post/ptt/ptt-off.png" alt="PushToTalk Off state">
  <br>
  <img src="/images/post/ptt/ptt-on.png" alt="PushToTalk on State">
  <div class="caption">Status bar indicator</div>
</div>

The app sits on status bar (tray icon ?). By default it mute the microphone and show
translucent mic icon. If you hold down the **Right Options** key, it will un-mute the microphone as long as you press that button. And when you release the key, it will mute the microphone until you quit the application.

Everything is at [github.com/yulrizka/osx-push-to-talk](https://github.com/yulrizka/osx-push-to-talk):

* [DMG Installer](https://github.com/yulrizka/osx-push-to-talk/releases)
* [Source](https://github.com/yulrizka/osx-push-to-talk)

I've only tested this app on my MacBook running Yosemite.

veel succes!
