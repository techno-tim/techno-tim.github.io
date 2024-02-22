---
layout: post
title: "How to Upgrade FreeNAS to TrueNAS"
date: 2020-08-01 09:00:00 -0500
categories: truenas
tags: homelab truenas
image:
  path: /assets/img/headers/hardware-circuit.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APi3wV+1TaaBH8P9Q8M+EPE2mTW89/piTXvjLwdrGoST/Dux8Ia3aavd6tcfCCHU73VNfeWGz8TXFzcyDVLWBt6rPdXMsgB9CTf8FGPjdqM0uoHxb8QrQ30j3htbTWvhOtrbG6Yzm3thP8CZ5hbw7/LhE080ojVRJLI+XIB//9k=
---

Want to migrate FreeNAS to TrueNAS today?  It's simple using this step by step tutorial.We'll walk through how to upgrade FreeNAS to TreNAS CORE.We'll cover upgrading FreeNAS to TrueNAS on a physical machine (bare metal) as well as a virtualized install of FreeNAS. We'll prepare our services, jails, plugins, virtual machines, pools, and disks for the migration and then upgrade each.We'll even show you how to do an offline upgrade of TrueNAS and then how to upgrade a ZFS pool with newer feature flags.Finally we'll walk through what's different between TrueNAS and FreeNAS.

{% include embed/youtube.html id='SsxvPhlOiYI' %}

📺 [Watch Video](https://www.youtube.com/watch?v=SsxvPhlOiYI)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
