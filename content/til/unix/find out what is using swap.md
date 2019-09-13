---
layout: post
title: "find out what is using swap"
date: 2016-05-24T00:00:00+02:00
language: en
comments: true
tags: til unix
description: find out what is using swap
keywords: unix swap
---

from [http://northernmost.org/blog/find-out-what-is-using-your-swap/](http://northernmost.org/blog/find-out-what-is-using-your-swap/)

```bash
#!/bin/bash
# Get current swap usage for all running processes
# Erik Ljungstrom 27/05/2011
SUM=0
OVERALL=0
for DIR in `find /proc/ -maxdepth 1 -type d | egrep "^/proc/[0-9]"` ; do
        PID=`echo $DIR | cut -d / -f 3`
        PROGNAME=`ps -p $PID -o comm --no-headers`
        for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
        do
                let SUM=$SUM+$SWAP
        done
        echo "PID=$PID - Swap used: $SUM - ($PROGNAME )"
        let OVERALL=$OVERALL+$SUM
        SUM=0

done
echo "Overall swap used: $OVERALL"
```
