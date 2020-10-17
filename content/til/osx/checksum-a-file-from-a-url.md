---
layout: post
title: "Checksum a File From a URL"
date: 2020-10-17T23:44:34+02:00
language: en
comments: true
tags: til osx checksum
description: Generating checksum form URL
keywords: osx, checksum file
draft: false
---

```
$ wget -qO- https://github.com/yulrizka/osx-push-to-talk/archive/v0.1.5.tar.gz | sha256sum
```

- q : quiet, disable output log
- O : output to a file 
- `-` : stdout

flag is the same as `-q -O /dev/stdout` 
