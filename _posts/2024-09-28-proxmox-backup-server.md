---
layout: post
title: "You should be using Proxmox Backup Server"
date: 2024-09-28 08:00:00 -0500
categories: homelab
tags: proxmox homelab
image:
 path: /assets/img/headers/proxmox-backup-server-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyw/Zt+MWiWn7IWt6LrHwV+D/jKf4X+GvjFp3hjxD408MN4k8Q2btY2PjKzuLe41S6uNNt49P8AFXirUdQisF0qSymtna2uIZLto9Sh/Y82bhi6P1apiMHGrHCrEQw9epGFedNOMqk47qc6cacPdfLH2cGot83N8VlNOjjMNGGIpqqsPD2dF1FCpOnUxlWnzTpynBqFKNWvOq6Cj77c17SLnzr84rOw1e1s7S1g8TXyQ21tBBCraP4SlZYoYljjUyz+HpZ5SEUAyTSySuRukkdyWPgPBYDEt4mrQruriG69RrG4mKc6v7ybSjOMUnKT0iklsklofdvhKlRboxxicaT9mm8DhHdU/dWsoylsuspPu29T/9k=
---

After years of ignoring it, I finally switched back to Proxmox Backup Server and reclaimed 6TB of disk space.  Totally worth it.

{% include embed/youtube.html id='KxPl8SHREcE' %}
📺 [Watch Video](https://www.youtube.com/watch?v=KxPl8SHREcE)

## Info

The disk, network, and computational savings are incredible with Proxmox Backup Server and you should be using it if you are running Proxmox VE.  I used NFS for years and only now do I realize how inefficient that is.  This is why I started using Proxmox Backup Server once again.

Helpful links:

- [Proxmox Backup Server Documentation](https://pbs.proxmox.com/docs/)

- [Proxmox Backup Server Prune Simulator](https://pbs.proxmox.com/docs/prune-simulator/)

- [Guide on using NFS for your Proxmox Backup Server Dataset](https://www.derekseaman.com/2023/04/how-to-setup-synology-nfs-for-proxmox-backup-server-datastore.html)
  - I followed this guide but stored the dataset on my TrueNAS server on an NFS share.  The process is almost the same except use TrueNAS instead of Synology.

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">After years of ignoring it, I finally switched back to Proxmox Backup Server and reclaimed 6TB of disk space. Totally worth it.<a href="https://t.co/SSFrkSkutT">https://t.co/SSFrkSkutT</a> <a href="https://t.co/AeMSjPqLOI">pic.twitter.com/AeMSjPqLOI</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1840086612480536811?ref_src=twsrc%5Etfw">September 28, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
