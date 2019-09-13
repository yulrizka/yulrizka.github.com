---
layout: post
title: "pandas - format custom date in data frame"
date: 2016-06-07T00:00:00+02:00
language: en
comments: true
tags: til
description: pandas - format custom date in data frame
keywords: analytics pandas dataframe json
---

say you have a data frame like this

```
[
  {foo: 1, created_date:"2016-06-04 03:00:01.727"},
  ...
]
```

the timestamp doesn't recognize immediately. To make this field as timestamp and as index we could do

```python
# assuming df contains the data frame
df['timestamp'] = pd.to_datetime(be.timestamp, format="%Y-%m-%d %H:%M:%S.%f")
df.set_index(df['timestamp'], inplace=True)
```
