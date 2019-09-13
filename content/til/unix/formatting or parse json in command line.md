---
layout: post
title: "Format or parse json in command line"
date: 2016-03-17T00:00:00+02:00
language: en
comments: true
tags: til unix jq
description: Format or parse json in command line
keywords: json unix jq
---

To easily format json or command line there [jq](https://stedolan.github.io/jq/)

example

```
$ echo '{"user":"stedolan","titles":["JQ Primer", "More JQ"]}' | jq .
{
    "user": "stedolan",
      "titles": [
          "JQ Primer",
              "More JQ"
                ]
}
```

or just print specific value

```
$ echo '{"user":"stedolan","titles":["JQ Primer", "More JQ"]}' | jq .titles[0]
"JQ Primer"
```
