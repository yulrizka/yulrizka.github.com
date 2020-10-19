---
layout: post
title: "Intellij as git diff and mergetool"
date: 2020-10-19T11:16:55+02:00
language: en
comments: true
tags: til git intellij idea
description: Use intellij as git diff and mergetool
keywords: git, intellij, idea, mergetool, difftool,
draft: false
---

## Setup idea script
First, you need to set up `idea` script by following the instruction [here](https://www.jetbrains.com/help/idea/working-with-the-ide-features-from-command-line.html#toolbox)

If you are using mac, make sure you add `-W` on the open script as follows (see [this issue](https://youtrack.jetbrains.com/issue/IDEA-253240))

```
open -Wna "IntelliJ IDEA.app" --args "$@"
```

## setup git difftool & mergetool

Taken from [https://gist.github.com/rambabusaravanan/1d1902e599c9c680319678b0f7650898#gistcomment-2132894](https://gist.github.com/rambabusaravanan/1d1902e599c9c680319678b0f7650898#gistcomment-2132894)

open `.git/config` (or your global `gitconfig` file)
```bash
[merge]
    tool = intellij
[mergetool "intellij"]
    cmd = idea merge $(cd $(dirname "$LOCAL") && pwd)/$(basename "$LOCAL") $(cd $(dirname "$REMOTE") && pwd)/$(basename "$REMOTE") $(cd $(dirname "$BASE") && pwd)/$(basename "$BASE") $(cd $(dirname "$MERGED") && pwd)/$(basename "$MERGED")
    trustExitCode = true
[diff]
    tool = intellij
[difftool "intellij"]
    cmd = idea diff $(cd $(dirname "$LOCAL") && pwd)/$(basename "$LOCAL") $(cd $(dirname "$REMOTE") && pwd)/$(basename "$REMOTE")

```

Explanation about LOCAL, REMOTE, BASE from [stackoverflow](https://stackoverflow.com/questions/20381677/in-a-git-merge-conflict-what-are-the-backup-base-local-and-remote-files-that)

- foo.LOCAL: the "ours" side of the conflict - ie, your branch (HEAD) that will contain the results of the merge
- foo.REMOTE: the "theirs" side of the conflict - the branch you are merging into HEAD
- foo.BASE: the common ancestor. useful for feeding into a three-way merge tool
- foo.BACKUP: the contents of file before invoking the merge tool, will be kept on the filesystem if mergetool.keepBackup = true.

`idea merge` [syntax](https://www.jetbrains.com/help/idea/command-line-merge-tool.html)

```
idea merge <path1> <path2> [<base>] <output>
```
