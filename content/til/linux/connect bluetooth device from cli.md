---
layout: post
title: "connect bluetooth device from cli"
date: 2018-10-20T00:00:00+02:00
language: en
comments: true
tags: til linux
description: connect bluetooth device from cli
keywords: linux bluetooh
---

We use bluetoothctl tool which is command-line to BlueZ

```
$ sudo bluetoothctl
```

Enable authentication agent

```
[bluetooth]# agent on
```

Run the scan process
```
[bluetooth]# scan on
```

Pair with the device
```
[bluetooth]# pair 00:25:56:D1:36:6B
```

Connect to the device
```
[bluetooth]# connect 00:25:56:D1:36:6B
```

more information [https://docs.ubuntu.com/core/en/stacks/bluetooth/bluez/docs/reference/pairing/outbound](https://docs.ubuntu.com/core/en/stacks/bluetooth/bluez/docs/reference/pairing/outbound)
