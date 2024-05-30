---
layout: post
title: "HomeLab Services Tour Late 2021 - What am I Self-Hosting in my HomeLab?"
date: 2021-12-04 8:00:00 -0500
categories: homelab
tags: homelab proxmox grafana logging dns dashboard kubernetes certificates shlink littlelink-server portainer self-hosted docker rancher pi-hole heimdall plex truenas jekyll grafana loki monitoring uptime-kuma traefik nas unifi virtualization containerization
image:
  path: /assets/img/headers/neon-handshake.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5wPhL8Uvh18PvhN8UNA1T4EeD/AB54z8X6Bb6doXxC8T6tqk134MN3FcWGo31hovlS2t5qMkVybnT7kXdgdO1GGC7K3ixLb15lGq+SuqkY1Zc0/ZykreyTjooqNl7t9JP3rpNu2h59SEIukqceRunBzd+b2jWspTcrybk1tfkSduU+Xzr2o9pdo7KqqFUdlUbeABwB2FYfVKPWKb6tptvzbvq2arHV1opNJaJJ7fgf/9k=

---

After showing off my Home Lab hardware in my late 2021 tour, many of you asked what services are self-hosted in this stack. This is always a moving target so I decided it was time to share which services I am running here at home.Today, we walk through everything I am hosting including:  Dashboard, Hypervisor, Virtualization, Containerization, Network Attached Storage (NAS), DNS, Network Management, Home Security, Kubernetes, Kubernetes Storage, Docker, Reverse Proxy, Certificates, Monitoring, Logging, Syncing Data, File Sharing, Self-Promotion (Contact Page), Link Shortening, Home Entertainment, Home Automation, Battery / UPS Monitoring, CMS, Static Site Generators, Dynamic DNS, CI/CD, and many, many others.Enjoy the virtual tour!

Worth mentioning, I [have videos on almost every service mentioned in this video](https://l.technotim.live/subscribe)!

{% include embed/youtube.html id='IE5y2_S8S8U' %}

📺 [Watch Video](https://www.youtube.com/watch?v=IE5y2_S8S8U)


## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
