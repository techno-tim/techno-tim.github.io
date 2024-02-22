---
layout: post
title: "How To Create an iSCSI Target with TrueNAS"
date: 2020-03-06 09:00:00 -0500
categories: truenas
tags: homelab rancher kubernetes
image:
  path: /assets/img/headers/folder-pink.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AMTRfhn8bP2208Ty/Fj9qv4sQPoHiH/hAIL/AEJvsGvX9jbSfYor3WdettUt7/VLiT7PDLdRXLNA+bqG1FnDeXCv+h8PcYcY4XK8XDLeIauV4LLJ1I08JgsDgaLrTop3q1cRGipzqVVBOpKcZzc/f5rn+m3Gf0VPoqvJsw43xfglg8TnXEPDseIMwqx4x4uoU4zpYZ4mGFwOCWY1Moy2nGnVnh4Ty/K8MlCNGM6VSlQpUI/0L+AP+CfXx98NeBPBXhyz/wCClf7V32Tw/wCEvDmiWu2y+HjD7PpWj2dhBhr/AEHUb5h5UC4a91C+uyObi8uZt874PjTMqzdbEZRwjia9V+0rYivw1hp169WfvVK1aarRU6tWblOpJRipTk2oq9j/AC5xOWcFxxOIjl+RcQYDARr1VgcCuOc7rLBYNVJLDYRVnTpuqsNR5KKqOnB1FDmcI35V/9k=
---

Setting up iSCSI with TrueNAS and Windows 10 is super simple with TrueNAS.This is an easy way to have a hard drive installed on your machine that isn't really attached, it lives on the network.

{% include embed/youtube.html id='JzX6c58ydY4' %}

📺 [Watch Video](https://www.youtube.com/watch?v=JzX6c58ydY4)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
