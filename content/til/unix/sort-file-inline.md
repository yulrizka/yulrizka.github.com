---
layout: post
title: "Sort file inline"
date: 2019-09-26T11:44:50+02:00
language: en
comments: true
tags: til unix
description: How to sort file inline in unix
keywords: unix,linux,sort
---

We can sort file by using `sort` command for example:
```bash
$ sort a.txt

# or

$ cat a.txt | sort
```

But this will only output to stdout. Some time you want the file to be sorted. Instead you can do
```bash
$ sort a.txt -o a.txt
```

note that this DOEST work and it will TRUNCATE the file
```bash
$ sort a.txt > a.txt
```
