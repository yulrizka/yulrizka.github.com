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

```
gpg --gen-key
```

## List keys

```
gpg --list-keys
```

## Encrypt Data
With a passprhare
```
gpg -ca -o output.txt.gpg input.txt
```

with a certificate and from STDOUT
```
gpg -ea 
```

or if you know the name already (can be key, name or email)
```
gpg -ea -r "Ahmy"
```

## Decrypt Data
```
gpg -d file.txt.gpg
```

## Export

Public key
```
gpg --export -a "name" > public.key
```

`-a` is to create armored ascii output.

Private Key

```
gpg --export-secret-key -a "name" > private.key
```

## Import

Public key
```
gpg --export-secret-key -a "rtCamp" > private.key
```

Private Key
```
gpg --allow-secret-key-import --import private.key
```

## Deleting

Public Key
```
gpg --delete-key "Real Name"
```

Private Key
```
gpg --delete-secret-key "Real Name"
```


