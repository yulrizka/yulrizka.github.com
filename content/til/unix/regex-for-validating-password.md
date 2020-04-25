---
layout: post
title: "Regex for Validating Password"
date: 2019-10-25T11:55:53+02:00
language: en
comments: true
tags: unix til
description: 
keywords: regex validating password
---

This regex can be use to validate password

```
((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,20})
```

description:
```
(                   # Start of group
  (?=.*\d)          # must contains one digit from 0-9
  (?=.*[a-z])       # must contains one lowercase characters
  (?=.*[\W])        # must contains at least one special character
  .                 # match anything with previous condition checking
  {8,20}            # length at least 8 characters and maximum of 20 
)                   # End of group
```
