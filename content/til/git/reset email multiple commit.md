---
layout: post
title: "reset email multiple git commit"
date: 2019-01-13T00:00:00+02:00
language: en
comments: true
tags: til git
description: reset email multiple git commit
keywords: git
---

I started not to use my real email for git commit. Instead i uses the one that is provided by [github](https://help.github.com/articles/about-commit-email-addresses/)

After enabling **Block command line pushes that expose my email** on [Block command line pushes that expose my email](https://github.com/settings/emails), it will reject
all email that exposes public email adress.

So in order to rewrite git history and change the author email, I found this [github help](https://help.github.com/articles/changing-author-info/)

```bash
#!/bin/sh

git filter-branch --env-filter '
OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

Another neat way (after you change your email with git config), you can also do this:

```bash
$ git rebase -i -p --exec 'git commit --amend --reset-author --no-edit'
```

