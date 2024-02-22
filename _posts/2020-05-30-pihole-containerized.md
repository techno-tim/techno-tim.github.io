---
layout: post
title: "PiHole on Docker and Kubernetes (I almost gave up)"
date: 2020-05-30 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted pi-hole
image:
  path: /assets/img/headers/fire-ring.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4bPA13bD4ceOXn0vSrm30KDUZr5Z9K0i41DV5/GGn2nhnw6U1m80661HSIvBOrQy+JbWPT5VbU57q4sjLpxc3p+Dz+jVfFGQRp4vGUqmYTw0KDp4zGU8NgqeS4mtmmZqWBo4mjhsbPPsHUjldWeJg1hKdKnXUcTyqgfaZNiYU+HM2UsLhatPCvGPEKphsLOvjJZtg6OAy++Kq4epiMNDJcVSnmNCNCadarXqU1LDtus/Eq+8Piz//Z
---

We know you've heard of Pihole and we know you are probably aware of how to install it but... have you tried running it on Docker and Kubernetes using Rancher?  Have you configured it for pfSense?  Don't worry, I figured out all the hard stuff for you.So let's consolidate some hardware and services.

{% include embed/youtube.html id='NRe2-vye3ik' %}

📺 [Watch Video](https://www.youtube.com/watch?v=NRe2-vye3ik)

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

```bash
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

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
