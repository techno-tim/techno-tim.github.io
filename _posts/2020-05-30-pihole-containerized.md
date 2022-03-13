---
layout: post
title: "PiHole on Docker and Kubernetes (I almost gave up)"
date: 2020-05-30 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted pi-hole
---

[![PiHole on Docker and Kubernetes (I almost gave up)](https://img.youtube.com/vi/NRe2-vye3ik/0.jpg)](https://www.youtube.com/watch?v=NRe2-vye3ik "PiHole on Docker and Kubernetes (I almost gave up)")

We know you've heard of Pihole and we know you are probably aware of how to install it but... have you tried running it on Docker and Kubernetes using Rancher?  Have you configured it for pfSense?  Don't worry, I figured out all the hard stuff for you.  So let's consolidate some hardware and services.


[Watch Video](https://www.youtube.com/watch?v=NRe2-vye3ik)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

Ubuntu Fix

```bash
sudo apt-get update
```

```bash
sudo apt-get install resolvconf
```

```bash
sudo nano /etc/resolvconf/resolv.conf.d/head
```

enabled & start service

```bash
sudo systemctl enable resolvconf.service
```

```bash
sudo systemctl start resolvconf.service
```

add your upstream DNS (I use Quad9)

```
nameserver 9.9.9.9
```

update resolv.conf after adding nameserver

```bash
sudo resolvconf -u
```

Set pi-hole password

```bash
sudo pihole -a -p
```
