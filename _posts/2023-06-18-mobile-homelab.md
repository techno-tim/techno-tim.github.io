---
layout: post
title: "My Mobile HomeLab! (Travel Router with Proxmox, Docker, and OpenWRT)"
date: 2023-06-18 10:00:00 -0500
categories: homelab
tags: homelab travel hardware proxmox docker portainer openwrt
image:
  path: /assets/img/headers/mobile-vanlife.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP3M1f8A4KE/F7QvjD4G+HlhofhKTRfEFzaW+qXV/aXU+q4m1S906RrCe1nsbS2+WO2kjFxY320pOrF/Pja3858QOcVJYRRVruP1mrK92lZPlVtHa9ntseBLA4mFeNP63SlF2Tvg4czeut1VStdXtyv1PsKL9qjxbJFG50ixBeNHIE0eAWUEgf6B05rH+3Y/9Ab/APCqX/yo7fqNb/oIp/8AhLH/AOWH/9k=

---

This has been months in the making, my new Mobile HomeLab! It's a device that I can take with me to provide secure internet access for all of my devices. Not only can it provide secure access, but it can also let me bring apps and services with me when I travel. It's built on Proxmox, OpenWRT, Pi-hole, and many other services. I'm taking this with me everywhere!

A huge thank you to [Protectli](https://protectli.com/) for sending this device!

{% include embed/youtube.html id='02gYwJ2G-vE' %}
📺 [Watch Video](https://www.youtube.com/watch?v=02gYwJ2G-vE)

## Where to Buy

- Protectli VP2420 - <https://amzn.to/443wb68>
- Crucial 16 GB RAM - <https://amzn.to/3qOMK7F>
- Intel Wi-Fi 6 (alternate wifi option) - <https://amzn.to/3PfuRZP>
- Samsung 1 TB SSD - <https://amzn.to/3Nj7Mme>
- USB WiFI NIC (ralink chipset) - <https://amzn.to/3NyP8an>
- Wyze Camera - <https://amzn.to/467JVi3>
- Timbuk2 Backpack - <https://amzn.to/3p8L9ZF>
- Slim Cat6a Cables - <https://amzn.to/3qOCHPT>
- Anker Charging Station - <https://amzn.to/3qOk66r>
- Anker USB C Cables - <https://amzn.to/3qOCXhP>
- Anker Surge Protector - <https://amzn.to/3Jlq8ll>
- Anker USB Hub - <https://amzn.to/42N15yF>
- WD 5 TB USB Hard Drive - <https://amzn.to/42Oa3f4>
- Protectli WiFi Kit - <https://protectli.com/product/m2-wifi/>
- Protectli 4G LTE Modem - <https://protectli.com/product/mdg200-m2/>

See the whole kit here! - <https://kit.co/TechnoTim/mobile-homelab>

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

## My Mobile HomeLab

This is my mobile HomeLab, or is it my mobile home lab, or just mobile lab, or a travel router ++, or ultimate mobile HomeLab, anyway, It’s a computer that I bring with me that serves as a network firewall, an access point, and a platform to run apps, services, and virtual machines. I guess it’s a cross between Wendell’s forbidden router and Network Chuck’s travel router. It’s something that I am going to take with me every time I travel and will provide internet access whether that be from an existing network, or one I connect to over my carrier’s mobile data network.

![My Mobile HomeLab](/assets/img/posts/my-mobile-homelab.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APAP2ZPgjrfwo/at1/wnpfjX/hCPhz498T6Hp+ufDf4a6JpKeGfE2ia07al4xt7u/wDF9jrnjPwo19r1rdaxotvovizVE0K41B49EutGtIPslx05hjauZ1szzjH/AO15jjKtWvXr1o0ZRq1azft6mIoyoTp4idZTlzyapylOUqtR1Zyd9Z3qT+rynUUalRSnyTnSm5KSqKUa1OcKsGqkU7Req93SLaP2LT9hX4E3KLcDUfiVKJ1WYSXfiqWe6kEoDh7mdtzTXD7t00rMzSSFnJJOa2XHfFK0jmGHilooxyfI1GKWyilltkktElstD5D/AIhZwO9XlGJk3q5S4g4ncpPq23nd229W+rP/2Q==" }
_A Mobile HomeLab device I can take with me that also provider network access!_

This is something that I have wanted to create for quite some time because when traveling I bring with me a few pieces of technology to make my life a little easier and keep my nerd brain fed. Some of these are common like a laptop and a tablet, but others aren't. You see, when I travel I like to take a router with me to keep all of my devices connected securely, rather than connecting all of my devices to say the Air BnB’s WiFi. Bringing my own router assures me that my laptop, tablet, phone, pi, even security camera are connected to my router and that no other devices can spy on me.

I’ve carried an old Cisco Linksys router with me every time I travel, and it provides a secure private network that only my devices can connect to. I can even take this a step further and use a VPN to connect all of my devices securely to my home network, where I get the same protection as I do when I am physically at home. This little router has worked great for quite some time, but I also started bringing a Raspberry Pi to provide a few more services on my local network. That’s around the time when I started thinking about how to combine all of the functionality into one package. Protectli reached out to me and said they wanted to give one of their devices a test run on my next trip and see if this combination of form factor and hardware would accomplish everything I needed out of my new "mobile homelab, forbidden travel router, plus plus, ultimate mobile homelab - thingie"?

![Old Mobile HomeLab](/assets/img/posts/old-mobile-homelab.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APP/AIS+FvHWg6B8LPjZ4R1ax134UfFrwz47tNf+GvxB1CBLzwp4f8Y6/b3vgvXNOufBHg3w4vjLxboV3rt8+r2V3qPgvSLnTpr3R47y6a/TVbD5HJ6C9i8DmcIYqtTdKGJr0p16axcKdKNNb1XUw1SfJFzqUZu2soRjU99/W8TZnPNcbicfhIU8ulipYmvGjQw9CGHwtbEVqlZRo0IRUZYeg5yjTp1pVJzgkqlRu7P07X9jbwoVUyado1w5UF549Y8V2MczkfNKlk95qT2iSHLravqOoNbhhE17dFDPJ3yniOZ2wmCkru0pYrFxlJX0biqclFvdpSkk9FJ7nBTr4D2cL18dF8kbxjgsFOMXZXipyrwlNJ6KThFyWrjFuy//2Q==
" }
_What I usually carry with me_

## The Hardware

This is a Protectli Vault VP2420 which, if you couldn't tell by the huge heatsink on top, it’s fanless and silent. This model has an intel Celeron J6412, but it’s not like the Celerons of the past, this Celeron has 4 cores and 4 threads and has a base clock speed of 2 GHz and can burst to 2.6 GHz. What makes this CPU great is that it is super low power but yet still has features like AES-NI and VT-x and VT-d which makes it great for a hypervisor like VMWare or Proxmox. It also has QuickSync which can be used for video transcoding too. I opted for 32 GB of DDR-4 RAM , the most you can get on this device.

This model comes with (4) 2.5 Gb ethernet ports for lots of hard wired connectivity options. But even more interesting than the wired options, are the wireless options. You probably noticed all of the antennas sticking out, now one set is pretty obvious and that’s one for WiFi. It’s a Protectli WiFi module that supports 802.11 ac/a/b/g/n and fits into the m.2 slot. The other antennas are actually for a 4g LTE modem that works most carriers. It even has a slot on the outside of the case that you can insert your SIM card into without opening the device up.

As far as storage goes it has an internal 8GB eMMC module that I really won’t be using, and I opted for a 1 TB Samsung SSD. I would like to have another option for another drive, but I figure this was good enough for what I am going to use it for.

As far as IO goes we have an HDMI port, 2 USB 3.0 ports, a Display Port, USB C, and a micro USB port for console access. It’s powered by this little brick and has a barrel plug for power. This is quite a capable machine for something that’s smaller than a tablet. All in all, it’s a solid fanless, quiet, yet power build.

![Protectli Vault VP2420](/assets/img/posts/protectli-vault-vp2420.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AO88H/sI/tD6a03xG+BXxg+Hf7Omlat4YsX8R6Z8KPCy2fibVPCqQ2dh4fS/+IHjfw38QvHGv+IkgtpE1d9a8Ry6HLZxWemWemxRNqFzefB4LE5nSUlXxf1rEQUVGs0sP7FJKEYUI4WnS5YwtzKcuas52k6jtFR+5zirluOxFOphcvWFw6hGnUo1atXGyxai2lLFyxU6sZ3puNL2UIxoKlFQVOzlf5gl+JnjnwTLJ4M1L4Qfsg61qPhGR/DF/rE3wj8ayTate6Cx0q61OWRPidZI8l/PaSXTutnaKzSkrbQAiJOarjc+nUqTnxBmcpznOU5SxWJblKUm5SbjiIJttttqEU3tGK0W1KjwdTp06cOC8opwhCEIU6dKgqcIxioxhBSw85KEUlGKlOclFJOUnq//2Q==
" }
_My Protectli Vault VP2420 with 2.5 Gb/s networking_

## The Build

So now that I have all of this put together (it came assembled) how was I going to build the ultimate mobile HomeLab?

My original thought was to just run pfsense or OPNsense on this machine and use it as a router however, FreeBSD, the operating system that these are built on do not have drivers for this wireless NIC. That shut that down really quick. Then I noticed that Protectli have [documentation on their site](https://protectli.com/kb/openwrt-on-the-vault/) on how to set up this device with [OpenWRT](https://openwrt.org/). That’s when I remembered Network Chuck’s video and decided that if he got it working, I could too. Well, not really because he’s like a legit networking person and I am just a hack, but anyway I thought I would give it a shot.

![OpenWRT on Proxmox](/assets/img/posts/mobile-homelab-proxmox.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP46/ixJrV94eub608S+IbTUgIHaKHVHtdOeQXkEJcpbw/aULW8js/lSp5tz+8l3q8ik16tvRJeSSskvJdA/V3fq936nzgNW+J+B/wAV94i6D/mafEP/AMcquef80v8AwJ/5k8kP5Y/+Ar/I/wD/2Q==
" }
_I should have installed OpenWRT on Proxmox to begin with..._

So I installed OpenWRT. The process was a little bit complicated but I had some help from Stuart from the Protectli team and they updated their docs with the challenges we worked through. After getting it running, I quickly realized that I should have just used a hypervisor and created it as an OpenWRT virtual machine. This would allow me to make changes and back them up as I go. It would also allow me to install other VMs and containers that I can use while on the go.

## Proxmox

So that’s what I did, I installed Proxmox on this machine since it supports virtualization and hardware passthrough. At first, I wanted to create an LXC container for OpenWRT to use less resources, however, it does not support hardware passthrough like virtualization does for network cards so I created a simple virtual machine. I found this [great guide](https://i12bretro.github.io/tutorials/0405.html) on creating an OpenWRT VM on Proxmox!

The steps to create a VM were pretty straight forward and I followed each step on that checklist carefully.

Once I had the virtual machine configured, I then passed through the devices that I need to run a router along with an access point. I passed through a NIC for WAN access, the wireless adapter for the access point, a USB wireless NIC for additional WAN access, and the USB modem for, well, WAN access for LTE. I gave it 2GB of RAM and 2 CPU cores, and the disk of only 512 MB. This is how big the disk image is. Now this might not seem like much but this is much more than I will ever need, considering this router that also runs a version of OpenWRT only uses 32MB of RAM and 8 MB of disk space.

![OpenWRT on Proxmox VMs](/assets/img/posts/mobile-homelab-proxmox-vms.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5h/DsOlT6DqfjLxFpkmvLpDaek+nNfrZtqZudQW2kLXy6fNPZMu9pfMjFwZC3lsqqpaTws1xOOeJwmXYOvTwssbDER+typOtPC+yoynB06TnGFbmkknGUqShG9nNvTKTd+WNk5tyu1dXVndq8bt21187nSj40+F1AWP4ZhY1G1FbxXHIyoOFVpH8LF5GC4BdyWY/MxJJryHw3n0m3LjDMOZu75aWJhG71fLCOaKMVfaMUlFaJWRPsX/ND/AMFv/wCTP//Z
" }
_OpenWRT running as a VM on Proxmox_

## OpenWRT

Once the machine was up and running, I made some changes to the NIC and then went to the OpenWRT admin interface. The interface is pretty basic although it does come with dark mode, so that’s a plus for me. They also support a few different themes however I decided to stick with the default bootstrap dark. I configured a few initial settings like NTP, my router’d name, and then headed over to the software section. Here I can install some additional packages. I installed a few optional packages like `nano`, `zsh`, `usbutils`, and `openssh sftp server`, and `htop` for better monitoring. After doing this, it was now time to configure the network.

## NIC (LAN)

First I wanted to be sure I could connect to this device via LAN. This was as simple as just configuring the virtual machine to connect to the bridge on Proxmox. This means when I plug in a network adapter to a port dedicated as LAN, I can connect to anything running on the Proxmox bridge. This will be the local area network for all of my devices on this subnet. If you want, you can configure DHCP on this OpenWRT interface but I am going to do that later with Pi-hole or even pfSense later.

## NIC (WAN)

The next NIC I wanted to configure was the WAN NIC. This will be the NIC that is passed through to this virtual machine and will give it internet access if you have physical access to the modem or another switch. It’s as simple as assigning this NIC to WAN, and turning on DHCP. Physically plugging an ethernet cable is my preferred method of connecting this router to an upstream network like an Air BnB modem or any other network you don’t trust.

![network Diagram LAN](/assets/img/posts/mobile-homelab-diagram-lan.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kJZ5CJ5S26aSSOSWbasbmaQmRiojwNoZX5JyW2uFjy60Bp5/f/X5lQNNgYlcDAwA7DA7DHbFAH//Z
" }
_After this step, the LAN and WAN should work by physically connecting_

## Wireless NIC (Access Point)

Now that I have LAN and WAN NICs configured, I can plug in my laptop and connect to this network. This works fine but really we want to broadcast our own wireless SSID so all of our devices can connect to it. This is where we’ll need to configure our Protectli wireless NIC. In order for this NIC to work, we’ll need to install the drivers and a few packages on OpenWRT to enable the wireless access point feature and we can do this within the software section. You’ll need to install a few packages and then overwrite a few files with ones from Protectli. They've found that some of the packages that are available on OpenWRT aren’t compatible so [they’ve provided these files on their website along with instructions](https://protectli.com/kb/wifi-on-the-vault/). Once that’s taken care of and we reboot we can now see this wireless section with our wireless NIC! Here we’ll want to configure the wireless network we want to broadcast for our clients to connect to. You’ll need to configure the SSID, security, and wireless mode.

![Network Diagram WLAN](/assets/img/posts/mobile-homelab-diagram-wlan.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kZbiQiaQsGmklSWafaI5Glky52iMhQqujEEjJJ3gIWKgHpZK3q73v/wAN83vr2phpsDErgYGAHYYHYY7YoEf/2Q==
" }
_Now you should have a fully working router with LAN, WAN, and an access point!_

Pro tip, I found out that even though this is a dual band NIC, you cannot broadcast on both bands at the same time. So if you aren’t going to use 2.4 GHz you’re fine, you can set it to AC mode or N 5GHz, but if you are using any 2.4GHz devices you’ll need to set the mode to the lowest common denominator of 2.4 GHz. Another thing you can do is configure a second NIC to broadcast on 2.4 GHz, but we’ll talk about it a little bit later.

Once you apply this, you should be able to see your new SSID and connect to OpenWRT! And if you have the WAN port connected to an upstream network, you should be able to use this as your router! But the fun doesn’t stop, there, not even close.

## USB Wireless NIC (Client / WAN / other)

At this point you should be able to connect to your router and use the internet from the WAN port, but what if you don’t have access to the WAN port? This is where a second wireless network device comes into play. Let me be clear, this was the most complicated part of this whole project. OpenWRT supports very few USB wireless adapters. I tested 8 USB wireless network adapters before I finally found one that worked with OpenWRT. I tested name brands, no name brands, USB 2, USB 3, ones with odd antennas, and ones without external antennas at all. It turns out that most wireless USB adapters use a Realtek chipset and this does not play well with OpenWRT. It was hard to find one without a Realtek chip, but it turns out [this tiny little no-name one works great](https://amzn.to/3NyP8an) and that’s because it’s based on a Ralink chipset, one that’s very hard to find.

![WLAN USB](/assets/img/posts/mobile-homelab-diagram-wlan-usb.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APEfg/8Athf8E2fgBJ4qk8E/s1fGDQx440S08NeNrTTJdBdPFEWnwxW2nz6nqlx8SU1x5oLiP+05rhNQS5vdWKancyveRiRvztcZU/awdSOIlKjaMG8PhZRSULL3JVOSVo2V5Qberldtt/oeJ4Cx1ajVjUr4CVKvFRqRjVxNJzilaz9nh01dJczUryerbu2/WIP2s/8AglDcwQ3E/wCy/wDtDedPFHNN5XivVI4vNlQPJ5ccf7QKJHHvY7ERERVwqqoAA9GXEGFrSlWqRxkqlWTqTk1BOU5vmlJpV0ruTb0Vuxw0uEcwoU6dGjVy+FGjCFKlC03yU6cVCEbvCtvlikrttu2rbP8A/9k=
" }
_I tested 8 wireless USB NICs before finally finding one that works with OpenWRT_

So you’ll need to install a few more packages for driver support. I chose to install mt7601u-firmware` for this wireless USB NIC. After that you should see another NIC in the wireless section. This time we’re going to configure it as a client that connects to an existing wireless network, that way you don’t have to physically connect to the WAN port, we’ll connect over wireless. We can do this by scanning and connecting to an existing wireless network, and after that you'll then have a completely functional router that can connect a wireless network and share it with all of your clients!

I should mention that even though this works fine, this USB NIC only supports 2.4GHz / Wireless N. This is generally fast enough for the internet connection but just know that you are going to be limited by the speed of this NIC, which is around 150 Mb/s at most. Personally I would only use this option if you can’t physically connect your WAN port to your upstream router. As you can see, when I am connected to the WAN via this USB NIC, I can be a lot slower than when it is connected via ethernet cable.

![Network Diagram WLAN USB](/assets/img/posts/mobile-homelab-diagram-wlan-usb-diagram.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kprqZlmcsDI8kUksvlrHIZ3DO7KYyOC6seQMnDhULMKB30S/rZK999epSDTYGJXAwMAOwwOwx2xQI/wD/2Q==
" }
_Now you should be able to connect your router to an upstream WiFi connection using this NIC!_

If you can physically connect to the WAN via ethernet, what I would do is disable this NIC or configure it to broadcast the same private network on 2.4Ghz this way you can set your primary NIC to use A/C/N 5 GHz. I had to do this to connect my Wyze cam since it only supports 2.4 GHz. Yes I take a [Wyze cam](https://amzn.to/467JVi3) with me when I travel so that I can keep an eye on the place when I leave and also keep an eye on my pups, Nano and Buddy,

![Security Camera](/assets/img/posts/mobile-homelab-wyze-cam.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOA+Cf7YuheIbH4j2mrfsufBCXRovHep6vYXWkXPi3w3caF4f8T6Ro2vWfg/R/C9lf3XhSLS9Aubu7s4pmhWW/s7e2ESaQtxdQLz42tGni8b7J1ZJ4+niPZVak1Qo0qqcfqVGFOUH7GMlz8/NTm27RjTSSMsvwslgsHCdRP2eB+q+19nCWIr1qUYXxletUUm60+X4eWSWvPKrJuR8sa2vwtfWdXc/D6wmL6nfsZZre1Espa6lPmShWKiR87nCkjcTgkVs0ru0Y2vpdtu3ndN39W35sjXra/W21+ttFp8l6H/2Q==
" }
_I bring a Wyze cam with me to keep an eye on the place!_

Now that I have this all working, I can now fire up my router and connect any of my devices to it and use my own secure wireless network.
(Use my phone and connect )

After running a speed test you can see I am getting anywhere from 180/200 Mbps which is pretty decent considering I have 500 up/down here at home. I’m sure I could squeeze out some more performance if I tweak some settings but this is great considering everything is running on stock settings.

## LTE Modem

So, not that I have OpenWRT working with an upstream router, what happens if I don’t have an upstream router at all? This is where the LTE modem that I mentioned earlier comes into play. This is great for times when you don’t have an internet provider where you are staying or if you decide to go and live the #vanlife.

![LTE Modem](/assets/img/posts/mobile-homelab-lte-modem.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APjLVv2gf2hvhxpv7QngPwr4wFtZ+Pb/AErx5Es2oWWoaJcw+EtavJrXTPE+n+JfBfifxbfNd29joUET6b8Q9Os9Ej0pLSxsp7Flgj8HEVsZKWWRwkaEqaxk6eL+tVq8ZLDVac53w6oR9jUxFPELDyvXoxjUo06lNunOdOrR9aksJCdWrVVZxcaUpQpxpL2rpPllB1J89WnCVKUopRqT5ZtT1ipU57ehfs4ftn3miaPeaN8d/gza6PdaVp9zpVtqXwk0691G302e0hlsYL+9bSma7vYbVoo7q6Zma4nWSUsS+a5JZPOUpSq5hmMqspN1JUsbVoUnUbvN0qCjNUabldwpKc1TjaClK137CzuC0pZXlMKa0pwngY15wgvgjKtUq+0rSjGylVn79Rpzl7zZ/9k=
" }
_A tiny LTE modem inside!_

Installing the software on OpenWRt was pretty straightforward, again you install a few packages (`kmod-usb-net-rndi`, `wwan`, `comgt-ncm`) and then reboot. But before I rebooted I inserted this cheap testing SIM into my device. After rebooting, you’ll then go to network interfaces and add the new interface which should be `USB0`. You’ll want to set this as WAN as the firewall zone and then save and apply. You can then access the modem’s web GUI on a private IP address of 172.16.0 from a device connected to the LAN port. You should then see your device connected to your cellular provider and !viola! this connection can be shared with anyone connected to this device! Oh yeah, I did update the firmware too because I love updating firmware 🤷

![LTE Modem Diagram](/assets/img/posts/mobile-homelab-lte-modem-diagram.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kZbiUiaTeGlkkSSaYxrHIZpdzsVKHGA6nBIBBAdQpkdQD6L5+f9f0+pTDTYGJXAwMAOwwOwx2xQI//9k=
" }
_If you use an LTE modem, you can now connect all if your devices to LTE data from your carrier!_

## Pi-hole

Now that I had OpenWRT working as an access point, a firewall, and a router that can connect to an upstream router via ethernet, wireless, or LTE, it was now time to focus on the “homelab” part of this device. Since I installed Proxmox on the host, I can now install anthony I want on this machine. The first thing I decided to install was a [Pi-hole](https://pi-hole.net/) to keep every connected device safe and free of ads and tracking.

Like all installations on Proxmox you have options of how you want to install things. I typically choose VMs but I wanted to keep this lean and mean, so I went with an LXC container. LXC containers are easy to manage and use less resources than a full VM. So I created an LXC container and set a hostname and password and uploaded my public ssh key. I chose the ubuntu template, then gave it 8 GB of disk space, 2 CPU cores, and 2 GB of RAM. For networking I connected it to the existing bridge, which is my LAN and gave it a static IP address.

Once the LXC container was created, I updated it and installed Pi-hole. After installing I updated all of my ad lists. I also added about 5 millions sites to my block list that you can see [here](/posts/pi-hole-blocklists/).

![Pi-hole](/assets/img/posts/mobile-homelab-pi-hole.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5sfh/4f8aal4S0HWtN8TyWmmiT4gQQac2o6rA0UHgbwjpXiPXIY2tcxwRaxp1+LK3SIf64S/aCkb763rPCY1YLAY7DxxSpyhWwqrU4VadCu5Tqxq01UclSqRnhITjONNtTjTla8brmqQnhMHmeMoVHh4Y5U8uzBUY2ni6c70aEMQk4xxNGDxlVOnVlaEJ1OVS53E+ZbtzJdXMhzl7iZzkknLSM3JJJJ55JJJ7k1jJJSaWiTaXonZG1OKjCEUklGEYpJWSSSVklol2S2P8A/9k=
" }
_Added Pi-hole to block all those ads and tracking on the go!_

I did end up enabling DHCP on Pi-hole just to see what it was all about. I usually let my router do this but for this travel router I wanted to have more control over blocking. I ended up disabling DHCP on OpenWRT and enabling it on Pi-hole.

## Portainer

Awesome, so now I have Pi-hole with network wide ad blocking running, so what’s next? Well, I know I want to have docker as a platform for running applications on this mobile HomeLab device and portainer is the best way to manage them. I chose to create another LXC container based on Ubuntu and gave it a 60 GB hard drive, 4 CPU cores, and 16 GB of ram. I spun up the container and let it grab an IP, and then I reserved that IP inside of Pi-hole. Once the container was up and running, I updated Ubuntu and installed Portainer. Once Portainer was running I then installed a Watchtower to keep all of my containers up to date. I typically use GitOps to handle this in my home production cluster, but I don’t want to worry about updating containers while traveling. Installing Watchtower was easy, just copy and paste the docker compose and I was good to go.

![Portainer](/assets/img/posts/mobile-homelab-portainer.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5APEeq6TFqMlvc6fPc3NvbmK4Eb21tbfa28+SCS0LwXUsVqiz28txC4aS6uEuczRecksWn7tJ8ym53d7Sio3u9vdb89t10RKvpayjZWVntZee/b18jnP7ds/8AoHTf+By//IlK9P8Akn/4MX/ysevdfd/wT//Z
" }
_Installed Portainer to manage all of my Docker containers_

## Apps

So now that I have Portainer installed, we can install any container we like to and take it with us. For instance, we could install the super popular [Plex](https://www.plex.tv/) or [Jellyfin](https://jellyfin.org/) and take our media library with us. This would allow any connected device to stream movies from this device down to theirs, without an internet connection The nice thing about this Intel CPU is that it has QuickSync so you can hardware transcode videos if you need to, making sure that streaming is smooth on any resolution. I bet you’re wondering about disk space? Well, if you really wanted to take more than 1 TB of media with you, you could simply connect and attach a USB hard drive with your media to this machine and mount the drive to your Plex or Jellyfin machine.

![Plex](/assets/img/posts/mobile-homelab-plex.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4/9P8AFbQJbWdzoPhzVDb30k6vqelQXLblvrC92MzDE8RexaFlmiYta3d1ZSGSynltnlYSviJx9lip0NOXkjCg4Xir816lCrPXmWjbXuqyWt37WnTT56Sn1u5TTs2tPdnFaW3ST1epF9nV/nSKCJH+ZYkUlI1blY0MvmylUBCqZJZJCAN8jtli1FwSg5OTiuVydk5OOjk1FRim2r+7GK7JLQG1JtpWTd0tXZPW2rb08233bP8A/9k=
" }
_Doing some local Plex transcoding while on the go!_

Also, it does stop there, we can now install any docker container or LXC container we like, or even a full blown Virtual Machine since we’re running Proxmox! If we really wanted to, we could now install pfsense or OPNSense as a virtual machine and use that as our router and disable all the routing features on OpenWRT, and only use that as an access point. Once you have pFSense or OPNSense running, you can then create a VPN connection back home to get the same protection you have at home. The possibilities are really endless. Want to install other containers, like LANcache, Netcloud, or even a local Minecraft server, no problem.

![VPN Diagram](/assets/img/posts/mobile-homelab-diagram-vpn-diagram.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4nJLuQW9w5WKWd5YJZrlohFP5k4aQhGiZflV4nO44JJ3Kqb3Sj+v6/rt83pZLtf59io0LBmCTyhASEBJGFBwowGIGBjgHFAn5bH//Z
" }
_You can even go as far as creating a VPN tunnel back home!_

And that’s the nice thing about a general purpose machine like this, you have unlimited possibilities. And using the Intel Celeron platform you get powerful hardware, at a fraction of the power consumption so you get the best of both worlds. A WiFi router and access point that connects all of your devices, internet or not, and lots of services that you can use while you are on the go. I’ll be using this device full time when I travel so I will be sure to report back any modifications I make to this new "mobile homelab, forbidden travel router, plus plus, ultimate mobile homelab - thingie"

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">This has been months in the making, my new Mobile HomeLab! It&#39;s a device that I can take with me to provide secure internet access for all of my devices. <br><br>Check it out!👉<a href="https://t.co/2F5gG5cZn2">https://t.co/2F5gG5cZn2</a> <a href="https://t.co/5zsXS4VG9X">pic.twitter.com/5zsXS4VG9X</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1670466092081217539?ref_src=twsrc%5Etfw">June 18, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
