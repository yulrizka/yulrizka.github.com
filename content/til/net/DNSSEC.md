---
layout: post
title: "DNSSEC"
date: 2019-01-13T00:00:00+02:00
language: en
comments: true
tags: til net
description: DNSSEC
keywords: DNSSEC
---
# DNSSEC

> DNSSEC is a technology that was developed to, among other things, protect against such attacks by digitally 'signing' data so you can be assured it is valid. However, in order to eliminate the vulnerability from the Internet, it must be deployed at each step in the lookup from root zone to final domain name (e.g., www.icann.org). Signing the root (deploying DNSSEC on the root zone) is a necessary step in this overall processii. Importantly it does not encrypt data. It just attests to the validity of the address of the site you visit.

It's basically backward compatible addition to the protocol where DNS server can verify the authenticity of the record using asymetric key certificate

There is also as concept of KSK (Key Signing key) a long term key and ZSK (Zone Signing Key) a short term key. They rotate the ZSK using KSK so that it's harder to bruteforce to key
