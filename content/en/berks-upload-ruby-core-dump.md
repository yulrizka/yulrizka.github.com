---
layout: post
title: "berks upload core dump"
date: 2013-07-21T23:26:00+02:00
language: en
comments: true
tags:
  - ruby
  - web
description: Berks ruby core dump while doing berks upload
keywords: berks upload ruby coredump
---

Berksfhel is cookbook dependency for chef. If you are familiar with ruby / python,
think of it as a *Bundler* or *virtual environment* for chef

I faced this core dump error while doing `berks upload`. That command will actualy
push some cookbook to a chef server.

``` 
$ berks upload
/home/user/.rbenv/versions/1.9.3-p362/lib/ruby/gems/1.9.1/gems/celluloid-0.14.1/lib/celluloid/tasks.rb:47: [BUG] Segmentation fault
ruby 1.9.3p362 (2012-12-25 revision 38607) [x86_64-linux]

-- Control frame information -----------------------------------------------
c:0004 p:0112 s:0009 b:0007 l:002040 d:000006 BLOCK  /home/user/.rbenv/versions/1.9.3-p362/lib/ruby/gems/1.9.1/gems/celluloid-0.14.1/lib/celluloid/tasks.rb:47
c:0003 p:0031 s:0005 b:0005 l:002108 d:000004 BLOCK  /home/user/.rbenv/versions/1.9.3-p362/lib/ruby/gems/1.9.1/gems/celluloid-0.14.1/lib/celluloid/tasks/task_fiber.rb:11
c:0002 p:---- s:0003 b:0003 l:000002 d:000002 FINISH
c:0001 p:---- s:0001 b:-001 l:000000 d:000000 ------

-- Ruby level backtrace information ----------------------------------------
/home/user/.rbenv/versions/1.9.3-p362/lib/ruby/gems/1.9.1/gems/celluloid-0.14.1/lib/celluloid/tasks/task_fiber.rb:11:in `block in create'
/home/user/.rbenv/versions/1.9.3-p362/lib/ruby/gems/1.9.1/gems/celluloid-0.14.1/lib/celluloid/tasks.rb:47:in `block in initialize'

....
```

**upgrading** the ruby verison to 2.0 seems to resolve my issue.
