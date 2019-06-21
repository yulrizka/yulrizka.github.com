---
layout: post
title: "osx-push-to-talk App"
date: 2015-03-22T00:26:00+02:00
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

As a part of scrum teams, every day I need to give updates to my team via Google Hangout.
We have a team here in the Netherlands and also in Indonesia.
Some times I am in the same room as a colleague of mine. This sometimes quite annoying
because I can hear my self (with a delay) from his mic. This somehow messed up my brain.
Google Hangout already has a 'auto adjust mic volume' that is really great which cancel the noise.
But we still have a problem and end-up muting each other when we want to talk.

There are currently an App that does this already on Apple store, and pretty cheap too. 
Nevertheless I could not find the one that is suitable for my needs. And I would like to develop an OSX app
since I never done it before. Even though i have a hate-love relationship with XCode,
I have to give credits to XCode. It's quite easy to create an app like this. 

<div class="" align="center">
  <img src="/images/post/ptt/ptt-off.png" alt="PushToTalk Off state">
  <br>
  <img src="/images/post/ptt/ptt-on.png" alt="PushToTalk on State">
  <div class="caption">Status bar indicator</div>
</div>

The app sits on status-bar (tray icon ?). By default it muted the microphone and show
translucent mic icon. If you hold down the **Right Options** key, it will un-mute the microphone as long as you pressed it.  when you release the key, it will mute the microphone until you press the key again or quit the application.

Everything is at [github.com/yulrizka/osx-push-to-talk](https://github.com/yulrizka/osx-push-to-talk):

* [DMG Installer](https://github.com/yulrizka/osx-push-to-talk/releases)
* [Source](https://github.com/yulrizka/osx-push-to-talk)

I've only tested this app on my MacBook running Yosemite.

If you are on Linux, there is also a phython GTK [app](https://github.com/coddingtonbear/linux-push-to-talk) that does this really nicely. 

If you are on windows, well Godspeed my friend :)

veel succes!
