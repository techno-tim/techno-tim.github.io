---
layout: post
title: "Using Pi-Hole for Local DNS - Fast, Simple, and Easy Guide"
date: 2021-04-17 09:00:00 -0500
categories: homelab
tags: homelab pi-hole dns self-hosted
image:
  path: /assets/img/headers/sparks-circle.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APgz9lDwPZePvgx4Nt5dW1zQZPGfhH4x694nsdEl0y28LeLJ7/UtU+E+mWXjLw4dJLa9pXg6LRbXxb4HsYNV0pPC3ia71S70x4vOsG0zhzGkp4nC15Wc414UYyabnTp0efENUZqS9nKsqao1pOM+enZW0afVhajhh8RD3mnCVTl5lySlUtT/AHkXGXPGDlzwipQSlfvp+SfxFXwl4O+IPjrwjbeHdQvbfwt4y8T+HILybxFLFNdw6Hrd9pkVzLFFpvlRyzparLJHH+7R2Kp8oFdr973rtX1sraX1tqr6eZyLZddNz//Z
---

Pi-Hole is a wonderful ad blocking DNS sever for your network, but did you know you can also use it for a Local DNS server? In this fast, simple, and easy guide we'll walk through how to create DNS Entries (A Records) for the clients on your network and also set up Aliases (pointers to A Records) so that you can start using DNS at home instead of relying on IP addresses.

{% include embed/youtube.html id='kKsHo6r4_rc' %}

📺 [Watch Video](https://www.youtube.com/watch?v=kKsHo6r4_rc)

## commands

```bash
nslookup juno.home.lan # lookup by host name
host 192.168.0.100 # reverse lookup
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
