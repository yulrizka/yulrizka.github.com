---
layout: post
title: "git mergetool and diff with p4merge"
date: 2016-04-03T00:00:00+02:00
language: en
comments: true
tags: til unix git
description: git mergetool and diff with p4merge
keywords: git mergetool
---

Some time you want visually merge conflict in git. To use p4merge
[https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge](https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge)


## git mergetool
### Linux
```
$ git config --global merge.tool p4mergetool
$ git config --global mergetool.p4mergetool.cmd \
$ "/opt/p4v/bin/p4merge \$PWD/\$BASE \$PWD/\$REMOTE \$PWD/\$LOCAL \$PWD/\$MERGED"
$ git config --global mergetool.p4mergetool.trustExitCode false
$ git config --global mergetool.keepBackup false
```

### Mac
```
$ git config --global merge.tool p4mergetool
$ git config --global mergetool.p4mergetool.cmd \
"/Applications/p4merge.app/Contents/Resources/launchp4merge \$PWD/\$BASE \$PWD/\$REMOTE \$PWD/\$LOCAL \$PWD/\$MERGED"
$ git config --global mergetool.p4mergetool.trustExitCode false
$ git config --global mergetool.keepBackup false
```


## Set as diff tool
### Linux
$ git config --global merge.tool p4mergetool
$ git config --global mergetool.p4mergetool.cmd \
"/opt/p4v/bin/p4merge \$LOCAL \$REMOTE"

### Mac
$ git config --global diff.tool p4mergetool
$ git config --global difftool.p4mergetool.cmd \
"/Applications/p4merge.app/Contents/Resources/launchp4merge \$LOCAL \$REMOTE"

