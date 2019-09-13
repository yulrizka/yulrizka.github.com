---
layout: post
title: "Zsh Ctrl P Same Behavior as Up Arrow"
date: 2019-09-13T16:26:08+02:00
language: en
comments: true
tags: til unix
description: "Make Ctrl-P in zsh like up arrow which is to search for the last command"
keywords: unix, tar, compression
---

By default Ctrl-P just jump back to the history while up arrow behave a little bit smarter.

For example if you have history like this

```
ssh a.com
ls
cd
ssh b.com
cat
grep
```

Normaly if you type `$ ssh` and `Ctrl-P` afterwares, it will give you `grep` not `ssh b.com`

to change this behavior, you can put this in your .zshrc 

```
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
```