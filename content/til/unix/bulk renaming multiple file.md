---
layout: post
title: "bulk renaming multiple file"
date: 2016-07-12T00:00:00+02:00
language: en
comments: true
tags: til unix
description: bulk renaming multiple file
keywords: unix rename bulk
---

There are couple of way to rename multiple files. 

From [http://unix.stackexchange.com/questions/1136/batch-renaming-files](http://unix.stackexchange.com/questions/1136/batch-renaming-files)

example we have files 

```
image0001.png
image0002.png
image0003.png
...
```

And we would like to rename it to

```
0001.png
0002.png
0003.png
...
```

## with for loop

this works with linux and mac without installing anything

```bash
for f in *.png; do mv "$f" "${f#image}"; done
```

## With ZSH

This is my favorite way since I'm using [ZSH](http://www.zsh.org/) and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
Check it now, it's awesome

```bash
$ autoload zmv
zmv 'image(*.png)' '$1'
```

or let zsh automatically define $1, $2 etc

```bash
zmv -w 'image*.png' '$1.png'
```

## Using your editor

for more complex operation, sometimes it easier to rename the file on your editor.

there is `qmv` from renameutils

```
$ qmv *.png
```
it will open editor with 2 columns, you can edit the right size rename that file

