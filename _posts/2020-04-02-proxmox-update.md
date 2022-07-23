---
layout: post
title: "How to Update Proxmox VE (No subscription required)"
date: 2020-04-02 09:00:00 -0500
categories: proxmox
tags: homelab proxmox
---

[![How to Update Proxmox VE (No subscription required)](https://img.youtube.com/vi/rfK8fc-ccoQ/0.jpg)](https://www.youtube.com/watch?v=rfK8fc-ccoQ "How to Update Proxmox VE (No subscription required)")

Have you been thinking about updating your Proxmox VE server?  Well, what are you waiting for?  Upgrade your Proxmox server in your home lab in just a few minutes with this step-by-step tutorial!


[Watch Video](https://www.youtube.com/watch?v=rfK8fc-ccoQ)

See all the hardware I recommend at <https://l.technotim.live/gear>

Edit `/etc/apt/sources.list`

```bash
deb http://ftp.us.debian.org/debian buster main contrib

deb http://ftp.us.debian.org/debian buster-updates main contrib

# security updates
deb http://security.debian.org buster/updates main contrib

# not for production use
deb http://download.proxmox.com/debian buster pve-no-subscription
```

Run

```bash
apt-get update
```

```bash
apt dist-upgrade
```

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.