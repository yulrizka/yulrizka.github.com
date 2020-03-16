---
layout: post
title: "encription with gpg"
date: 2019-01-06T00:00:00+02:00
language: en
comments: true
tags: til unix gpg
description: encription with gpg
keywords: gpg
---

## Generate key

```bash
$ gpg --gen-key
```

## List keys

```bash
$ gpg --list-keys
```

## Encrypt Data
With a passprhare
```bash
$ gpg -ca -o output.txt.gpg input.txt
```

with a certificate and from STDOUT
```bash
$ gpg -ea 
```

or if you know the name already (can be key, name or email)
```bash
$ gpg -ea -r "Ahmy"
```

## Decrypt Data
```bash
$ gpg -d file.txt.gpg
```

## Export

Public key
```bash
$ gpg --export -a "name" > public.key
```

`-a` is to create armored ascii output.

Private Key

```bash
$ gpg --export-secret-key -a "name" > private.key
```

## Import

Public key
```bash
$ gpg --export-secret-key -a "rtCamp" > private.key
```

Private Key
```bash
$ gpg --allow-secret-key-import --import private.key
```

## Deleting

Public Key
```bash
$ gpg --delete-key "Real Name"
```

Private Key
```bash
$ gpg --delete-secret-key "Real Name"
```

