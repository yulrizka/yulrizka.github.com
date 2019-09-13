---
layout: post
title: "sending curl POST with file"
date: 2017-10-15T00:00:00+02:00
language: en
comments: true
tags: til unix
description: sending curl POST with file
keywords: 
---

```
curl -X POST -d @myfilename http://www.url.com
``

or

``
curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
{
  "query": { "match_phrase": { "address": "mill lane" } }
}'
```
