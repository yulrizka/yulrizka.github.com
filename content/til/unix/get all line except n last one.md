---
layout: post
title: "get all line except n last one"
date: 2016-05-18T00:00:00+02:00
language: en
comments: true
tags: til unix
description: get all line except n last one
keywords: linux
---

with `head -n <negative number>` we can get the output except n lines

example

```
cat a.txt | head -n -1
```

will gives as the content of a.txt except the last one

Let say we have file 1 2 3 4 5, and with grep we want to only get 1 2 3. 

we can achive this with ls and grep

```
$ ls | grep 4 -B 100000000 | head -n -1
```

the -B show 100000000 lines before matched line, and the head -n -1 removes the matched
