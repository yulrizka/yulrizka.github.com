---
layout: post
title: "zfs auto snapshot"
date: 2018-10-22T00:00:00+02:00
language: en
comments: true
tags: til linux zfs
description: zfs auto snapshot
keywords: zfs snapshot
---

Having ZFS snapshot saved me once when I acidentally `rm -f /home/myuser`. 

There is a simple package that easily make auto snapshot. 

```
$ sudo apt install zfs-auto-snapshot
```

This will install the script and the cron job associated with it.

By default it will backup all filesystem and volumes. You can disable the filesystems completely by

```
$ sudo zfs set com.sun:auto-snapshot=false tank/data-set-name
```

or only for specific interval
```
sudo zfs set com.sun:auto-snapshot=true tank/data-set-name
sudo zfs set com.sun:auto-snapshot:monthly=false tank/data-set-name
sudo zfs set com.sun:auto-snapshot:weekly=false tank/data-set-name
sudo zfs set com.sun:auto-snapshot:daily=true tank/data-set-name
sudo zfs set com.sun:auto-snapshot:hourly=false tank/data-set-name
sudo zfs set com.sun:auto-snapshot:frequent=false tank/data-set-name
```
