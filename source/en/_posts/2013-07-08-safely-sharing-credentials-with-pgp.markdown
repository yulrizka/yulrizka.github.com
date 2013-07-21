---
layout: post
title: "Safely sharing credentials with PGP"
date: 2013-07-08 16:23
language: en
comments: true
tags: linux, web
description: Safe way to send message or share credentials with teams
keywords: linux, GPG, PGP, authentication share, share password
---

When working in teams, we are sometimes required to share some password / keys with our team.
The most common way for me is probably through email or some chat client. But even though its convenience it's not
actually a secure and a good practice. Especialy if you are providing a service that deal with sensitive information.

Some simple approach would we communicating the password directly with a person through secure medium.
One way to do it is both party ssh through a server and use talk client like [write](http://linux.die.net/man/1/write).
But for some cases it's quite impractical.

## PGP

Enter [PGP](http://en.wikipedia.org/wiki/Pretty_Good_Privacy). It's basically a software that do a Public-key cryptography.
Public-key cryptography is basically encryption process which require 2 keys, one for encrypting and the other one
for decrypting. Usually the __public key__ is used for encrypting and __private key__ is use for decrypting.
I would not dive into the details about it since I've only have basic understanding about it.
But for those people that is interested, you would read the nice article on [wikipedia](http://en.wikipedia.org/wiki/Public-key_cryptography)

There is a open source project called GPG (GNU Privacy Guard) and in this article I would like to show you how we could
share some password / key file with it.

### Instalation

If you don't already have it on your system, you could installed it with:

{% codeblock lang:bash %}
  $ sudo apt-get install gpg
{% endcodeblock %}

After installing we would start by creating a pair of keys
{% codeblock lang:bash %}
  $ gpg --gen-key
{% endcodeblock %}

You will be asked with buch of questions. Most of the answer you could leave it as a default but most important is fill in your **email**
address and also provide a **Passphrase** to protect your key with password. When it finish gathering information, it will start
creating a key pair by using system entropy. You can help the system to generate the entropy by clicking or moving your mouse randomly
or doing some random IO disk by triggering for example `find /`

After installing, you can see list of keys by using this command

{% codeblock lang:bash %}
$  gpg --list-keys
/home/user/.gnupg/pubring.gpg
--------------------------------
pub   2048R/70280895 2013-07-09
uid                  Ahmy Yulrizka (ahmy135@mail.com) <ahmy135@mail.com>
sub   2048R/F7B2D44C 2013-07-09

{% endcodeblock %}

In above ouput you could see that we have created public key with id of `70280895`. Note this one because we are going to use it later
when submitting the key to a key server

To share your public key, so other people could send you encrypted message.

**Note** that futher in this article I will discus ways to easily distribute your public key.

{% codeblock lang:bash %}
$ gpg --armor --export 'ahmy135@mail.com'
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

mQENBFHcRTEBCAC056qG97iJAtb604x5Hr+3lIi3UXVOnGauoHSo5S8S3bSCD0Ib
DzgSjWj8a6Xd1BY+5+HV0amp+i1sTknnd/C2WR7O1h9DIasPlWktPr2T+j4IGnYF
MixinQcBtTBv+hbcxJM7q6+nsdPhaVRz/YJ3/Eo8JHEc1APeH/DAyEtQG6M1kn5O
Iaq5nlmz4DCYW/FQkWwj0Mv3M8IQLYnBd8Nbh0Asgyqncd6mpb2H0+PgRRlUqygp
HslmELMNFg+rYpz/3EB7odIfM9lRy7+TVoMTp9KJyEbHDPfo7pqf+nEmvfeGKgbd
n7ucU7cj3OqMwBYNwjAg3WfEdqBvvIEZDXWTABEBAAG0NUFobXkgWXVscml6a2Eg
KGFobXkxMzVAZ21haWwuY29tKSA8YWhteTEzNUBnbWFpbC5jb20+iQE4BBMBAgAi
BQJR3EUxAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDFQyG1cCgIlRSp
CACOMRoSVY1qfoQV5NY5LGA/ZdIm5aXm2vxYiSSvanOf9u3FM0YwUHIFu0A5sD3c
vK0BUlye28W+ZTRVSMo2VN+QoVIIVKskMD2nOFm/BNahw06uOl+YpI5yM/7N8Aky
PQRoMbPHPcR4Vx6UNSR+/c6yiFKylqCUgHnW8TRFv7yMmh4lU4yhxZqwTg1WlI23
OCZKkMRC2OBgOcZcKqm8Pfc2cwnbz/2UCX0jO9E91qdkle6jNv7WOTU48WHA4urA
5M4XBQMhNwf8QcLwftrUfIC6zWCPtENZDmgdh//bJW8VhmVtxf7CU871fWxzb7JZ
p2rqF+TFooniX5Z5WQmT1mW4uQENBFHcRTEBCACsGfkDV+v4EH7OjX44WMqh7aUU
CVd0d9u/eClkxPcyNTTs7p07+RFTb001K+66lLfMR04IJjJom4sLPROS2o19fOKk
a+QZLkHJydVSjhReXhz9vE/DMna7iWWltd4BZPy+zio46Rkkcztnbz3+oES41+Zr
Vo8AyOV5iksCt/E+lp6oAqEInqEISdk7GlLX5C6ivjiIU4phL/yuij0tqtUa7mJJ
2tROUkQOacYIpPEj0Q3TLhmm+hWcdHHf/OF704Qh8sVxr2O1jd5VCW2ivA6JPWWk
wvWdIzkktzPi9EVOhcxOsggUcrI+ZiVUG4yloUYHKGmRdJyng2SefM0ONlGVABEB
AAGJAR8EGAECAAkFAlHcRTECGwwACgkQxUMhtXAoCJUiqgf/SxdbfXhUGp+oBECc
ZM32KqimNDaxq6CzaydPjCXyzfg89T26aB4Qb6OjyxeBLgmTG14XwLuWscSRk2yt
WRNMY4C114YDW6esQG+8hJlwSze4S5iqsNiyoOwwbAZHQPbnaOfKsc160xk1ijyx
ARuFsrOeVtB7bN1Qec92k0N8OmlGl9vwUQKpIKQd/6HLfIbpxa4E2nLJQQpYCY7E
nCdsA+ckgBcr0wZxroJyowQQRC/mNHsEwBaAut5oEzz4Pr35CVecpaWlnbsYU6j2
RSjlgt/RjJaasXPGzpctxLvcmdG6CLE8OC2mzfgHFnDRRTJLcFmKoqa3HAKV+4iV
Ek1kuQ==
=MctB
-----END PGP PUBLIC KEY BLOCK-----

$ gpg --armor --export 'ahmy135@mail.com' --output pubkey.txt # to output it to a file

{% endcodeblock %}

### Encrypting for a personal use

With those generated keys, we could now do a personal encryption. That is if you want to encrypt a file and you are the only one
who are able to decrypt it.

{% codeblock lang:bash %}
  vagrant@commonSense-local:~/yulrizka.github.com$ echo "this message is secret" > message.txt
  vagrant@commonSense-local:~/yulrizka.github.com$ gpg --encrypt --recipient 'ahmy135@gmail.com' message.txt
{% endcodeblock %}

Those code will create a file name `message.txt.gpg` which is encrypted message of `message.txt`

{% codeblock lang:bash %}
$ gpg --decrypt message.txt.gpg

You need a passphrase to unlock the secret key for
user: "Ahmy Yulrizka (ahmy135@mail.com) <ahmy135@mail.com>"
2048-bit RSA key, ID F7B2D44C, created 2013-07-09 (main key ID 70280895)

gpg: gpg-agent is not available in this session
gpg: encrypted with 2048-bit RSA key, ID F7B2D44C, created 2013-07-09
      "Ahmy Yulrizka (ahmy135@mail.com) <ahmy135@mail.com>"
this message is secret

{% endcodeblock %}

As you can see that we are successfully decrypted the message

### Distributing the key

In order for any body to send you a encrypted message, you need to give your __public key__.
Since __public key__ only used for encryption, It's OK to publicy share your __public key__. 
But never share your __private key__.

You could share your public key manualy to some one (through usb / email etc) by exporting it first just like I mention before.
But there are an easy way to distribute the key. There are some public GPG server that store your public key so that
other people could easily find it and import it into their local machine. There are [http://pgp.mit.edu](http://pgp.mit.edu) 
and also ubuntu key server [http://keyserver.ubuntu.com](http://keyserver.ubuntu.com) that we can use.

To send our key to MIT server we could do

{% codeblock lang:bash %}
$ gpg --send-key --keyserver pgp.mit.edu 70280895
gpg: sending key 70280895 to hkp server pgp.mit.edu
{% endcodeblock %}

the last number `70280895` was the key id of the public file. You could find it with the output of `gpg --list-keys` command.
Now we have successfuly send our public key any body could get your public key through that keyserver. You could test this
by searching a name or email or a person in the key server web interface. for example try searching my name on [http://pgp.mit.edu/](http://pgp.mit.edu/)

### Importing Keys

Now to import other people public key, we could also do that in two way. 

if the person give you a file which contain their public key (say `ahmy-pub.key`). you could import it with

{% codeblock lang:bash %}
$ gpg --import ahmy-pub.key
{% endcodeblock %}

Or if the person already publish his public key to a keyserver, we can search it with

{% codeblock lang:bash %}
$ gpg --search-keys 'Ahmy Yulrizka'

# or
$ gpg --search-keys 'ahmy135@mail.com'

{% endcodeblock %}

It will genereate a list of keys that found on the keyserver. Enter the number of the keys and it will be imported to your local machine.

after importing you can send an encrypted message to the person for example


{% codeblock lang:bash %}
$ echo "This is also a secret" | gpg --encrypt --armor --recipient 'Ahmy Yulrizka' | gpg --decrypt
{% endcodeblock %}

You could provide a name or an email address as a recipient


## Sharing Key or Password to the team

