---
layout: post
title: "cluster ssh in iterm2 with i2cssh"
date: 2016-03-31T00:00:00+02:00
language: en
comments: true
tags: til osx
description: cluster ssh in iterm2 with i2cssh
keywords: osx ssh
---

I'm a fan of cluster ssh. It allows you to control multiple ssh session with one keyboard.
I tried [csshx](https://github.com/brockgr/csshx) which uses the default osx terminal, but I love iterm2.

But today I found [i2cssh](https://github.com/wouterdebie/i2cssh) which does that for iterm2

One of the feature is broadcast where you can send command to multiple window.
It's basically the same with csshx but their approach is to create another extra window
that receive an input and send it to all other windows. I like  i2cssh approach better with shortcut.
