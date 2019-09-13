---
layout: post
title: "pipe output to clipboard with pbcopy and pbpaste"
date: 2016-02-10T00:00:00+02:00
language: en
comments: true
tags: til osx
description: pipe output to clipboard with pbcopy and pbpaste
keywords: osx clipboard pbcopy pbpaste
---

Using terminal and needs to copy the result of command to clipboard ? use pbcopy

```bash
$ cat somefile.txt | pbcopy
```

Or the other way around, paste from clipboard and pipe it to other program

```bash
$ pbpaste | grep foo
```
