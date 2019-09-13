---
layout: post
title: "symbolic vs hard link"
date: 2016-06-01T00:00:00+02:00
language: en
comments: true
tags: til linux
description: symbolic vs hard link
keywords: linux symlink
---

from [http://stackoverflow.com/a/185903/546750](http://stackoverflow.com/a/185903/546750)

> Underneath the file system files are represented by inodes (or is it multiple inodes not sure)
>
> A file in the file system is basically a link to an inode.
> A hard link then just creates another file with a link to the same underlying inode.
>
> When you delete a file it removes one link to the underlying inode. The inode is only deleted (or deletable/over-writable) when all links to the inode have been deleted.
>
> A symbolic link is a link to another name in the file system.
>
> Once a hard link has been made the link is to the inode. deleting renaming or moving the original file will not affect the hard link as it links to the underlying inode. Any changes to the data on the inode is reflected in all files that refer to that inode.

> Note: Hard links are only valid within the same File System. Symbolic links can span file systems as they are simply the name of another file.

