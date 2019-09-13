---
layout: post
title: "filtering json with jq"
date: 2016-05-31T00:00:00+02:00
language: en
comments: true
tags: til unix
description: filtering json with jq
keywords: jq json unix cli
---

[jq](https://stedolan.github.io/jq/) is a fantastic command line tools to parse and filter json in command line.
It works for linux, osx and maybe windows.

example, to format json

```
$ json='[{"genre":"deep house"}, {"genre": "progressive house"}, {"genre": "dubstep"}]'
$ echo $json
[{"genre":"deep house"}, {"genre": "progressive house"}, {"genre": "dubstep"}]

$ echo $json | jq .
[
  {
    "genre": "deep house"
  },
  {
    "genre": "progressive house"
  },
  {
    "genre": "dubstep"
  }
]
```

To output a particular field

```
$ echo $json | jq '.[].genre'
"deep house"
"progressive house"
"dubstep"
```

To filter based on a key 

```
$ echo "$json" | jq -c '.[] | select(.genre | contains("house"))'
{"genre":"deep house"}
{"genre":"progressive house"}
```

more example could be found on [here](https://github.com/stedolan/jq/wiki/Cookbook)
