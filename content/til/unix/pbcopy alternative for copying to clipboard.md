---
layout: post
title: "pbcopy alternative for copying to clipboard"
date: 2016-02-13T00:00:00+02:00
language: en
comments: true
tags: til unix
description: pbcopy alternative for copying to clipboard
keywords: clipboard unix
---

in osx we have [pbcopy & pbpaste](https://github.com/yulrizka/til/blob/master/osx/pipe%20output%20to%20clipboard%20with%20pbcopy%20and%20pbpaste.md)

we can have something similar in linux. Put this is your shell profile (`~/.bashrc` or `~/.zshrc` if you are using zsh)

```bash
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
```
