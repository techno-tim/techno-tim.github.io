---
layout: post
title: "Optimizing TrueNAS for SPEED (and Safety)"
date: 2024-02-09 08:00:00 -0500
categories: truenas
tags: homelab truenas zfs
image:
 path: /assets/img/headers/truenas-optimizations-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5HPCl18NfAvg/wzouufs8fBj4n6n4hsNXvJPF3jfU/2hNO163xq9/a2g+x/Dr4/eA/ClxNpywsllLN4a8v7OYo7y3u7hJ7u6+sqYeLqY2cJzprBuhThBKnJP2uHhVk7zpycfjStq3y3vZqMeKnTfNhKDld4lVpyn7yt7OpKEVyqaUvhb3Vr7Xu38rzeDLOOWWP7Q52SOmfLAztYrnHmcZxnFd6p02k/Zx1Se3dGUoTjKUfa/DJr4F0du5//9k=
---

After setting up your TrueNAS server there are lots of things to configure when it comes to tuning ZFS.  From pools, to disk configuration, to cache to networking, backups and more.  This guide will walk you through everything you should do after installing TrueNAS with a focus on speed, safety, and optimization.

{% include embed/youtube.html id='3T5wBZOm4hY' %}
📺 [Watch Video](https://www.youtube.com/watch?v=3T5wBZOm4hY)

Disclosures:

- Nothing in this video was sponsored

## Pool Optimizations

I chose  Mirrored VDEVs for a few reasons:

Upsides

- Provides redundancy
- Increased performance
- Great for small random reads
- Expansion, much easier than any other raid type
- You can expand by adding an additional pair
  - This means I only need to buy 2 disks to expand my pool
  - Resilvering is fast

Downsides

- Write performance can be impacted since each write involves updating all VDEVS in a mirror
- Adding a separate ZIP like an SSD can improve write performance, which we’ll talk about
- If I lose 2 drives in the same mirror I lose the whole pool
  - Which means that I need to replace disks fast
  - If your pool of mirrored VDEVs is big enough, the chances are less likely to happen
- 50% capacity loss

## Datasets

- Encryption: On
- Sync: Standard
- Compression: LZ4
- Enabled Atime: Off
- ZFS Deduplication: Off

## ARC

- Adaptive Replacement Cache, this is where data is stored that is frequently accessed along with metadata about the files.  
- Algorithm for adding and evicting data for least recently used.
- This makes accessing files quicker because it doesn’t need to read from disk and takes the load off those disks so they can do another tasks
- This isn’t really used for write, that’s ZIL, but some async writes and write directly to ARC
- There’s a general rule of thumb that you should have 1GB for each TB, however the more the better.
- One tweak that you might have to do if using ZFS on a Linux system like TrueNAS Scale and that’s adjusting the ARC allocation
  - [This is not needed after this patch is released](https://www.truenas.com/docs/scale/gettingstarted/scalereleasenotes/)
  - By default linux only allocates 50%
  - You can override this with a quick command while the system is running and then you can also follow that up with a startup command to be sure that this persists between reboots
  - Generally speaking you should let your system run for a few days before making this adjustment as well as running any services and VMs to be sure you don’t over allocate your RAM to ARC.
  - See [Tom Lawrence's Video on this topic](https://www.youtube.com/watch?v=X0_8DilTkYM)

## Read Speeds

To increase read speeds:

- More RAM
- More disks / spindles
- L2ARC
  - Stripe these, even 1 large SSD is good

## Write Speeds

To increase write speeds:

- More Disks - spinning disks can only read/write at about 150 MB/s
- Disable Sync write? (No!, not safe)
- Create SLOG device
  - Should use disks fast that in the pool like SSDs
  - Be sure you have at least a mirror for this
  - This moves ZIL off the main pool, which frees up the pool to do other things
  
## Network Considerations

- LAGG / LACP gives you 2 lanes
- Gives you redundancy
- Generally speaking if your switch supports it, a great idea

## Network and disk speed go hand in hand

- If your pool can’t read at 10 Gb/s there’s no sense of having 10 gb/s networking
- If your disks have huge IOSps (think all SSD) your network can’t handle the throughput
- Somewhere in the middle

## VLAN Routing

- Another huge consideration is inter VLAN routing.  
- If you have to cross VLANs, be sure that your switch or router can handle these speeds or you might have to get creative with a dedicated data network that doesn’t traverse VLANs.

## Snapshots

- This is diff based
  - Fist will be relatively large
  - Subsequent will be smaller

My Settings:

- Lifetime of 2 weeks
- Enable Recursion
- Don't allow taking empty snapshots
- Enable the schedule

## Backups

- Yes, but hard to do on a budget
- Ideally you want to replicate these snapshots to another pool, preferably on another machine

## Alerts

- Check to be sure alerts are enabled and working

## UPS

- Yes, enough said

## Where to Buy

Here are some items I found useful when building my NAS

- Supermicro NVMe Add-in Card - <https://www.ebay.com/itm/375100900409?mkcid=1&mkrid=711-53200-19255-0&siteid=0&campid=5338780159&customid=&toolid=10001&mkevt=1>
- Dell NVMe Add-in Card - <https://www.ebay.com/itm/164864777644?mkcid=1&mkrid=711-53200-19255-0&siteid=0&campid=5338780159&customid=&toolid=10001&mkevt=1>
- M.2 Heatsink SSD Cooler for PS5 PCIE NVME - <https://amzn.to/4bwsYAq>
- Intel OPTANE SSD P1600X Series 118GB M.2 PCIE - <https://amzn.to/497Np53>
- SAMSUNG 990 PRO Series - 2TB PCIe Gen4. X4 NVMe 2.0c - M.2 Internal SSD - <https://amzn.to/4buzeZz>
- Seagate IronWolf 12TB NAS Internal Hard Drive HDD - <https://amzn.to/3usqnH8>
- Seagate Exos X18 ST14000NM000J 14 TB Hard Drive - <https://amzn.to/3SC6ntT>
- APC UPS 1500VA UPS Battery Backup and Surge Protector - <https://amzn.to/499JvZx>
- Tripp Lite SMART1500LCD 1500VA UPS Smart Battery Backup (rackmount) - <https://amzn.to/3SOXhLr>

(Affiliate links may be included. I may receive a small commission at no cost to you.)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Over the last few weeks while building my new TrueNAS server I learned a lot about ZFS and how to optimize my new NAS for performance.<a href="https://t.co/qvAJBBSCkA">https://t.co/qvAJBBSCkA</a> <a href="https://t.co/6LB5IqHZo7">pic.twitter.com/6LB5IqHZo7</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1755985833495032218?ref_src=twsrc%5Etfw">February 9, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
