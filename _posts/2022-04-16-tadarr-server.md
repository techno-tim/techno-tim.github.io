---
layout: post
title: "I Freed Up 700GB+ Converting my Videos Using Tdarr"
date: 2022-04-16 10:00:00 -0500
categories: homelab 
tags: tdarr plex
image:
  path: /assets/img/headers/radar-milkyway.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5nW+Lup+CrzxhoFjpGmXemWvw3mubS3u0Qrbana6LPqq6jEyQCUyM5jgMMkrwGOMsyMxTy/wB1qcY5pl+JzDCYb2UcPTwlKl7GcKdSEpvBwxEqt3TU1J/WVFRU7L2UZa3UY/lGXcIZbjsPl2Lrur9YxWJrqdWEpxkqX1p0PZW53CS/2fn5pQbTqNK1rv8APy78e+KLm6ubk6xqkRuLiacxxalfLFGZZGkKRgzsRGhbagLEhQASTzXw0sfi5ylN16t5ScnarUSvJ3dlz6LXRH69TynLadOFNYHCNQhGCcsPRcmopRTb5NW7avqz/9k=

---

Tdarr is a distributed transcoding system that runs on on Windows, Mac, Linux, Arm, Docker, and even Unraid.It uses a server with one or more nodes to transcode videos into any format you like.Today, we'll set up the Docker and Windows version of Tdarr using a GPU to regain up to 50% of your disk space back.I converted my video collection using Tdarr to h265 and saved over 700 GB of disk space.

A HUGE THANKS to our sponsor, Micro Center!

New Customers Exclusive – Get a Free 256gb SSD at Micro Center: <https://micro.center/a643c4>

{% include embed/youtube.html id='UA1Sktq40pA' %}

📺 [Watch Video](https://www.youtube.com/watch?v=UA1Sktq40pA)

## Docker Server + Node

`docker-compose.yml`

```yml
version: "3.4"
services:
  tdarr:
    container_name: tdarr
    image: ghcr.io/haveagitgat/tdarr:latest
    restart: unless-stopped
    network_mode: bridge
    ports:
      - 8265:8265 # webUI port
      - 8266:8266 # server port
      - 8267:8267 # Internal node port
    environment:
      - TZ=America/Chicago
      - PUID=1000
      - PGID=1000
      - UMASK_SET=002
      - serverIP=0.0.0.0
      - serverPort=8266
      - webUIPort=8265
      - internalNode=true
      - nodeID=MyInternalNode
      - nodeIP=0.0.0.0
      - nodePort=8267
      - NVIDIA_DRIVER_CAPABILITIES=all
      - NVIDIA_VISIBLE_DEVICES=all
    volumes:
      - /path/to/server:/app/server
      - /path/to/configs:/app/configs
      - /path/to/logs:/app/logs
      - /path/to/media/:/media
      - /path/to/temp/:/temp
    deploy:
      resources:
        reservations:
          devices:
            - capabilities:
              - gpu
```

## Windows Node

`Tdarr_Node_Config.json`

```json
{
  "nodeID": "Windows-Node",
  "nodeIP": "192.168.0.100",
  "nodePort": "8267",
  "serverIP": "192.168.0.101",
  "serverPort": "8266",
  "handbrakePath": "",
  "ffmpegPath": "",
  "mkvpropeditPath": "",
  "pathTranslators": [
    {
      "server": "/media/",
      "node": "C:/media"
    },
    {
      "server": "/temp",
      "node": "C:/temp"
    }
  ],
  "platform_arch": "win32_x64_docker_false",
  "logLevel": "INFO"
}
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
