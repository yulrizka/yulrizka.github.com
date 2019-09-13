---
layout: post
title: "file size older than x days"
date: 2016-06-06T00:00:00+02:00
language: en
comments: true
tags: til unix
description: file size older than x days
keywords: unix file sort
---

from [http://stackoverflow.com/a/17419690/546750](http://stackoverflow.com/a/17419690/546750)

to list all file that modified more than more than X days, we can use

``` 
$ find . -mtime +[number of days]
```

if you use `-` sign than it became file is modified since X days

Combine it with akw, we can get total file size

```
$ find . -mtime +180 -exec du -ks {} \; | cut -f1 | awk '{total=total+$1}END{print total/1024}'
```
