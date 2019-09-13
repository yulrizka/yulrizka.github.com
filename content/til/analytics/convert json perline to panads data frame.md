---
layout: post
title: "convert json perline to panads data frame"
date: 2016-06-07T00:00:00+02:00
language: en
comments: true
description: convert json perline to panads data frame
keywords: analytics pandas dataframe json
---

Sometimes we have a file that contains a json object per line.
For example log file in json format

```
{foo: 1, bar: 2}
{foo: 3, bar: 4}
```

if we want to read this in python pandas we need to convert it to

```
[
  {foo: 1, bar: 2},
  {foo: 3, bar: 4}
]
```

easy way to do this is with `jq --slurp`

```
$ cat file.json | jq --slurp . > one_array.json
```

then you can read it in python pandas (notebook) like this

```python
sf = pd.read_json('one_array.json')
```

