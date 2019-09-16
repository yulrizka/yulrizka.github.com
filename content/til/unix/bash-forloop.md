---
layout: post
title: "Bash Forloop"
date: 2019-09-16T17:19:11+02:00
language: en
comments: true
tags: til unix
description: Bash forloop syntax
keywords: bash loop forloop
---

Example of forloop syntax
```
for i in 1 2 3 4 5
do
   echo "i=$i"
done
```

with range
```
for i in {1..5}
do
   echo "i=$i"
done
```

cutomize increment
```
for i in {0..10..2}
do 
   echo "i=$i"
done
 ```