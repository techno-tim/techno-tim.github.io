---
layout: post
title: "High Availability Pi-Hole? Yes please!"
date: 2020-12-12 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted pi-hole gravity-sync keepalived
image:
  path: /assets/img/headers/metal-ball.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5X9A+MvjnTPFt341j1CO71C6totGeHUEluoLdLyG8zcafF50dpZzolpboZRZyXJaJJ47mG4igmh9am5UcypUovWVOVWM7RvBRdOEoWad+bmk1O6lG+nW+U4wqZPVqyimqdeNKcLytVc1Vqxm2muVQ9nFOFpRqJe9tFL6Jh/ae+NQhiC+J7QKI0Cg6VGcAKMDJuMnA796+o9vU/mPlPqtH+X8T/AP/Z

---

Dear Pi-Hole,
We love your product.It keeps our network safe from malware and other unwanted domains. While we love what is there so far,  please add a feature to your core product to keep multiple servers in sync and provide high availability DNS to our whole entire network.Then, we won't have people asking us "Is the internet down?" every time we reboot our Pi-Hole server.

Until then, we will use Gravity Sync.

Sincerely,

Techno Tim (and probably thousands of other lovers of Pi-Hole).

P.S.Keep up the good work!

Thank you Gravity Sync!

(don't forget to star the repo!)

[https://github.com/vmstan/gravity-sync](https://github.com/vmstan/gravity-sync)

{% include embed/youtube.html id='IFVYe3riDRA' %}

📺 [Watch Video](https://www.youtube.com/watch?v=IFVYe3riDRA)

Great Raspberry Pi - Pi-Hole Servers!

► Raspberry Pi Zero W Kit - [https://amzn.to/3qOl9yS](https://amzn.to/3qOl9yS)

► Raspberry Pi 4 Kit - [https://amzn.to/3nophDm](https://amzn.to/3nophDm)

If you're looking to have your PiHole instances failover automatically, be sure to check out the documentation on `keepalived`

[Meet keepalived - High Availability and Load Balancing in One](/posts/keepalived-ha-loadbalancer/)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
