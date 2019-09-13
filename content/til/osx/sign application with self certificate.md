---
layout: post
title: "sign application with self certificate"
date: 2016-04-04T00:00:00+02:00
language: en
comments: true
tags: til osx
description: sign application with self certificate
keywords: certificate osx
---

When compiling binary that open port, (depending on your settings) it will ask to allow if the process can make the connection.

We can sign our binary with certificate to avoid this.


From [http://apple.stackexchange.com/questions/3271/how-to-get-rid-of-firewall-accept-incoming-connections-dialog/121010#121010](http://apple.stackexchange.com/questions/3271/how-to-get-rid-of-firewall-accept-incoming-connections-dialog/121010#121010)

While RedYeti's link is useful, just to save a few clicks for others let me recap how to generate a code-signing cert and to use it for code (re-)signing:

```
1. Create your own code signing cert:
In Keychain Access, Keychain Access > Certificate Assistant > Create a certificate. This launches the Certificate Assistant:

Name: Enter some arbitrary string here that you can remember. Avoid spaces otherwise you'll need to escape the cert's name when using codesign from the command line.

Identity type: Self Signed Root

Certificate Type: Code Signing

Check the box "Let me override defaults", this is quite important

Serial number: 1 (OK as long as the cert name/serial no. combination is unique)

Validity Period: 3650 (gives you 10 years)

Email, Name, etc. fill out as you wish.

Key pair info: set to RSA, 2048 bits. Does not really matter IMHO.

From "Key usage extension" up to "Subject Alternate Name Extension": accept the defaults.

Location: login keychain.

Once it is created, set to "Always trust" in the Login keychain.


2. Re-signing an app: codesign -f -s <certname> /path/to/app --deep

3. Verify that it worked: codesign -dvvvv /path/to/app

Enjoy!
```
