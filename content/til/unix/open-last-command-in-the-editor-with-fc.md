---
layout: post
title: "Open Last Command in the Editor With Fc"
date: 2020-03-08T13:18:33+01:00
language: en
comments: true
tags: til unix
description: edit last command in the editor with fc command
keywords: til,linux
draft: false
---

Some time you have a long command and you want to edit multiple word in it.  for example: ``` $ cat foo.txt | grep foo | grep -v bar > foo_output.txt ```

Say you want to execute this 5 times and each replacing `foo` and `bar` with something else.

for that you can use the `fc` command. 

```
$ fc
```

It will open a text editor (vim for me. I'm guessing it will look at $EDITOR env variable).  
After that you can edit or duplicate the line easily. Each line will be treated as a single command.

You can as well do something like
```
$ fc foo=baz
```

It will replace all instance of `foo` in the command and replace it with `baz`

