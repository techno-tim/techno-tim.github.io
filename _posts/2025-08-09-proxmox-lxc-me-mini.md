---
layout: post
title: "It's better with Proxmox... Beelink ME Mini PC NAS"
date: 2025-08-09 08:00:00 -0500
categories: proxmox
tags: homelab prxmox self-hosted lxc
image:
 path: /assets/img/headers/proxmox-lxc-me-mini-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APo/xp+wL8PdU8H/ALMfwy+GfibVfhXL8OvF+iaf4o8UWGl6fqepfFLRX8QWihfFiadJ4XmfXo1eBItXmv8AUdNjiS5RfDoFzEbT8jy7j/HV61OGIwdGam5Tfs6rp8sqcotKN6dT93KDcZwnztu0ozgk4S/Zsf4fYHD0atTDY2vBwSilVpxrJwlBxfNapS/ec1pRnFQSjeLhKTU4/Yo/4I+/CCUCXUPjL8ZLm/kAkvri1PgKxtp7xxuuZreyHg24FnBLMXeK1FxOLeNlh86XZvbufG2Z3dsNgUruycMQ2l0TaxEU35pJPstjzlwTl1lzYrGuVtWpUEm+rSdGTSb2TlJrq3uf/9k=
---

Everyone thinks this is a NAS.  I don't. It's a low power Proxmox LXC Server and it's awesome!

{% include embed/youtube.html id='VZo-2Fq8v7M' %}
📺 [Watch Video](https://www.youtube.com/watch?v=VZo-2Fq8v7M)

## Intro

The Beelink ME Mini has been generating attention as a small form factor NAS, and with its compact footprint and six NVMe slots, it’s easy to see why. But after spending time with it, I think it has another role worth exploring: virtualization.

While it’s marketed for storage, pairing it with Proxmox and LXC containers turns it into a surprisingly capable low-power app engine. The CPU specs may not impress on paper, but it handles more than you might think. I decided to test it that way, loading it with containers, a few VMs, and monitoring its performance.

## Unboxing & First Impressions

The ME Mini has a smaller than the Beelink EQ14, and has an internal power supply instead of an external brick. 

Ports:

- Front: USB-C, USB-A 3.0
- Rear: HDMI, USB-A 2.0, dual 2.5 GbE LAN

Inside, you’ll find:

- Intel N150
  - Twin Lake
  - 4 Cores 4 Threads
  - Turbos up to 3.6 GHz
- Six labeled NVMe slots
- Internal power supply
- Wireless & Bluetooth radios
- A large, All-in-one heatsink with thermal pads for all NVMe drives

Opening it requires removing some weird screw protectors. These are totally unnecessary and they should get rid of these. Once inside, the cooling solution in pretty impressive.  It cools the CPU, all 6 NVMe drives, and the WiFi and Bluetooth chips.

## Storage Layout

The included Crucial NVMe in Slot 1 (PCIe 3.0 x2) became my OS drive. The other five slots run at PCIe 3.0 x1, so while you can fill all six, bandwidth will be limited under heavy load. Given the x1 lanes, using the cheapest NVMe drives you can find makes more sense than loading it with high-end models.

## Power Consumption & Setup

With one NVMe installed, idle power draw hovered around 15–20W running Windows. After initially setting it up, I skipped Windows entirely and installed Proxmox VE.

BIOS tweaks:

- Enabled VT-D
- Disabled Hibernate & Sleep
- "Restore AC Power" is actually listed under `Chipset > PCH-IO Configuration > State After G3 > S0 State`.  This will restore power to the device after power loss (something I didn't realize when evaluating this machine)

Installing Proxmox was straightforward, aside from a long pause at "Creating LVSs (normal on some mini-PCs like Beelink and Minisforums machines, just wait it out).

## LXC Containers on the ME Mini

Once Proxmox was installed, I ran my [Proxmox Helper Scripts](/posts/proxmox-helper-scripts/) to:

- Disable enterprise repos
- Enable no-subscription repo
- Disable HA & Corosync
- Update system

I created a ZFS pool on four Samsung 990 Pros in a stripe (no redundancy). Performance hit ~15K IOPS - on par with my Mac Studio M2 in a similar test.

Then I deployed a bunch of container, similar to the Docker containers I am running on my NAS:

- PiHole
- Authelia
- Minio
- Mongodb
- MySQL
- Postgres
- Redis
- Uptime Kuma
- Homepage
- Immich
- Plex
- Tautulli
- Home Assistant Core
- n8n
- Zigbee2mqtt
- Mqtt
- Traefik
- Grafana
- Jellyfin
- Ubuntu VM

**Resource usage with all running:**

- RAM: ~50% of 12GB
- CPU: 2–8% average
- Power: ~14–15W

LXC containers made the difference - minimal overhead, instant startup, less resources, and higher density than VMs.

## Bonus VM Tests

- **Ubuntu Server VM:** Runs fine, but LXCs are more efficient here so unless you need full isolation, just run the LXC version of Ubuntu.
- **Windows 11 VM:** Works, but sluggish - I would only do this if absolutely necessary and for light, occasional use.

## GPU Transcoding for Plex & Jellyfin

> *Note: Proxmox recently release 9.0, which includes Linux kernel 9.14*
{: .prompt-info }

Out of the box, Plex couldn’t detect the integrated Twin Lake GPU - the default Proxmox kernel was too old. I updated to kernel 6.15 using the [Zabbly project](https://github.com/zabbly/linux), which temporarily broke ZFS until I upgraded it as well.

Once I fixed that, both Plex and Jellyfin successfully used the GPU for hardware transcoding.

> *Note: Kernel upgrades on Proxmox carry risk - only do this if you need Twin Lake GPU support.*
{: .prompt-info }

## Final Thoughts

The Beelink ME Mini works as a NAS, but shines as a low-power Proxmox LXC host.

Highlights:

- Runs many services with low CPU/RAM usage
- Integrated GPU for media transcoding
- Compact and efficient - ideal for app hosting, dashboards, and self-hosted tools

If you don’t need six NVMe slots, the EQ14 might be a cheaper option. But for compact, quiet, and flexible virtualization, the ME Mini delivers far more uses cases than their NAS focused marketing suggests.

## Where to buy

- Beelink ME - <https://amzn.to/3J8vNxZ>
- Beelink EQ14 - <https://amzn.to/45vQEmp>

(Affiliate links. I may receive a small commission at no cost to you.)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Everyone thinks this is a NAS. I don&#39;t. It&#39;s a low power Proxmox LXC Server and it&#39;s awesome!<a href="https://t.co/bpG3jP7Nv5">https://t.co/bpG3jP7Nv5</a> <a href="https://t.co/0BsuuKolp4">pic.twitter.com/0BsuuKolp4</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1954222809913155749?ref_src=twsrc%5Etfw">August 9, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
