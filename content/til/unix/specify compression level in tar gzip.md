---
layout: post
title: "specify compression level in tar gzip"
date: 2016-06-30T00:00:00+02:00
language: en
comments: true
tags: til unix
description: specify compression level in tar gzip
keywords: unix tar compression
---

from [http://superuser.com/questions/305128/how-to-specify-level-of-compression-when-using-tar-zcvf](http://superuser.com/questions/305128/how-to-specify-level-of-compression-when-using-tar-zcvf)

```
GZIP=-9 tar cvzf file.tar.gz /path/to/directory
```

or 

```
tar cvf - /path/to/file0 /path/to/file1 | gzip -9 - > files.tar.gz
```
