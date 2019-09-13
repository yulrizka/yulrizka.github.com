---
layout: post
title: "worktree - switching branch without stash"
date: 2016-04-03T00:00:00+02:00
language: en
comments: true
tags: til
description: worktree - switching branch without stash
keywords: git worktree
---

Some times you are working on some feature but then you need to check or fix something on some other branch.
The normal way to do it is that we do:

1. git stash
1. switch to other branch
1. commit changes
1. swith to previous branch
1. git stash pop

This can be complicated especially you have multiple stash. You can't easily understand which stash belongs where.

After version 2.5.2 there is new command called `git worktree`

Basically it can create new directory which checkout different branch

example 

```
$ git worktree add ../branch-temp some-branch
$ cd ../branch-temp

// hack
// finish

$ cd ../original-path
$ rm -rf ../branch-temp

// cleanup

$ git worktree prune
```
more detail about the command are available at [https://git-scm.com/docs/git-worktree](https://git-scm.com/docs/git-worktree)
