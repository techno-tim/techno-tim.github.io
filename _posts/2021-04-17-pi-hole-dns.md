---
layout: post
title: "Using Pi-Hole for Local DNS - Fast, Simple, and Easy Guide"
date: 2021-04-17 09:00:00 -0500
categories: homelab
tags: homelab pi-hole dns self-hosted
---

[![Using Pi-Hole for Local DNS - Fast, Simple, and Easy Guide](https://img.youtube.com/vi/kKsHo6r4_rc/0.jpg)](https://www.youtube.com/watch?v=kKsHo6r4_rc "Using Pi-Hole for Local DNS - Fast, Simple, and Easy Guide")

Pi-Hole is a wonderful ad blocking DNS sever for your network, but did you know you can also use it for a Local DNS server? In this fast, simple, and easy guide we'll walk through how to create DNS Entries (A Records) for the clients on your network and also set up Aliases (pointers to A Records) so that you can start using DNS at home instead of relying on IP addresses.

[Watch Video](https://www.youtube.com/watch?v=kKsHo6r4_rc)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## commands

```bash
nslookup juno.home.lan # lookup by host name
host 192.168.0.100 # reverse lookup
```
