---
layout: post
title: "keep N recent item in folder"
date: 2016-05-26T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: keep N recent item in folder
keywords: unix cli
---

Sometimes you create a script that generate something 
but you wanted to only keep N last item. There is couple way to achive this.
This version works both on OSX and Linux.

```
$ (ls -t|head -n 5;ls)|sort|uniq -u|xargs rm
```

Basically it the `(..)` will capture together the output

1. `ls -t | head -n 5` will list files sort by time and get first 5 items
2. The second `ls` will list all file. Now it contains duplicate items for items we want to keep
3. `sort|uniq -u` will sort it, and remove those duplicate file in step 1. At this point it will contains only files that we want to delete (everything except files from step 1)
4. `xargs rm` will change the resulst into space separated value which is argument for `rm`
