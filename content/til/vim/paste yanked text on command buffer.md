---
layout: post
title: "paste yanked text on command buffer"
date: 2016-08-12T00:00:00+02:00
language: en
comments: true
tags: til vim
description: paste yanked text on command buffer
keywords: vim
---

Sometimes you need to paste yanked text while performing command. For example subtituting yanked text with some words.

yanked text are stored in the `0` and `"` register.

in the command mode you can paste this with `ctrl-R [registe]` example in our cases this would be `ctrl-R 0`

so full command would be for example `:%s/[press ctrl-R then 0]/replacement/gc`
