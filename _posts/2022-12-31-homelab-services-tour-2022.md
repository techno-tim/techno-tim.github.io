---
layout: post
title: "Techno Tim HomeLab Services Tour (Late 2022) - What am I Self-Hosting in my HomeLab?"
date: 2022-12-31 09:00:00 -0500
categories: homelab
tags: homelab hardware network server self-hosted kubernetes k3s linux
image:
  path: /assets/img/headers/services-tour-map.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP1k+H/iS88O+BzpfhufUvDo022uLWC40fV7u3aO40+a4H9ppby+fa3Oo3E6PdXFxrUOsG/ldU1saxboYX/oXEYaFanNzbbace8Lx2fs5c1NtPX34zTslPmikl+QwajKnFwpzhHlklOEedqaTcHWio1VFvpTlT5W5TpezqSc30tx8fPGyTzJ9oZtk0i5Nw+Ttdhk5QnJxk5JPua8v+y8v/6A6H/gtL8FZL0SS7HJer/z+qfOzfzfV+Z//9k=

---

Wow, what a year of self-hosting! After showing off my Home Lab hardware in my late 2022 tour, many of you asked what services are self-hosted in this stack. This is always a moving target so I decided it was time to share which services I am running here at home.Today, we walk through everything I am hosting including:  Dashboard, Hypervisor, Virtualization, Containerization, Network Attached Storage (NAS), DNS, Network Management, Home Security, Kubernetes, Kubernetes Storage, Docker, Reverse Proxy, Certificates, Monitoring, Logging, Syncing Data, File Sharing, Link Page, Link Shortening, Home Entertainment, Home Automation, Battery / UPS Monitoring, CMS, Static Site Generators, Dynamic DNS, CI/CD, Git Ops, Dev Ops, and many, many others.Enjoy the virtual tour!

Worth mentioning, I have videos on almost every service mentioned in this video!

