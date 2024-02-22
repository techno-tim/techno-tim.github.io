---
layout: post
title: "How to Virtualize Your Home Router / Firewall Using pfSense"
date: 2020-05-16 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes
image:
  path: /assets/img/headers/brick-door.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APjzV7688TeIfha0mo6zpNst/wCIZ5tP0PWdQ0yw1J7DUPAMcI1myt5VtNVjMMr28kVzAY3ty0JXZJLv/MMwxFSj9WULJV8TGnUvd3i3BNaW6Sdr3S7dv2ujg6NerifarmdDBKpTaVrSXtZJpa2eiV1Z9brY91/te7k/eSeXLJJ88ksqGSWR2+Znkkdi8kjsSzuxLMxLMSSTX0KpKys2lbRK+i7aNLTySOJzSbXK9G1o7LTTRWdl5Xfqz//Z

---

It's time to say goodbye to your home router and start virtualizing it using Proxmox and pfSense.

pfSense Community Edition Download: <https://www.pfsense.org/download/>
Get started with Proxmox today: <https://www.youtube.com/watch?v=hdoBQNI_Ab8>

{% include embed/youtube.html id='hdoBQNI_Ab8' %}

📺 [Watch Video](https://www.youtube.com/watch?v=hdoBQNI_Ab8)

## Enable PCI Passthrough

[https://pve.proxmox.com/wiki/PCI(e)_Passthrough](https://pve.proxmox.com/wiki/PCI(e)_Passthrough)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
