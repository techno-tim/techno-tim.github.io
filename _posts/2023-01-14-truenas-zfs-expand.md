---
layout: post
title: "The EASIEST way to Expand Your ZFS Pool in TrueNAS (But is it the Best?)"
date: 2023-01-14 10:00:00 -0500
categories: truenas
tags: homelab truenas zfs storage open-source
image:
  path: /assets/img/headers/stretch-cat.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APmv9kb9l74E/su/BO0/aZ8Q+CD8afFR8Q+H9a8KaP4i1OfQNM8J3/hGXRbvTpYjaR6quq/afEfiOx1+/juraKGSXwxo1pbR2kbX8l3+bVM9rYfL6GZ4mjDFVcRiKkVGDjhuRJSjFc/s605WUoyuuSTnTi+blvF/tOE8M8iq57ictwkq1B4PDYfErEYz/b5OooxneFKMsJCF5RlfndVcs7KKlGM1+cHxB/aO8VeIPH3jfX7xL2G71vxf4l1e6hs9TsoLSK51LWr29njtYToLmG2jlmZYIi7mOIKhZsZOVPiDFOnBqjhknCLScZtpNKyb51drvZX7I6sR4f5X9Yr8+MzKU/bVeeUa1KEZS55czjD2UuWLd2o80uVacztc/wD/2Q==

---

ZFS is a great file system that comes with TrueNAS and can meet all of your storage needs.But with it comes some complexity on how to manage and expand your ZFS storage pools.Over the last week I learned all about storage pools and how to move them, expand them, and even what not to do when trying to grow your storage pool.Join me as I figure out how to move a 20 TB pool to my new storage server with 100 TB of raw data.

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

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Over the last week I learned all about storage pools and how to move them, expand them, and even what not to do when trying to grow your storage pool.<a href="https://t.co/IoQKKKhEKm">https://t.co/IoQKKKhEKm</a><a href="https://twitter.com/hashtag/truenas?src=hash&amp;ref_src=twsrc%5Etfw">#truenas</a> <a href="https://twitter.com/hashtag/zfs?src=hash&amp;ref_src=twsrc%5Etfw">#zfs</a> <a href="https://twitter.com/hashtag/nas?src=hash&amp;ref_src=twsrc%5Etfw">#nas</a> <a href="https://t.co/UFZF4hLSBc">pic.twitter.com/UFZF4hLSBc</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1614299061237981187?ref_src=twsrc%5Etfw">January 14, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
