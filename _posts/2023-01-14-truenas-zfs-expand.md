---
layout: post
title: "The EASIEST way to Expand Your ZFS Pool in TrueNAS (But is it the Best?)"
date: 2023-01-14 10:00:00 -0500
categories: truenas
tags: homelab truenas zfs storage open-source
image:
  path: /assets/img/headers/stretch-cat.jpg
---

ZFS is a great file system that comes with TrueNAS and can meet all of your storage needs.  But with it comes some complexity on how to manage and expand your ZFS storage pools.  Over the last week I learned all about storage pools and how to move them, expand them, and even what not to do when trying to grow your storage pool.  Join me as I figure out how to move a 20 TB pool to my new storage server with 100 TB of raw data.

{% include embed/youtube.html id='Uzk6Janio0g' %}
📺 [Watch Video](https://www.youtube.com/watch?v=Uzk6Janio0g)

## 📦 Products in this video 📦

Seagate Exos 14TB Drives <https://amzn.to/3kaQnkN>

Seagate IronWolf 8TB Drives <https://amzn.to/3iGq3yH>

See all of the storage I recommend in this kit!

<https://kit.co/TechnoTim/best-ssd-hard-drive-flash-storage>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

## Chapters

00:00 - What are my options for expanding ZFS?

00:25 - Use ZFS Snapshot Replication (My First Attempt)

02:20 - Just Copy the Data to the New Pool (My Second Attempt)

03:01 - Expand the Pool by Replacing All Disks (My Third Attempt)

04:27 - Replacing All of the Drives & Resilvering

07:16 - Pool has Expanded!

07:43 - My Beef with ZFS and Recommendations

09:20 - Stream Highlight - This is how I got into this mess with ZFS...

A clip used in this video was from [Tom Lawrence's channel](https://www.youtube.com/@LAWRENCESYSTEMS). Thanks Tom!

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
