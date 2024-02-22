---
layout: post
title: "Proxmox Backup Server Install Tutorial"
date: 2020-07-25 09:00:00 -0500
categories: proxmox
tags: homelab proxmox
image:
  path: /assets/img/headers/floppy-red.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP65L3wp4k1v4yfDvxdp/wASvGfh3SPC2garLd/D/S74xeCvFM8eoQW1zd+JNLhe2Op3b2Gsta6ebyS5stKltodQisZr+K2uLXy54OtXxWCqQxlSjSgpyq4eMLwrqHKlGT5420qyu7STcacuXmgmfVYLNcFhMjzbD1clwOLxFSt9VpZhVv8AW8Msdh/aQlRlKFSFP6riMtpVacqcYV3Cti8PHEU6GKrwqfRjtMzu3nEZZjgAYGSTgc9BXrewp/ynyPtan834L/I//9k=
---

Proxmox Backup Server is an enterprise-class client-server backup software that backs up virtual machines, containers, and physical hosts.In this step by step tutorial, we install and configure Proxmox Backup Server (PBS) and back up all of our virtual machines. We'll start with nothing and end up with a fully functional Proxmox Backup Server with a ZFS datastore you can use to back up and restore your machines today.

{% include embed/youtube.html id='jLBNm0fNIog' %}

📺 [Watch Video](https://www.youtube.com/watch?v=jLBNm0fNIog)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
