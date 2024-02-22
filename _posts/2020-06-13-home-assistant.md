---
layout: post
title: "Home Assistant on Docker and Kubernetes (Open Source Home Automation)"
date: 2020-06-13 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted home-assistant
image:
  path: /assets/img/headers/home-modern.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APLl8ReI/Evgq+1KDXtS0nX760glgv4ZVewtZpLPQzcSNpsCWU74JuGsls9T08QG5lW8/tGNnjk/YcH4h+MWM4uxOa/8RPzujl9evnmIlkscRxBPC0o08VmtPD0cP7TiiWFpQpx5HKLwFSi5UaEqFHDey1/Acf4ZeEmC4Zo5c/Djh/EYvDUcmw6zWrl2Q/Wq0nQy2darXmsg+s1HVbkm/rcarjUqqrXre0dvDrX4q/HN7a2b/hYGgLughbavgCwKrmNTtUy6xLKVGcAySySEcvI7ZY+rifpJ+K2HxFegs6pSVCtVoqUqEm5KnOUE25VpSbajduUpSb3k3qePQ+jF4RYijRxDyCUXXpU6zjGskourBTcUowhFJOVkoxjFLaKWi//Z

---

Are you ready to start automating your smart home with the power of open source?  Do you already have Home Assistant running but need a little more power than a Raspberry Pi?  If so, join me in this easy to follow, step by step tutorial on installing Home Assistant on Docker, Kubernetes, and Rancher. We'll set it up, walk through and configure the UI, and then move on to configure some Wemo smart switches, Phillips Hue bulbs, Google Home / Chromecast devices, and even create a Dark Mode / Light mode automation script using Phillips Hue Scenes!

{% include embed/youtube.html id='DK_Gdtn_wvw' %}

📺 [Watch Video](https://www.youtube.com/watch?v=DK_Gdtn_wvw)

`configuration.yaml`

```yml
# Configure a default setup of Home Assistant (frontend, api, etc)
default_config:

# Text to speech
tts:
  - platform: google_translate

group: !include groups.yaml
automation: !include automations.yaml
script: !include scripts.yaml
scene: !include scenes.yaml

wemo:
  discovery: true
```

`scripts.yaml`

```yml
'1591564249617':
  alias: Dark Mode
  sequence:
  - data:
      group_name: Office
      scene_name: Gaming
    service: hue.hue_activate_scene
  - device_id: f41ccf86433148dcbd8e932d1412f12a
    domain: switch
    entity_id: switch.gaming_lights
    type: turn_on
'1591564322588':
  alias: Light Mode
  sequence:
  - data:
      group_name: Office
      scene_name: Energize
    service: hue.hue_activate_scene
  - device_id: f41ccf86433148dcbd8e932d1412f12a
    domain: switch
    entity_id: switch.gaming_lights
    type: turn_off
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
