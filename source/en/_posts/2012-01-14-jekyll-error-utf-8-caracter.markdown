---
layout: post
title: "Jekyll error utf-8 caracter"
date: 2012-01-14 17:32
language: en
comments: true
tags: [ruby, web]
description: jekyll invalid multibyte char (US-ASCII)
keywords: jekyll, invalid multibyte char, error
---

If you having a problem in jekyll when it didn't generate a post and there is no error in the log file. 
you might want to check the content if there is any UTF-8 character encoding such as this **±**

The problem arise if you use ruby 1.9. It rejecting a file that contain non-ASCII character. 
it actually got `invalid multibyte char (US-ASCII) error message`

to solve this. I added this line to `.bashrc` or `zshrc` if you are using zsh

{% codeblock lang:bash %}
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
{% endcodeblock %}

It should fix the problem now.