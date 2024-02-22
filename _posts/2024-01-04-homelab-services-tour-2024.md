---
layout: post
title: "HomeLab Services Tour 2024 - What Am I Self Hosting?"
date: 2024-01-04 08:00:00 -0500
categories: homelab
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

Sites:

- [Heimdall](https://heimdall.site/)

Tutorials:

- [Meet Heimdall, Your Homelab Application Dashboard](/posts/heimdall-dashboard/)

### Hypervisor

Sites:

- [Proxmox](https://www.proxmox.com)

Tutorials:

- [Before I do anything on Proxmox, I do this first...](/posts/first-11-things-proxmox/)

### Storage

Sites:

- [TrueNAS SCALE](https://www.truenas.com/truenas-scale/)
- [MinIO](https://min.io/)

Tutorials:

- [TrueNAS Scale Apps - Official, Unofficial, Docker, and Kubernetes](/posts/truenas-scale-apps/)
- [The EASIEST way to Expand Your ZFS Pool in TrueNAS (But is it the Best?)](/posts/truenas-zfs-expand/)

### DNS

Sites:

- [PiHole](https://pi-hole.net/)

- [Cloudflare](https://www.cloudflare.com/)

Tutorials:

- [Automate Cloudflare with Terraform and GitHub Actions! - Terraform Tutorial for Beginners](/posts/terraform-cloudflare-github/)
- [High Availability Pi-Hole? Yes please!](/posts/ha-pi-hold-gravity-sync/)
- [Is adding 3 MILLION domains to your Pi-Hole Block List a good thing?](/posts/pi-hole-blocklists/)

### Network Management

Sites:

- [UniFi Network Controller](https://l.technotim.live/ubiquiti) (affiliate link)

Tutorials:

- [Setting up your UniFi Express](/posts/unifi-express/)
- [Configuring VLANs, Firewall Rules, and WiFi Networks - UniFi Network Application](/posts/vlan-firewall-unifi/)

### Home Security

Sites:

- [UniFi Protect](https://l.technotim.live/ubiquiti) (affiliate link)

Tutorials:

- [My HUGE Home Security Upgrade](/posts/home-security-upgrade/)

### Containerization

Sites:

- [k3s](https://github.com/k3s-io/k3s)
- [Portainer](https://www.portainer.io/)
- [Rancher](https://www.rancher.com/)

Tutorials:

- [Fully Automated K3S etcd High Availability Install](/posts/k3s-etcd-ansible/)
- [High Availability Rancher on Kubernetes](/posts/rancher-ha-install/)
- [How to Update Portainer Fast, Simple, and Easy Guide](/posts/portainer-update/)

### GitOps

Sites:

- [Flux](https://fluxcd.io/)
- [Renovate](https://www.mend.io/renovate/)

Tutorials:

- [The FASTEST way to deploy apps to Kubernetes - GitOps with FLUX](/posts/flux-devops-gitops/)
- [Meet Renovate - Your Update Automation Bot for Kubernetes and More!](/posts/renovate-bot-kubernetes/)
- [Encrypt Your Sensitive Information Before Storing It - Encrypting with Mozilla SOPS and AGE](/posts/secret-encryption-sops/)

### Reverse Proxy (and Ingress Controller)

Sites:

- [Traefik](https://traefik.io/traefik/)
- [cert-manager](https://cert-manager.io/)

Tutorials:

- [Wildcard Certificates with Traefik + cert-manager + Let's Encrypt in Kubernetes Tutorial](/posts/kube-traefik-cert-manager-le/)
- [Put Wildcard Certificates and SSL on EVERYTHING](/posts/traefik-portainer-ssl/)

### Monitoring & Logging

Sites:

- [Uptime Kuma](https://github.com/louislam/uptime-kuma)
- [Uptime Robot](https://l.technotim.live/uptime-robot) (affiliate link)

Tutorials:

- [Meet Uptime Kuma, a Fancy Open Source Uptime Monitor for all your HomeLab Monitoring Needs](/posts/uptime-kuma/)

### Data Visualization

Sites:

- [Loki](https://github.com/grafana/loki)
- [Grafana](https://github.com/grafana/grafana)
- [Prometheus](https://github.com/prometheus/prometheus)
- [Alert manager](https://github.com/prometheus/alertmanager)

Tutorials:

- [Meet Grafana LOKI, a Log Aggregation System for Everything](/posts/grafana-loki/)
- [Installing Grafana Loki with Helm on Kubernetes](/posts/grafana-loki-kubernetes/)
- [Beautiful Dashboards with Grafana and Prometheus - Monitoring Kubernetes Tutorial](/posts/kube-grafana-prometheus/)
- [Monitoring Your Kubernetes Cluster with Grafana, Prometheus, and Alertmanager (Rancher Monitoring)](/posts/rancher-monitoring/)

## Home Automation

Sites:

- [Home Assistant](https://github.com/home-assistant/core)
- [Scrypted](https://github.com/koush/scrypted)
- [Broadlink Control](https://github.com/techno-tim/techno-broadlink)

Tutorials:

- [Home Assistant on Docker and Kubernetes (Open Source Home Automation)](/posts/home-assistant/)
- [Meet Scrypted - Stream ANY Camera to ANY Home Hub](/posts/scrypted-home-hub/)
- [I Built Something for Your Homelab... (Broadlink Control)](/posts/broadlink-control/)

### Data Synchronization

Sites:

- [SyncThing](https://github.com/syncthing/syncthing)

### Links Page

Sites:

- [littlelink-server](https://github.com/techno-tim/littlelink-server)

Tutorials:

- [Self-Hosted, DIY, Open Source Alternative to Linktree](/posts/open-source-linktree-alt/)

### Link Shortener

Sites:

- [Shlink](https://github.com/shlinkio/shlink)

### Media Server

Sites:

- [Plex](https://www.plex.tv/)

Tutorials:

- [Turn Plex into a Powerful DVR](/posts/ota-tv-with-plex/)

### Power Management

Sites:

- [NUT Server](https://networkupstools.org/)
- [Automated NUT install](https://github.com/dzomaya/NUTandRpi)

Tutorials:

- [Network UPS Tools (NUT) Ultimate Guide](/posts/NUT-server-guide/)
- [Automated NUT Server Install](/posts/nut-server-script/)

### Content Management Systems (CMS)

Sites:

- [Wordpress](https://wordpress.org/)
- [Ghost Blog](https://ghost.org/)
- [WikiJS](https://github.com/Requarks/wiki)

### Static Site Generators (SSG)

Sites:

- [Jekyll](https://github.com/jekyll/jekyll)
- [Hugo](https://github.com/gohugoio/hugo)

Tutorials:

- [Meet Jekyll - The Static Site Generator](/posts/jekyll-docs-site/)

### Continuous Integration / Continuous Delivery (CI /CD)

Sites:

- [GitLab](https://gitlab.com/)
- [GitHub](https://github.com/)

Tutorials:

- [Build & Deploy Your Own Code in Your Homelab!](/posts/self-hosted-devops-stack/)

### Everything else...

Sites:

- [Longhorn](https://github.com/longhorn/longhorn)
- [Netboot.xyz](https://github.com/netbootxyz/netboot.xyz)
- much, much more!

Tutorials:

- [Cloud Native Distributed Storage in Kubernetes with Longhorn](/posts/longhorn-install/)
- [Meet netboot xyz - Network Boot Any Operating System](/posts/netbootxyz-tutorial/)
- [much, much more!](/all-posts/)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">What a year of self-hosting! Join me as we walk though my entire infrastructure and services that I have running in my HomeLab! <a href="https://t.co/9b2hGFzoPz">https://t.co/9b2hGFzoPz</a> <a href="https://t.co/zqEVKy8rhy">pic.twitter.com/zqEVKy8rhy</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1742944476199375020?ref_src=twsrc%5Etfw">January 4, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
