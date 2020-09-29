---
layout: post
title: "Global Gitignore File"
date: 2020-09-29T09:37:31+02:00
language: en
comments: true
tags: til git
description: git ignore file across all repo
keywords: git, gitignore
draft: false
---

To create a global git ignore that apply across all git repository

```
$ echo `.DS_Store` > ~/.gitignore
$ git config --global core.excludesfile ~/.gitignore
```
