---
layout: post
title: "Show Hidden File"
date: 2019-09-22T16:20:01+02:00
language: en
comments: true
tags: til osx hiden
description: "How to show hidden file osx finder"
keywords: osx, til, finder, 
---

Tho show hidden file (file with `x`):

**Mojave**:  

In finder `CMD + Shift + .` to toggle it

**Before Mojave**:

Show  
```
defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app
```

Hide  
```
defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app
```


