---
layout: post
title: "Tracking origin of bugs with git bisect"
date: 2015-01-16 23:35
language: en
comments: true
tags: git
description: Determine which commit was the bug introduced 
keywords: git, bisect, bug tracking
---

<div class="thumbnail" align="center">
  <img src="https://c1.staticflickr.com/7/6117/6342791406_599137f28d_n.jpg" width="500" height="328" alt="Disect"></a>
  <div class="caption">Disect the rocket, image by <a href="https://www.flickr.com/photos/proudlove/6342791406/in/photolist-aEusUw-fMT4UA-4mPmFs-zVfQK-4gfRK3-4gg1BC-dopM92-5zQHdK-eP8wta-6aQiE-da7WW5-L7fpN-aWzyh-27sZV-6aQes-4ofRQM-3Szag-fHd5n-bn2juW-q9DEK-CqpV6-8uiAu1-DxAh-5CfTu7-5H7Trn-24h5o-5CbB5H-5CbB9v-5nu4sT-5DKzEZ-5CbAWz-9QghGk-5CbAQR-5CbAZP-fkfbk-bnDX2V-3gst8Z-483285-boVvSK-boVwtp-crKHxQ-fgchqD-boW4uM-boVV5H-boW4Yv-boVVmX-boVUNF-boW4JB-o8v6b7-5s9DiF">ProudloveNathan Proudlove</a></div>
</div>

I've been involved with a iOS project this past week. I'm adding functionality to the [CommonSense iOS library][cs-ios-lib].
One of the most annoying thing is that it took about 2 minute to load the project. But this is only happened in the unstable branch.
The master branch seems to be working fine. So I knew that somewhere there is a commit when this starts happening.

Now this is a good example where `git bisect` is very useful. It will perform a binary search through commit history until the first
bad commit found. So you start with a commit and you marked is as a '_good_' or '_bad_'. Every time you mark a commit as good / bad. 
It will then checkout a commit at some point on the history using the binary search algorithm. In each checkout then you test the code and see
whether the bugs exist or not.

Here is an example

``` bash
# let's start to bisecting, Im in unstable branch,
➜ sense-ios-library git:(unstable) $ git bisect start

````

the `sense-ios-library` show the current folder, and `git:(unstable)` show current commit. it's part oh [oh-my-zsh][oh-my-zsh] plugin


``` bash
# I open the xcode, and it took quite a long time. so let's marks current revision as bad
➜ sense-ios-library git:(unstable) $ git bisect bad

# I know the master branch don't have this problem, so let's mark it as good
➜ sense-ios-library git:(unstable) $ git bisect good master 

Bisecting: 9 revisions left to test after this (roughly 3 steps)
[c1841c0f99a4fa788c14c7437fac7c9547c768c9] Merge pull request #45 from senseobservationsystems/feature-KeepDataLocally

# now I'm in c1841 commit, I tested again with xcode, and found no problem, mark it as good

➜  sense2 git:(c1841c0) $ git bisect good

Bisecting: 4 revisions left to test after this (roughly 2 steps)
[06bbd23c4af8f7008abfb814e1375b271e0b23e9] Update interface and write tests lsit( APPEND CMAKE_CXX_FLAGS "-std=c++0x")

# tested again, it's good
➜  sense2 git:(06bbd23) $ git bisect good

Bisecting: 2 revisions left to test after this (roughly 1 step)
[71517b7923143a8cf1ce205341dd6942c9468198] Added threshold for checking to remove old data from local storage to save battery life

# Tested again, Now I'm beginning to see the problem. Let's mark this bad
➜  sense2 git:(71517b7) $ git bisect bad

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[e5c40d450193ac14fc2faa8c1f4dba2c7c2646f1] Updated functionality and tests of getting local data

# .... 
# and we keep doing this until we find the first commit when it was introduced.

# Now let's check our progress using log

# let's check our progress so far

➜  sense-ios-library git:(71517b7) $ git bisect log

git bisect start
# bad: [af42213324297e1234767f9224ec1af326514292] Merge pull request #48 from senseobservationsystems/feature-LocalStorageInterface
git bisect bad af42213324297e1234767f9224ec1af326514292
# good: [19f751627d152b89d3f2ecadb144507fcf9293fc] Merge pull request #43 from senseobservationsystems/unstable
git bisect good 19f751627d152b89d3f2ecadb144507fcf9293fc
# good: [c1841c0f99a4fa788c14c7437fac7c9547c768c9] Merge pull request #45 from senseobservationsystems/feature-KeepDataLocally
git bisect good c1841c0f99a4fa788c14c7437fac7c9547c768c9
# good: [06bbd23c4af8f7008abfb814e1375b271e0b23e9] Update interface and write tests lsit( APPEND CMAKE_CXX_FLAGS "-std=c++0x")
git bisect good 06bbd23c4af8f7008abfb814e1375b271e0b23e9

# when you reach the final commit, you will be shown the commit log and modified file

➜  sense2 git:(e5c40d4) $ git bisect bad

e5c40d450193ac14fc2faa8c1f4dba2c7c2646f1 is the first bad commit
commit e5c40d450193ac14fc2faa8c1f4dba2c7c2646f1
Author: Jhon Doe <jhon-doe@sense-os.nl>
Date:   Thu Jan 8 14:38:07 2015 +0100

    Updated functionality and tests of getting local data

:040000 040000 0a82ee52c68bae4dacc1fec603ce0747b1df426c cd55743c27d2ba7554dfc3d021616b62957c4bba M  Sense Library Tests
:040000 040000 8a01944a75e80534124a7a657254e38002518f62 5d14fb11caa352acc7352c85e6a1c08794ae9e65 M  SensePlatform.xcodeproj
:040000 040000 a5e3eb78c4c352e7c010b8a4e90c12248f0ec9b0 2174d7ad531a7d989d313c826445434a073b433c M  SensePlatformTestAppTests
:040000 040000 4a40764a31981c172a089cd834eb9666b081f3f5 0713beb3c64f1b6f1d2a7811f59be4a82ec30d66 M  sense platform

```

Now that you know when was the bug introduced. you can now start looking at the problem. I found out there is something that doesn't
feel right here [github:commit/e5c40][github-commit]. There is a reference to `Xcode.app` in on of the folder. So every time I open the project,
or switch branch. It will try to index all the things inside `Xcode.app`. So removing the reference indeed solve the problem. 

The _bisect_ function is very versatile tool to track down when a bug was introduced. You can event automate the test so you don't
have to check each bisect commit your self. The [_bisect_ documentation][bisec-documentation] provide a good explanation about the command
and also an example on how to automate the test.

Now go on catch and squash those annoying bug!


[cs-ios-lib]: https://github.com/senseobservationsystems/sense-ios-library
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[github-commit]: https://github.com/senseobservationsystems/sense-ios-library/commit/e5c40d450193ac14fc2faa8c1f4dba2c7c2646f1?diff=unified#diff-13dddd16767af84fe2be0e8f0f0c8946R469
[bisec-documentation]: http://git-scm.com/docs/git-bisect