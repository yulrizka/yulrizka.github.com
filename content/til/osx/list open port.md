---
layout: post
title: "list open port"
date: 2017-03-16T00:00:00+02:00
language: en
comments: true
tags: til osx
description: list open port
keywords: osx netstat port
---
# list open port

```
$ sudo netstat -atp tcp| grep -i listen
```

or

```
$ sudo lsof -i -P | grep -i listen
```
