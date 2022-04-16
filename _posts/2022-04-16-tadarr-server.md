---
layout: post
title: "I Freed Up 700GB+ Converting my Videos Using Tdarr"
date: 2022-04-16 10:00:00 -0500
categories: homelab 
tags: tdarr plex
---

[![I Freed Up 700GB+ Converting my Videos Using Tdarr](https://img.youtube.com/vi/UA1Sktq40pA/0.jpg)](https://www.youtube.com/watch?v=UA1Sktq40pA "I Freed Up 700GB+ Converting my Videos Using Tdarr")

Tdarr is a distributed transcoding system that runs on on Windows, Mac, Linux, Arm, Docker, and even Unraid.  It uses a server with one or more nodes to transcode videos into any format you like.  Today, we'll set up the Docker and Windows version of Tdarr using a GPU to regain up to 50% of your disk space back.  I converted my video collection using Tdarr to h265 and saved over 700 GB of disk space.  

A HUGE THANKS to our sponsor, Micro Center! 

New Customers Exclusive – Get a Free 256gb SSD at Micro Center: <https://micro.center/a643c4>

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

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
