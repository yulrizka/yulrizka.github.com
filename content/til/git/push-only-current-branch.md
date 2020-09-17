---
layout: post
title: "Push Only Current Branch"
date: 2020-09-17T13:28:16+02:00
language: en
comments: true
tags: til
description: push only current branch
keywords: git,til
draft: false
---

Git has multiple strategy whey you do `git push`

Before git 2.0, it was `matching` meaning that it will push all the
local branch that has the same name as remote. I don't like this because most
of the time i just want to push my current branch and avoid mistakenly local
branches that is not ready to be push yet.

After 2.0 it changes to `simple` it will push the current branch to upstream
with added safety so that it will refuse to push if the upstream branch name is 
different from the local one. This is ok but when you created a new branch, 
it will ask you to explicitly set the upstream branch first.

My workflow is my local branch is going to be always the same name as the
remote, and if not exist it should be created automatically. this is why
i like the `current` strategy. To change this use

```
git config --global push.default current
```

from the git documentation

 push.default

 Defines the action git push should take if no refspec is given (whether from the command-line, config, or elsewhere). Different values are well-suited for specific workflows; for instance, in a purely central workflow
  (i.e. the fetch source is equal to the push destination), upstream is probably what you want. Possible values are:

  - **nothing** - do not push anything (error out) unless a refspec is given. This is primarily meant for people who want to avoid mistakes by always being explicit.

  - **current** - push the current branch to update a branch with the same name on the receiving end. Works in both central and non-central workflows.

  - **upstream** - push the current branch back to the branch whose changes are usually integrated into the current branch (which is called @{upstream}). This mode only makes sense if you are pushing to the same repository
      you would normally pull from (i.e. central workflow).

  - **tracking** - This is a deprecated synonym for upstream.

  - **simple** - in centralized workflow, work like upstream with an added safety to refuse to push if the upstream branch’s name is different from the local one.

    When pushing to a remote that is different from the remote you normally pull from, work as current. This is the safest option and is suited for beginners.

    This mode has become the default in Git 2.0.

  - **matching** - push all branches having the same name on both ends. This makes the repository you are pushing to remember the set of branches that will be pushed out (e.g. if you always push maint and master there and no
    other branches, the repository you push to will have these two branches, and your local maint and master will be pushed there).
    
    To use this mode effectively, you have to make sure all the branches you would push out are ready to be pushed out before running git push, as the whole point of this mode is to allow you to push all of the branches
    in one go. If you usually finish work on only one branch and push out the result, while other branches are unfinished, this mode is not for you. Also this mode is not suitable for pushing into a shared central
    repository, as other people may add new branches there, or update the tip of existing branches outside your control.

    This used to be the default, but not since Git 2.0 (simple is the new default).