{% include embed/youtube.html id='yrMRZVvkxeA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=yrMRZVvkxeA)

## Related Videos

Here are most of the videos mentioned in this video:

- [Techno Tim HomeLab Server Room Tour! (Late 2022)](https://www.youtube.com/watch?v=dzh3so5wOro)
- [Self-Hosting Security Guide for your HomeLab](https://www.youtube.com/watch?v=Cs8yOmTJNYQ)
- [Meet Heimdall, Your Homelab Application Dashboard](https://www.youtube.com/watch?v=PA01Z6-z8Qs)
- [Before I do anything on Proxmox, I do this first...](https://www.youtube.com/watch?v=GoZaMgEgrHw)
- [The FASTEST Way to run Kubernetes at Home - k3s Ansible Automation](https://www.youtube.com/watch?v=CbkEWcUZ7zM)
- [TrueNAS Scale Apps - Official, Unofficial, Docker, and Kubernetes](https://www.youtube.com/watch?v=oafOky5GSzc)
- [High Availability Pi-Hole? Yes please!](https://www.youtube.com/watch?v=IFVYe3riDRA)
- [Using Pi-Hole for Local DNS - Fast, Simple, and Easy Guide](https://www.youtube.com/watch?v=kKsHo6r4_rc)
- [Flux GitOps Tutorial - DevOps and GitOps for Kubernetes](https://www.youtube.com/watch?v=PFLimPh5-wo)
- [Wildcard Certificates with Traefik + cert-manager + Let's Encrypt in Kubernetes Tutorial](https://www.youtube.com/watch?v=G4CmbYL9UPg)
- [Beautiful Dashboards with Grafana and Prometheus - Monitoring Kubernetes Tutorial](https://www.youtube.com/watch?v=fzny5uUaAeY)
- [Network UPS Tools (NUT Server) Ultimate Guide](https://www.youtube.com/watch?v=vyBP7wpN72c)
- [Self-Hosted, DIY, Open Source Alternative to Linktree](https://www.youtube.com/watch?v=42SqfI_AjXU)
- [Meet keepalived - High Availability and Load Balancing in One](https://www.youtube.com/watch?v=hPfk0qd4xEY)
- [Meet Grafana LOKI, a Log Aggregation System for EVERYTHING](https://www.youtube.com/watch?v=h_GGd7HfKQ8)
- [Meet Uptime Kuma, a Fancy Open Source Uptime Monitor for all your HomeLab Monitoring Needs](https://www.youtube.com/watch?v=r_A5NKkAqZM)
- [Meet Jekyll - The Static Site Generator](https://www.youtube.com/watch?v=F8iOU1ci19Q)

## 📦 Gear in this video 📦

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

### Kit

Want to see all the gear in this video?

Check out the kit here: <https://kit.co/TechnoTim/techno-tim-homelab-tour-late-2022>

### Rack & Accessories

- 42u Rack <https://amzn.to/3YIKlrq>
- 18u Rack <https://amzn.to/3WqNZVy>
- D Ring Hooks <https://amzn.to/3FSxk5Y>
- 1u Brush Panels <https://amzn.to/3hKNiaf>
- 1u Rack Mount Full Depth Shelf <https://amzn.to/3jrm5Kp>
- Right Angle Extension Cord <https://amzn.to/3Wl7gay>
- Black Outlet Covers <https://amzn.to/3jrf7Vu>
- UniFi SmartPower PDU Pro <https://l.technotim.live/ubiquiti>

### Network

- Patch Panel <https://amzn.to/3YIKtHq>
- Wall Mount Patch Panel <https://amzn.to/3WyvnCk>
- Slim Network Cables - <https://amzn.to/3kbYV85>
- UniFi Flex Mini - <https://l.technotim.live/ubiquiti>
- UDM SE - <https://l.technotim.live/ubiquiti>
- UDM Pro - <https://l.technotim.live/ubiquiti>
- UniFi 48 Port Pro Switch Gen 2 - <https://l.technotim.live/ubiquiti>

### Servers & Accessories

- SuperMicro 1u Servers - <https://amzn.to/3YBQy8u>
- 14 TB Exos Seagate Drives - <https://amzn.to/3GbtXsk>
- NetApp DD4246 Disk Shelf - <https://amzn.to/3o2AOKh>
- PC Conversion Case - <https://amzn.to/3YGXx03>
- Smart ZigBee LED Controller - <https://amzn.to/3jtCpKI>
- Cooler Master SickleFlow 120mm RGB Fans - <https://amzn.to/3I68AtA>
- 1 TB Samsung SSDs - <https://amzn.to/3PPcedo>

### Accessories

- Axxtra Power Strip - <https://amzn.to/3qbzIhT>
- Eaton 5P1500R UPS - <https://amzn.to/3OC2D90>
- Tripp Lite 2200VA 1920W UPS Smart 2U Rackmount - <https://amzn.to/3XrnC2q>
- Tripp Lite BP36V15-2U Smart UPS 36V 2U Rackmount External Battery Pack - <https://amzn.to/3XxwBzd>
- APC 1500VA UPS <https://amzn.to/3GXLJh6>
- APC 600 VA UPS - <https://amzn.to/3mMxsM1>
- Wall Control Galvanized Steel Pegboard - <https://amzn.to/3bJ8R4s>
- HDHomeRun Network Tuner - <https://amzn.to/3Gdkd0x>
- Hue Light Strip <https://amzn.to/3I124o3>
- Hue Motion & Temp <https://amzn.to/3qb1FXf>
- Hue v2 Dimmer Switch - <https://amzn.to/3hH6pCh>
- Hue Smart Bulb Starter Kit - <https://amzn.to/3jljCRA>
- Nest Protect - <https://amzn.to/3hMZcR8>
- Cloud Lamp - <https://amzn.to/3GZji24>
- Fire Extinguisher - <https://amzn.to/3GeB2s4>

## Chapters

00:00 - What is Techno Tim Self-Hosting?

01:05 - Dashboard

01:36 - Hypervisor

07:09 - Network Attached Storage

09:37 - DNS

11:48 - Network Management

13:05 - Home Security

13:42 - Containers (Kubernetes & Docker)

17:59 - -Kubernetes Storage

21:04 - Git Ops

22:35 - Reverse Proxy (Internal, External, and Ingress Controller)

25:26 - Monitoring

26:10 - Metrics & Data Visualization

27:02 - Logging

28:28 - Home Automation

30:08 - Data Synchronization

30:55 - Link  Page (Contact Page)

31:41 - Link Shortener

32:24 - Home Entertainment

33:00 - UPS Battery Monitoring

33:37 - CMS (Content Management System)

34:25 - Websites (Static Sites & Custom Code)

34:46 - Dynamic DNS (External DNS)

35:16 - CI/CD (Continuous Integration & Continuous Delivery)

37:04 - Everything Else

37:41 - How do I get started self-hosting?

38:30 - Thanks for Watching!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Wow, what a year of self-hosting! After showing off my HomeLab hardware in my late 2022 tour, many of you asked what services are self-hosted in this stack, so I decided it was time to share which services I am running here at home.<a href="https://t.co/Z1yKrwKOaP">https://t.co/Z1yKrwKOaP</a><a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://twitter.com/hashtag/selfhosted?src=hash&amp;ref_src=twsrc%5Etfw">#selfhosted</a> <a href="https://t.co/JW2WdvuIQM">pic.twitter.com/JW2WdvuIQM</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1609225385522204673?ref_src=twsrc%5Etfw">December 31, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
