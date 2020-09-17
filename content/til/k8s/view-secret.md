---
layout: post
title: "View kubernetes secret"
date: 2020-09-17T13:58:03+02:00
language: en
comments: true
tags: k8s til
description: viewing kubernetes secret
keywords: k8s secret
draft: false
---

List secrets

```
$ kubecetl get secrets
```

View particular secret
```
$ kubectl describe secret foo

Name:         foo
Namespace:    foonamespac
Labels:       <none>
Annotations:  
Type:         Opaque

Data
====
DB_PASSWORD:  25 bytes
```

to view the content of a secret

```
kubectl get secret foo -o jsonpath="{.data.DB_PASSWORD}" | base64 --decode
someSecurePassword
```
