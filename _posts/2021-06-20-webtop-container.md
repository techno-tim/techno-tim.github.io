---
layout: post
title: "Linux desktop, inside of a container, inside of a browser???  Yes. A Webtop."
date: 2021-06-20 09:00:00 -0500
categories: self-hosted
tags: homelab traefik portainer docker self-hosted ubuntu webtop
image:
  path: /assets/img/headers/folders-colorful.jpg
---

Have you ever thought about running a Linux desktop inside of a container?  Me neither until I found this awesome project from LinuxServer called Webtops.  A webtop is a technology stack that allows you to run Ubuntu or Alpine Linux within a container that is fully accessible from a browser.  This allows you to use most Linux features with a container with a fraction of the cost of resources.  Join me as we configure one from beginning to end.

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

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
