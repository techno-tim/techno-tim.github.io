---
layout: post
title: "Meet Uptime Kuma, a Fancy Open Source Uptime Monitor for all your HomeLab Monitoring Needs"
date: 2021-10-03 10:00:00 -0500
categories: self-hosted
tags: homelab uptime-kuma self-hosted docker monitoring alerting open-source
image:
  path: /assets/img/headers/green-kuma.jpg
---

You've spun up lots of self-hosted services in your HomeLab but you haven't set up monitoring and alerting yet.  We'll be glad you waited because today well set up Uptime Kuma to do just that.  Uptime Kuma is a self-hosted, open source, fancy uptime monitoring and alerting system.  It can monitor HTTP, HTTP with keyword, TCP, Ping, and even DNS systems!

[https://github.com/louislam/uptime-kuma](https://github.com/louislam/uptime-kuma)

{% include embed/youtube.html id='r_A5NKkAqZM' %}

📺 [Watch Video](https://www.youtube.com/watch?v=r_A5NKkAqZM)

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

If you're using Docker compose

```bash
mkdir uptime-kuma
cd uptime-kuma
touch docker-compose.yml
nano docker-compose.yml # copy the contents from below
mkdir data
ls
docker-compose up -d --force-recreate
```

`docker-compose.yml`

```yml
---
version: "3.1"

services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    volumes:
      - /home/serveradmin/docker_volumes/uptime-kuma/data:/app/data
    ports:
      - 3001:3001
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```

If you're using Rancher, Portainer, Open Media Vault, Unraid, or anything else with a GUI, just copy and paste the environment variables, ports, and volumes from above into the form on the web page.

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
