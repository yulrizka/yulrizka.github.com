---
layout: post
title: "zfs external backup drive with snapshot and encryption"
date: 2018-10-24T00:00:00+02:00
language: en
comments: true
tags: til linux
description: zfs external backup drive with snapshot and encryption
keywords: linux zfs
---

[main source][1]

## Get device id

```
$ ls /dev/disk/by-id -alh
...
lrwxrwxrwx 1 root root  10 okt 24 06:06 ata-WDC_WD10EZEX-08M2NA0_WD-WMC3F1471486-part4 -> ../../sda4
...
```

For example, I'm going to use `/dev/disk/by-id/ata-WDC_WD10EZEX-08M2NA0_WD-WMC3F1471486-part4`

## Setup disk encryption with LUKS

setup [LuKS][1] 

```
$ sudo apt install cryptsetup
$ cryptsetup luksFormat --cipher aes-xts-plain64 --key-size 512 --iter-time 10000 --use-random -y /dev/disk/by-id/ata-WDC_WD10EZEX-08M2NA0_WD-WMC3F1471486-part4
```

* `--cipher` encryption algorithm
* `--key-size` encryption key size
* `--iter-time` Number of millisecond to spend P8KDF passphrase processing
* `--use-random` use /dev/random
* `-y` verify passphrase

Disk device can now be opened.

```
$ sudo cryptsetup luksOpen /dev/disk/by-id/ata-WDC_WD10EZEX-08M2NA0_WD-WMC3F1471486-part4 luks1
```

## Create new zfs pool

```
$ sudo zpool create ext-backup /dev/mapper/luks1
```

## Create initial snapshot

Example i have data set `tank/ROOT/home`

```
$ sudo zfs snapshot tank/ROOT/home@ext-backup
```

## Send the backup

```
$ sudo zfs send tank/ROOT/home@ext-backup | pv | sudo zfs recv ext-backup/home
```

Or with incremental-backup

```
$ sudo zfs snapshot tank/ROOT/home@ext-backup20180101
$ sudo zfs send -R -i tank/ROOT/home@ext-backup tank/ROOT/home@ext-backup20180101 | sudo zfs recv ext-backup/hom
```

A good idea is to set the external drive to be read-only

```
$ sudo zfs set readonly=on ext-backup
```

## Safely close and remove external drive

After finished sending the snapshot, close the disk and export the pool

```
$ sudo zpool export ext-backup
$ sudo cryptsetup luksClose ext-backup
```

Reference:  
[1]: http://ryan.himmelwright.net/post/zfs-backups-to-luks-external/  
[2]: https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md
