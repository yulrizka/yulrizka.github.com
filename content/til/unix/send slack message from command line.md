---
layout: post
title: "send slack message from command line"
date: 2016-03-15T00:00:00+02:00
language: en
comments: true
tags: til unix slack
description: send slack message from command line
keywords: slack unix cli
---

Install Incomming webhook to your channel [https://api.slack.com/incoming-webhooks#sending_messages](https://api.slack.com/incoming-webhooks#sending_messages)

you will then get some url `https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX`

create `/usr/local/bin/notifyme`

```
#!/bin/sh

curl -X POST --data-urlencode "payload={\"channel\": \"#alert\", \"username\": \"mybot\", \"text\": \"$*\", \"icon_emoji\": \":name_badge:\"}" https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
```

and send message via your command line

```
$ chmod +x /usr/local/bin/notifyme
$ notifyme hello world!

# or after some command
$ sleep 5; notifyme process is finished
```
