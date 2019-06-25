---
layout: post
title: "Sharing credentials with teams"
date: 2013-07-30T18:33:00+02:00
language: en
comments: true
tags: web, security
description: Ways to share password, keys or other account credentials with team mate
keywords: sharing password, sharing credentials, pgp, gpg, yulrizka
published: false
---

In the [previous post](1) I go into the details of using PGP to encrypt and decrypt a message.
Now in this article I wanted to share some ideas on how we could share sensitive information with our team.

When we're work together, sometimes we need to share some private information. Likes admin account password,
user and password to access server database etc. The most convenience way to share password if often through e-mail or instant messaging.
And usually we left that information on our inbox so that we could search for it when ever we needed it. Even for some service like Gtalk/Hangout,
It kept the transcript history in the inbox.

This is probably not a good practice. Because once an attacker get hold of your email, he/she could use that information to your server.
Especially when you are providing a service that store user's sensitive information. We could minimize those risk by not storing the
credentials in plain text.

Probably there is already security guidelines or standards on how to share credentials securely with other person in team.
But by the time I'm writing this I couldn't find it. Or at least a simple solution that we could implement in small team.
Below are just my two cent about getting around the problem.

## Storing the credentials in a central server

We could store the credentials in a secure centralized server and restrict access to only our team. For example we could run a small server
(or a raspberry Pi even) on the office and put it only on internal network. User that are allowed to use those credentials must have access to the server.

upside:

 * simple setup. You probably already have desktop computer in the office that can be used for this purpose.





[1]: /en/2013/07/safely-sharing-credentials-with-pgp.html
