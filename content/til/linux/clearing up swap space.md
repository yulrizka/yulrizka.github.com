---
layout: post
title: "clearing up swap space"
date: 2016-06-15T00:00:00+02:00
language: en
comments: true
tags: til linux
description: clearing up swap space
keywords: linux swap
---
*WARNING: make sure the memory is enough to put the data back from swap, else system will start killing processes*

To clear up swap space (put the data back into memory) we can do

```
# swapoff -a && swapon -a
```

Because this is quite slow process, it's a good idea to run this inside screen session.


