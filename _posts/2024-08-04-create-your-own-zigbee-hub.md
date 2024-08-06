---
layout: post
title: "Create Your Own Zigbee Hub & Network"
date: 2024-08-04 08:00:00 -0500
categories: home-automation hardware
tags: hardware home-automation zigbee home-assistant
image:
 path: /assets/img/headers/create-your-own-zigbee-hub-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APk3wx4j8OQS6bqK/Cz4fyXGmrptjPqkt18SofEOr3bQ3FndanfXumfEbTdEtbi5ivZryRNC8NaMJ9YnutU1B795YIbX8/xNPDz/AHP1WhOpioVHVqV3iKsZ/ulDllShXo8sZctKVaFGdGFVwk3GMp80fo8Zi6uFrOVCpUi8ThIyrc0cM41JJY+/tKMcLDDzjOEZRqxlRtUdRyaSp0Y0/tjT/G/iB7CxdJILFHs7ZkstMuvEdvp1mrQoVtdPt7nxFe3EFlbgiK0hnvLuaKBI0luZ3VpX+Lr53icPWrYel7aFOhVqUacKePx8KcIUpuEIwh9ZfJCMYpRjd8qSV3Y/Qsq44ynBZXluDrcK0MTWwmAweGq4iOIyyksRUoYenSnWVKpw9ialNVZRc1TniK84KXLKtVknOX//2Q==
---

This simple but powerful little adapter lets you build your own Zigbee network and easily add and manage it in Home Assistant, no hub required!

{% include embed/youtube.html id='8e4oaUHlMsE' %}
📺 [Watch Video](https://www.youtube.com/watch?v=8e4oaUHlMsE)

## Disclosures

- Nothing in this video was sponsored

## Info

- SMLIGHT homepage: <https://smlight.tech/>
- Zigbee2MQTT: <https://github.com/Koenkk/zigbee2mqtt>
- Mosquitto: <https://github.com/eclipse/mosquitto>
- Home Assistant: <https://github.com/home-assistant/core>

## Hardware

- SMLIGHT SLZB-06: <https://amzn.to/4doSJ6B> (affiliate link)
- THIRDREALITY ZigBee Smart Plug: <https://amzn.to/3A8AlA7> (affiliate link)

## Code

A simplified Home Assistant Stack with Zigbee2MQTT Support.  Don't forget to update your [Zigbee2MQTT configuration!](https://www.zigbee2mqtt.io/guide/installation/01_linux.html#configuring)

```yaml
---
services:
  homeassistant:
    container_name: homeassistant
    image: ghcr.io/home-assistant/home-assistant:stable
    depends_on:
      - mqtt
      - zigbee2mqtt
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./home-assistant/config:/config
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    ports:
      - 8123:8123
  mqtt:
    container_name: mqtt
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    image: eclipse-mosquitto:latest
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./mqtt/data:/mosquitto
    ports:
      - 1883:1883
      - 9001:9001
    command: mosquitto -c /mosquitto-no-auth.conf

  zigbee2mqtt:
    container_name: zigbee2mqtt
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    image: koenkk/zigbee2mqtt:latest
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./zigbee2mqtt/data:/app/data
    ports:
      - 8080:8080
```

My Home Assistant Stack:

```yaml
---
services:
  homeassistant:
    container_name: homeassistant
    networks:
      iot_macvlan:
        ipv4_address: 192.168.20.202
      traefik:
    image: ghcr.io/home-assistant/home-assistant:stable
    depends_on:
      - faster-whisper-gpu
      - wyoming-piper
      - mqtt
      - zigbee2mqtt
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./home-assistant/config:/config
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.homeassistant.rule=Host(`homeassistant.local.techtronic.us`)"
      - "traefik.http.routers.homeassistant.entrypoints=https"
      - "traefik.http.routers.homeassistant.tls=true"
      - "traefik.http.routers.homeassistant.tls.certresolver=cloudflare"
      - "traefik.http.routers.homeassistant.middlewares=default-headers@file"
      - "traefik.http.services.homeassistant.loadbalancer.server.port=8123"
      - "com.centurylinklabs.watchtower.enable=true"
  faster-whisper-gpu:
    image: lscr.io/linuxserver/faster-whisper:gpu
    container_name: faster-whisper-gpu
    networks:
      - traefik
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - WHISPER_MODEL=tiny-int8
      - WHISPER_BEAM=1 #optional
      - WHISPER_LANG=en #optional
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./faster-whisper/data:/config
    restart: unless-stopped
    labels:
      - "com.centurylinklabs.watchtower.enable=true"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
  wyoming-piper:
    container_name: wyoming-piper
    networks:
      - traefik
    image: rhasspy/wyoming-piper # no gpu
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./wyoming-piper/data:/data
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    labels:
      - "com.centurylinklabs.watchtower.enable=true"
    command: --voice en_US-lessac-medium
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
  mqtt:
    container_name: mqtt
    networks:
      - traefik
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    image: eclipse-mosquitto:latest
    restart: unless-stopped
    labels:
      - "com.centurylinklabs.watchtower.enable=true"
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./mqtt/data:/mosquitto
    command: mosquitto -c /mosquitto-no-auth.conf

  zigbee2mqtt:
    container_name: zigbee2mqtt
    networks:
      iot_macvlan:
        ipv4_address: 192.168.20.204
      traefik:
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.zigbee2mqtt.rule=Host(`zigbee2mqtt.local.techtronic.us`)"
      - "traefik.http.routers.zigbee2mqtt.entrypoints=https"
      - "traefik.http.routers.zigbee2mqtt.tls=true"
      - "traefik.http.routers.zigbee2mqtt.tls.certresolver=cloudflare"
      - "traefik.http.routers.zigbee2mqtt.middlewares=default-headers@file"
      - "traefik.http.services.zigbee2mqtt.loadbalancer.server.port=8080"
      - "com.centurylinklabs.watchtower.enable=true"
    image: koenkk/zigbee2mqtt:latest
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./zigbee2mqtt/data:/app/data
networks:
  traefik:
    external: true
  iot_macvlan:
    external: true

```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">In today&#39;s side quest, I created my own Zigbee hub and network and added it to Home Assistant with this awesome little adapter!!<br><br>check it out---&gt;<a href="https://t.co/s0VRC6oLOD">https://t.co/s0VRC6oLOD</a> <a href="https://t.co/8V9pavNH1T">pic.twitter.com/8V9pavNH1T</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1820127269194772603?ref_src=twsrc%5Etfw">August 4, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
