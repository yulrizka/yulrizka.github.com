---
layout: post
title: "process pipe operator"
date: 2015-02-12T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: process pipe operator
keywords: unix pipe
---

`<( )` operator executes command inside the parenthesis and output the file descriptor

example

```bash
$ cat <(echo 'hello') <(echo 'world')
hello
world

# is practically the same with

$ echo 'hello' > 1.txt
$ echo 'world' > 2.txt
$ cat 1.txt 2.txt

# replace cat with ls
$ ls <(echo 'hello') <(echo 'world')
/proc/self/fd/11  /proc/self/fd/12
```

you can use this command for example to compare 2 directory and find only uniq file

example:

```bash
$ comm -3 <(ls -1 dir1) <(ls -1 dir2)
```
