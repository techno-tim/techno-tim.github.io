---
layout: post
title: "Building a Low-Power, Fully Loaded Plex Server"
date: 2024-09-16 08:00:00 -0500
categories: homelab
tags: plex hardware windows linux pc server
image:
 path: /assets/img/headers/plex-build-low-power-server-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APw6+MXxz8KfD74WeKIZ/wBnj4TeLfEFhpkdlY+MdZ1/446frx1y98Q6RdweK72Pw38X9G0c6tpVpa3en6YujaXoVtAmoSXEqTTW8G3/AHn+kfm+b4XgrPsdDiDPvq2InSwlHJOXhb+x8LhnhMRGphoRlwnPNKtCbdOr++zWddVaME68qE69Ct3x4ayXhmHEuFhhZ43E43C08DDE1ZYdUqX/AAqYHGTrSoVsLiq6qf7FSVKeAxuXVY1Iw9tWxGEdfBYj8q9D0Kwu9E0e6l0jw3JJc6Vp9xJJNpmpvM7zWkMjvK0WvwRNIzMWdo4IYyxJSKNSEH+Z+Fxsq+Gw1aeWcPznWoUas51csxM6s5VKcZylUnHM6cZ1JNtzlGnTjKTbUIp8q9ajmFClRpUngKE3Tpwpud1HncIqLlyqnaPNa9lor2R//9k=
---

I built an efficient, good looking, Mini ITX Plex server that doesn’t skimp on the processing power, storage, or features like transcoding all while using only 16 watts of power.  Each part is hand-picked and every setting is tweaked with efficiency in mind. Oh, and it would even look nice in your living space too!  If you already have a Plex server, you can still follow this guide to be sure you are getting the most efficiency out of your hardware!

A huge THANK YOU to Plex for sponsoring this video during Pro Week!
Explore and learn more from Plex Pros here:  <https://www.plex.tv/pro-week>.

{% include embed/youtube.html id='VLSWyTmM2ro' %}
📺 [Watch Video](https://www.youtube.com/watch?v=VLSWyTmM2ro)

## Disclosures

- Plex sponsored this video however all content was written and edited by me personally.

## Info

📦 Products in video (affiliate links):

- Fractal Design Terra Case: <https://amzn.to/3MLBXCD>
- Intel Corei3 14100 CPU: <https://amzn.to/3Zmaq2k>
- ASUS ROG Strix B760-I Motherboard: <https://amzn.to/3XvqkVH>
- Corsair DDR5 RAM 64GB: <https://amzn.to/3zbZD06>
- Noctua Low- Profile CPU Cooler: <https://amzn.to/3XpAirv>
- Corsair SF750 SFF Power Supply: <https://amzn.to/3ZsZ1xS>
- Seagate Exos X18 18TB Hard Drive: <https://amzn.to/4gsQReF>
- Noctua NF-A8 PWM Fan - <https://amzn.to/4d3t42h>
- Hard Drive Rubber Stands - <https://amzn.to/4gueXWs>
- Kill A Watt Electricity Monitor - <https://amzn.to/3zpAVt5>
- Mini monitor everyone keeps asking about - <https://amzn.to/4deDP1E>

Check out the whole kit here: <https://kit.co/TechnoTim/low-power-media-server>

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I built an efficient, good looking, Mini ITX Plex server that doesn’t skimp on the processing power, storage, or features like transcoding all while using 16 watts. Each part is hand-picked and every setting is tweaked with efficiency in mind.<br>---&gt;<a href="https://t.co/Ka4Sdb2xFe">https://t.co/Ka4Sdb2xFe</a> <a href="https://t.co/IvguaiNB4m">pic.twitter.com/IvguaiNB4m</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1835722884322385992?ref_src=twsrc%5Etfw">September 16, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
