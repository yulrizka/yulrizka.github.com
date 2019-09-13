---
layout: post
title: "diff output of 2 command"
date: 2018-10-04T00:00:00+02:00
language: en
comments: true
tags: til unix
description: diff output of 2 command
keywords: unix diff
---

for example, I want to compare output of 2 different curl comand

```
$ diff <(curl -s http://host.com/a) <(curl -s http://anotherhost.com/a)
```


