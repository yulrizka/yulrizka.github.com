---
layout: post
title: "parsing epoch timestamp to date"
date: 2016-08-16T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: parsing epoch timestamp to date
keywords: unix epoch
---

To get current unix timestamp we can do 

```
$ date +%s
1471365644
```

But how do we parse a file which contain epoch timestamp to date?

```
$ echo 1471365644 | perl -pe 's/(\d+)/localtime($1)/e' 
```

if we have it in milliseconds, we could remove the milliseconds part with

```
$ echo 1471365644000 | cut -c -10 |  perl -pe 's/(\d+)/localtime($1)/e'
Tue Aug 16 18:40:44 2016
```

Assuming your epoch seconds is 10 character. But if you have more or less, you need to do some other string processing first
