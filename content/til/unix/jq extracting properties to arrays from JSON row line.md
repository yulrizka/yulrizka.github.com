---
layout: post
title: "jq extracting properties to arrays from JSON row line"
date: 2017-10-09T00:00:00+02:00
language: en
comments: true
tags: til unix jq
description: jq extracting properties to arrays from JSON row line
keywords: jq json unix
---

For example if we have a file that contains JSON object like

```
{"a": 1, "b":{"c": 11}
{"a": 2, "b":{"c": 22}}
{"a": 3, "b":{"c": 33}}
```

And you want to construct something like

```
["1", "11"]
["2", "22"]
["3", "33"]
```

You can do that with jq

```
$ cat filename.json | jq -c '[.a, .b.c]'
```

this is particularly usefull to grep something from JSON log
