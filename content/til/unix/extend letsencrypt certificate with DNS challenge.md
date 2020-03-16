---
layout: post
title: "extend letsencrypt certificate with DNS challenge"
date: 2019-04-03T00:00:00+02:00
language: en
comments: true
tags: til unix
description: extend letsencrypt certificate with DNS challenge
keywords: https ssl letsencrypt
---

Assuming the domain name is `yulrizka.com` and the certificate was created with

```bash
$ certbot certonly --standalone --preferred-challenges dns -d yulrizka.com
```

To extend this certificate with DNS challenge 
```bash
# certbot -d yulrizka.com --manual --preferred-challenges dns certonly
```

You will be asked to add TXT record of `_acme-challenge.yulrizka.com`. 

After updating that DNS record, wait couple of minutes and proceed.
