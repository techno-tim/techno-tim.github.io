---
layout: post
title: "HomeLab Services Tour 2024 - What Am I Self Hosting?"
date: 2024-01-04 08:00:00 -0500
categories: homelanb
tags: homelab hardware network server self-hosted kubernetes k3s linux
image:
 path: /assets/img/headers/homelab-services-2024-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5qPgv4x8BD4H61d65+zz8H/Fuq+HtL1Oyu9b8Qa/8AtF2+p+J7qwOn61DrGvReFfj/AOGNDGoiBZtCMej6LpOlNpFzIz6Y+rxWmq2/PKdppcqev6v8fW5pG/LJ3asn28v8z4EvNT1O4vLu4hvrqwhnuZ5orG1u797azjllZ47W3a7vLq7aC3VhDE11c3FwY0UzTyyFpGq8f5fxZmf/2Q==
---

What a year of self-hosting!  Join me as we walk though my entire infrastructure and services that I have running in my HomeLab!  This time I also include network diagrams and dive deep into which services I have running, where they are running, and why I chose them!

{% include embed/youtube.html id='MpaAu3HVDYE' %}
📺 [Watch Video](https://www.youtube.com/watch?v=MpaAu3HVDYE)

In case you missed it, check out my [HomeLab Hardware Tour (late 2023)](/posts/homelab-hardware-tour-2023/)!

## Logical Network Diagram

Here is the diagram for my network!

![Network Diagram (Logical) 2024](/assets/img/posts/network-diagram-logical-2024.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAoACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7U/h/8afB1tYw2/jz4kWFp440LVb/wx4w03xXa+H/AniY6zrnifSdO8LjV/Bmk6zq1vHc3Fjqngu00Ke1vL2SfSvEuk3tytlNrT2tt+qcScDZ/Uxrnw7wxWr8O5jg6Oa5Ni8nrZjxBlawWAyrG4vNfqeeYvB4KpKlRrYTOqmYUq2Go8mLy3F0qLr08D7ap+U8NcdcP08EocRcU0KPEeW42tlOdYTN6OXcP5o8bmOa4LCZSsbkWDxmOpwrVqOLySll9WliazlhMzwdWsqFTMPYU/wAvbf4UePbu3gu0+KHxpiS6hiuEiuPh7qyXEazIsixzo/imR1mQMFlV5HZXDBnYgsf6kxHF3D9HEV6UuFeEpypVqtOUqPEPNRk4TlFypOngadN0m1em4U6cHFpxhFWiv5Sw/B3EFbD0Kq4s4wgqtGlUUK2QONaKnCMlGrGpjqlSNWKdqkZ1Kk1JNSnKV5P72+Hek6Uf2xvi7qh0zTzqcOtXSxaibO2N9ELr4X/CyK6Ed35f2hBcx2lrHcBZAJktrdJNywxhfwXiTE4n/iC/BuH+sV/q88JT56HtansZ+x4n4plR5qXNyS9lKtWlTvF8jq1HGznK/wC/cNYXDf8AEb+M8R9XofWIYqpyV/ZU/bR9twtwrGty1eXnj7WNGjGpaS51SpqV1CNvvGvwE/oU/wD/2Q==" }
_A logical Network Diagram of my HomeLab including VLANs and servers_

Since many have asked, I use [Figma](https://l.technotim.live/figma) to design my network diagrams. (affiliate link but they have a free plan)

## Services I use

Here's a breakdown of all the services I use

### Dashboard

- [Heimdall](https://heimdall.site/)

### Hypervisor

- [Proxmox](https://www.proxmox.com)

### Storage

- [TrueNAS SCALE](https://www.truenas.com/truenas-scale/)
- [MinIO](https://min.io/)

### DNS

- [PiHole](https://pi-hole.net/)
- [Cloudflare](https://www.cloudflare.com/)

### Network Management

- [UniFi Network Controller](https://l.technotim.live/ubiquiti) (affiliate link)

### Home Security

- [UniFi Protect](https://l.technotim.live/ubiquiti) (affiliate link)

### Containerization

- [k3s](https://github.com/k3s-io/k3s)
- [Portainer](https://www.portainer.io/)
- [Rancher](https://www.rancher.com/)

### GitOps

- [Flux](https://fluxcd.io/)
- [Renovate](https://www.mend.io/renovate/)

### Reverse Proxy (and Ingress Controller)

- [Traefik](https://traefik.io/traefik/)
- [cert-manager](https://cert-manager.io/)

### Monitoring & Logging

- [Uptime Kuma](https://github.com/louislam/uptime-kuma)
- [Uptime Robot](https://l.technotim.live/uptime-robot) (affiliate link)

### Data Visualization

- [Loki](https://github.com/grafana/loki)
- [Grafana](https://github.com/grafana/grafana)
- [Prometheus](https://github.com/prometheus/prometheus)
- [Alert manager](https://github.com/prometheus/alertmanager)

## Home Automation

- [Home Assistant](https://github.com/home-assistant/core)
- [Scrypted](https://github.com/koush/scrypted)
- [Broadlink Control](https://github.com/techno-tim/techno-broadlink)

### Data Synchronization

- [SyncThing](https://github.com/syncthing/syncthing)

### Links Page

- [littlelink-server](https://github.com/techno-tim/littlelink-server)

### Link Shortener

- [Shlink](https://github.com/shlinkio/shlink)

### Media Server

- [Plex](https://www.plex.tv/)

### Power Management

- [NUT Server](https://networkupstools.org/)

### Content Management Systems (CMS)

- [Wordpress](https://wordpress.org/)
- [Ghost Blog](https://ghost.org/)
- [WikiJS](https://github.com/Requarks/wiki)

### Static Site Generators (SSG)

- [Jekyll](https://github.com/jekyll/jekyll)
- [Hugo](https://github.com/gohugoio/hugo)

### Continuous Integration / Continuous Delivery (CI /CD)

- [GitLab](https://gitlab.com/)
- [GitHub](https://github.com/)

### Everything else...

- [Longhorn](https://github.com/longhorn/longhorn)
- [Netboot.xyz](https://github.com/netbootxyz/netboot.xyz)
- much, much more!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">What a year of self-hosting! Join me as we walk though my entire infrastructure and services that I have running in my HomeLab! <a href="https://t.co/9b2hGFzoPz">https://t.co/9b2hGFzoPz</a> <a href="https://t.co/zqEVKy8rhy">pic.twitter.com/zqEVKy8rhy</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1742944476199375020?ref_src=twsrc%5Etfw">January 4, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
