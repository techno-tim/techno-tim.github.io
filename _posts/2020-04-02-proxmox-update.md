---
layout: post
title: "How to Update Proxmox VE (No subscription required)"
date: 2020-04-02 09:00:00 -0500
categories: proxmox
tags: homelab proxmox
image:
  path: /assets/img/headers/typewriter-update.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APg5v+Cun7eXxJ0fwf8As2+Fvi3Z/CvwpB4C0zTdc8W+HPDVlrPxF8Y+GvEXhrT9a/szxJ4h8QzXtmdYg0bWbXw5d+KdF0fRtU1NLC51eVYL/VJfs/PhorCxjThGDhKfsuTl5YL2c/ZN8sWm+ZRk7X05km5crcvBxWc4qrXr4W/JFQj+9jL983WpKorykpRagpqPwXlyuTacvd8Vg/4LcftD+A4IfA1le/E2+s/BkUfhS0vbr4s6E11d23h1Bo8F1ctJ8IZ5GnuIrNJZi80zmR2LSyNlz6n1Kn3l8v8Ag3f4s8qOJxVlavK1la6T6d3q/V6s/wD/2Q==
---

Have you been thinking about updating your Proxmox VE server?  Well, what are you waiting for?  Upgrade your Proxmox server in your home lab in just a few minutes with this step-by-step tutorial!

{% include embed/youtube.html id='rfK8fc-ccoQ' %}

📺 [Watch Video](https://www.youtube.com/watch?v=rfK8fc-ccoQ)

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

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
