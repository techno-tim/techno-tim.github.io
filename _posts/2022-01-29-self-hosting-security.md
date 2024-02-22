---
layout: post
title: "Self-Hosting Security Guide for your HomeLab"
date: 2022-01-29 8:00:00 -0500
categories: homelab
tags: homelab hardware security self-hosted
image:
  path: /assets/img/headers/home-hill.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APAfEn/BSb9qf4m/G74V/Er4m+O7rW/HXwjXwnf+Fm8L+X4H8EalLoeq32vKPF/gfT4r6214aleap5erNb6ppL3dnYadaBo4bcrJ+QZzn2YQx0K3LgpywVSk6U5Yeftk4yjWSVSNeKjCTlyVYxpp1Ka5XJKTP0TJM8zDKMqzPJcJXqRy/OaGLo4/CurU9hWWKw6wjqVKMZRp1auHhFVcJKqqkaFflrKDlCNvoS6/4Lkft8R3VzHHq3wbEaXEyRh/hnfO4RZGVQ7jxkgdgoG5gihjkhVzgetT4vzJwg5UsK5OEW2oVFdtK7t7XTXp0PlJZbRUpJTqWTa3j0f+E//Z
---

When most people think about self-hosting services in their HomeLab, they often think of the last mile. By last mile I mean the very last hop before a user accesses your services. This last hop, whether that’s using certificates or a reverse proxy, is incredibly important, but it’s also important to know that security starts at the foundation of your HomeLab.Today, we'll work our way up from hardware security, to OS, to networking, to containers, to firewalls, IDS/IPS, reverse proxies, auth proxies for authentication and authorization, and even lean in to an external provider like Cloudflare.

A HUGE thanks to Micro Center for sponsoring this video!

New Customers Exclusive – Get a Free 240gb SSD at Micro Center: <https://micro.center/0ef37a>

{% include embed/youtube.html id='Cs8yOmTJNYQ' %}

📺 [Watch Video](https://www.youtube.com/watch?v=Cs8yOmTJNYQ)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
