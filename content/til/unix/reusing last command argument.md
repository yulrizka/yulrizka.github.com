---
layout: post
title: "Reusing last command arguments"
date: 2016-03-11T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: Reusing last command arguments
keywords: bash 
---

```bash
$ echo 1
1
$ echo 2
2
$ echo 3
3
$ echo 4
4
$ echo 5
5
```

use `alt + .` will reuse the last program argument in descending order

```
$ echo (press alt + .)
$ echo 5 (press alt + . again)
$ echo 4 (press alt + . again)
...
```

## selective arguments

* `!:1` gives you the first argument
* `!:2-3` gives you 2nd and third argument and
* `!:-3`  gives you binary name + first 3 arguments

```
$ echo 1 2 3 4 5
$ echo !:1 # -> echo 1
$ echo 1 2 3 4 5
$ echo !:2-3 # -> echo 2 3
$ echo 1 2 3 4 5
$ echo !:-3 # -> echo echo 1 2 3
```
