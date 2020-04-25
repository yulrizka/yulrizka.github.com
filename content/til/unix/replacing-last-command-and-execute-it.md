---
layout: post
title: "Replacing Last Command and Execute It"
date: 2020-03-08T13:23:49+01:00
language: en
comments: true
tags: unix, til,  
description: re-run the last command and replacing some word
keywords: unix zsh
draft: false
---

For example
```
$ echo "hello world world world"                   
hello world world world
```

If you want to replace `world` with `universe` you can do

```
# If you use ZSH you can press `tab` at the end of the line and it will replace
# the whole line with the actuall command
$ ^world^universe
$ echo "hello universe world world"
```

As you can see, it only replace the first matching word.

If you want it to replace the whole match:

```
# zsh
$ ^world^universe^:G

# bash
$^world^universe^&
```

**Don't use it in production**  
I tend to use `fc` command which allow me to edit the command in my editor first
