---
layout: post
title: "Home Assistant on Docker and Kubernetes (Open Source Home Automation)"
date: 2020-06-13 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted home-assistant
---

[![Home Assistant on Docker and Kubernetes (Open Source Home Automation)](https://img.youtube.com/vi/DK_Gdtn_wvw/0.jpg)](https://www.youtube.com/watch?v=DK_Gdtn_wvw "Home Assistant on Docker and Kubernetes (Open Source Home Automation)")

Are you ready to start automating your smart home with the power of open source?  Do you already have Home Assistant running but need a little more power than a Raspberry Pi?  If so, join me in this easy to follow, step by step tutorial on installing Home Assistant on Docker, Kubernetes, and Rancher. We'll set it up, walk through and configure the UI, and then move on to configure some Wemo smart switches, Phillips Hue bulbs, Google Home / Chromecast devices, and even create a Dark Mode / Light mode automation script using Phillips Hue Scenes!

[Watch Video](https://www.youtube.com/watch?v=DK_Gdtn_wvw)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

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