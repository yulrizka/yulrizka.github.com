---
layout: post
title: "grep - print only matched"
date: 2016-03-16T00:00:00+02:00
language: en
comments: true
tags: til unix
description: grep - print only matched
keywords: grep linux
---

you can use the `-o` flag to only print matched value. Example

```
$ echo "Hello fellow unix fan" | grep --color -o nix
nix
$ echo "Hello fellow unix fan" | grep --color -o nux 
$ echo $?
1
```
