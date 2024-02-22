---
layout: post
title: "Linux desktop, inside of a container, inside of a browser???  Yes. A Webtop."
date: 2021-06-20 09:00:00 -0500
categories: self-hosted
tags: homelab traefik portainer docker self-hosted ubuntu webtop
image:
  path: /assets/img/headers/color-stacks.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APEfBf7dfxT8X6Ppvh3xLGdZt5I4rfT5r3Ul8zTpY1lktpMW+mW7XUFtcSm6jsppVhF0sVwhjmijdf7U8LPDvgjw9q058MZLUws5QnSo+3xca8cM61lOpRisNS5ZyinByvzezlUhGUVUlf8Ax1+lz9ITx3+khw1V4W8SeO8DPh+jmGGzPNMDkHDv9jzz9YCcp0MFmtdZtifbYSFZxxSo+z9k8VRw9etTrSw9NR6aWK8lkkluNb1yWeR3kmlGpzxCSV2LSSCNDsjDuWYInypnavAFfvr5ru9Ss3fV+0au+rslZX7LRH+dUa2HpxjTo5ZlcKVOKhSg8DRqOFOK5YRc5RcpuMUk5yfNK13qz//Z
---

Have you ever thought about running a Linux desktop inside of a container?  Me neither until I found this awesome project from LinuxServer called Webtops.A webtop is a technology stack that allows you to run Ubuntu or Alpine Linux within a container that is fully accessible from a browser.This allows you to use most Linux features with a container with a fraction of the cost of resources.Join me as we configure one from beginning to end.

{% include embed/youtube.html id='Gd9bvdkIXOQ' %}

📺 [Watch Video](https://www.youtube.com/watch?v=Gd9bvdkIXOQ)

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Webtop

`docker-compose.yml` and `.env` can be found [here](https://github.com/techno-tim/launchpad/tree/master/docker/webtop)

## Files and folders

```bash
mkdir webtop
cd webtop
mkdir config
cd ..
nano docker-compose.yml
```

### Create Webtop container

```bash
docker-compose up -d
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
