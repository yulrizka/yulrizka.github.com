---
layout: post
title: "prompt confirmation in bash"
date: 2016-05-24T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: prompt confirmation in bash
keywords: unix bash
---

From [http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script](http://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script)

```bash
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
```
