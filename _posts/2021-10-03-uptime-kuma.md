---
layout: post
title: "Meet Uptime Kuma, a Fancy Open Source Uptime Monitor for all your HomeLab Monitoring Needs"
date: 2021-10-03 10:00:00 -0500
categories: self-hosted
tags: homelab uptime-kuma self-hosted docker monitoring alerting open-source
image:
  path: /assets/img/headers/green-kuma.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APz4+E97darpK6NA0NpPPPFfWt5NAL2CCT7O7XEVzZFreS5t7mIKjLb31hOkkUEi3GxJIJv9JcXnGMy6jRzjDyV4YW9XCzSdKs4/wm529pTlSbnaVNxco1JwldM/xi4oyPKqPirmXA2df2nmvDnEue4fCVcJhcxjldXA5jOrUWAzzCVJ4TMaax+XU8XjMPFSoOlisLi8RQxEXGVN0vovTvDvhm70+xup7LVPPubO2uJvJ1Ozjh82aFJJPKjfRpnSPex2I8srKuA0jkFj/Gmb/TS4+y/NczwFLhvhqdLBZhjcJTnUlmrqSp4bE1aMJTccbGLnKME5OMYx5m7RS0KxfgrwZhsVicNDG8Wyhh8RWoQlPNsoc3GlUlTi5OPDkYuTUU5WjFXvZJaH/9k=

---

You've spun up lots of self-hosted services in your HomeLab but you haven't set up monitoring and alerting yet.Well, be glad you waited because today well set up Uptime Kuma to do just that.Uptime Kuma is a self-hosted, open source, fancy uptime monitoring and alerting system.It can monitor HTTP, HTTP with keyword, TCP, Ping, and even DNS systems!

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

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
