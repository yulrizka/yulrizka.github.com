---
layout: post
title: "Checkout Last Branch"
date: 2020-03-16T14:44:17+01:00
language: en
comments: true
tags: til
description: checkout last branch
keywords: git,til
draft: false
---

Sometimes you are checking out mutltiple different git branches and want to navigate back to previous branch.

You can use `git checkout -` to do it 

example :

```bash
$ git checkout ay/convert-errors-lib
Updating files: 100% (2480/2480), done.
Switched to branch 'ay/convert-errors-lib'

$ git checkout -
Updating files: 100% (2480/2480), done.
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

If you want to checkout 2 branches a go. you can do 

```bash
$ git checkout @{-2}
```

Basically `git checkout -` is equql to `git checkout @{-1}`

If you want to list all of the checked out branch (history) you can use this script

```bash
$ for i in {1..10}; do echo -n "[$i] "; git rev-parse --symbolic-full-name @{-$i}; done
```

I added this as a git command on my zsh. have a look at [this commit](https://github.com/yulrizka/oh-my-zsh/commit/2b730e3bf2777f83e6a215da4a03e51e67145ff3)
