---
layout: post
title: "Bridge Mode with UniFi Access Points"
date: 2020-09-19 09:00:00 -0500
categories: homelab
tags: homelab network unifi hardware
image:
  path: /assets/img/headers/bridge-water.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyq8U/tl+PbP4d+Gfh9p3h7wxa+GPFGjRSXmlXFmurWBOm+G9B8SyPcWuqxXgv5bm51aGBUupGsII7BZm0+4ubiSVPZ4j4lxtWLUI04QrckIwl+8jBOryczVoe0kmuZXtBaLk0u/wA5oZZRyijhaVKUquJrVJqeLmtVai6r5KTc1G8fcvzud3zOclaC/OzxLoD23iPxBbSaneXT2+t6rA91PNd+fcvFfzxtcTeXeJH5sxUySbERN7HaqrgD5d4mtd+/Ld/y/rFv72/U9GpzqpNe0lpOS2h0k11i3+L9T//Z

---

Do you have some places where you can't run ethernet?  Do want to extend your ethernet without pulling more cable?  Well this is the guide for you.In this step-by-step tutorial we'll use a Ubiquiti UniFi AP AC PRO and connect a second as a guest, giving use remote ethernet to a remote site!  This is the pro tip guide to setting up a wireless bridge!  Bonus, we'll even do a live throughput test to see how much bandwidth we get running in bridge mode with 2 AC Pros!

{% include embed/youtube.html id='UCB61jc0PUA' %}

📺 [Watch Video](https://www.youtube.com/watch?v=UCB61jc0PUA)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
