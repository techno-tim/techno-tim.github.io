---
layout: post
title: "Meet Homepage - Your HomeLab Services Dashboard"
date: 2024-01-15 08:00:00 -0500
categories: self-hosted
tags: homepage dashboard docker open-source homelab
image:
 path: /assets/img/headers/homepage-dashboard-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP45v2a/F/wm8SeK/APw18U/stfBTxTdX9zp+i3vjjWfEv7SNv4i1GSfU4xPquoab4a+P3hzwj9vayuJbSJNK8O6RYwvFZXf2N5YboX3zHHWfz4X4YzXPY4b65/Z2Fq4n6r9Ynhfb+xpzqez+sUoznTUnFJtQnpdOLTPquA+H6XE3EeDymtiJYWFZSbrQo0q842lFXjTrXp81pPlcovlaTSujv8AxF+yI8/iDXZrLxzpGi2c2sanLaaPpvgF59O0m2kvZ3g0ywm1vxlrOtTWVhEUtbWXV9X1XVJIIo3v9Svrsy3Uv4pR8cKFajSq/wCqVWPtaVOpy/6zYp8vPFStdZbFO17aRS8lsf0FH6P+KaT/ANdKOqT14RwUnt1k80u35vV7s//Z
---

Meet Homepage, your new HomeLab services dashboard homepage!  Homepage is an open source,  highly customizable homepage (or startpage) dashboard that runs on Docker and is integrated with over 100 API services.  It's easy to set up, looks good by default, and helps you keep track of everything you are running in your HomeLab and more.  Today we'll set up Homepage and get it running in Docker in no time.

{% include embed/youtube.html id='mC3tjysJ01E' %}
📺 [Watch Video](https://www.youtube.com/watch?v=mC3tjysJ01E)

Disclosures:

- Nothing in this video was sponsored

Don't forget to ⭐ [homepage on GitHub](https://github.com/gethomepage/homepage/)!

## Requirements

- docker (and compose)

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker compose`

## Install

make a directory

```bash
mkdir homepage
```

`cd` into it

```bash
cd homepage
```

create a `docker-compose.yaml` file

```bash
touch docker-compose.yaml
```

edit it

```bash
nano docker-compose.yaml
```

```bash
mkdir config
```

place the contents

```yaml
version: "3.3"
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    ports:
      - 3000:3000
    env_file: .env # use .env
    volumes:
      - /path/to/config:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock # (optional) For docker integrations, see alternative methods
    environment:
      PUID: $PUID # read them from .env
      PGID: $PGID # read them from .env
```

create an `.env` file for variables

```bash
touch .env
```

edit it

```bash
nano .env
```

add to file:

```bash
PUID=1000
PGID=1000
```

save and exit

start the container

```bash
docker compose up -d
```

Give it a few seconds to start (could take up to 1 min depending on your docker machine)

you can check by running

```bash
docker ps
```

Check to be sure you see that the container is healthy. You should see something like:

```
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS                    PORTS                                       NAMES
8d841cf77e6f   ghcr.io/gethomepage/homepage:latest   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes (healthy)    0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   homepage
```

Once it's healthy, visit `http://<IP-ADDRESS-DOCKER-MACHINE>:3000`

You should see your new homepage!

## Configure

On docker machine, cd into `config` directory

You'll see yaml files, these are configurations we can edit to configure our homepage

edit `settings.yaml`

```bash
nano config/settings.yaml
```

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: My Awesome Homepage # <----- add this line

providers:
  openweathermap: openweathermapapikey
  weatherapi: weatherapiapikey

```

save, exit, and revisit your homepage

Should refresh, if not click the refresh in lower right hand corner

Title of document should now be

> My Awesome Homepage

If we want, we can also customize the background but updating this file too

edit `settings.yaml`

```bash
nano settings.yaml
```

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: My Awesome Homepage 

background: https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80 # <----- add this line

providers:
  openweathermap: openweathermapapikey
  weatherapi: weatherapiapikey

```

Save and exit again, and the background should be updated.

You can also [mount your own image](https://gethomepage.dev/latest/configs/settings/#background-image) rather than reference one on the web however I am going to stick with one from the web that I don't have to worry about additional mounts and configuration in the future.

If we want to add some additional filters to the image using tailwind css, we can like so

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: My Awesome Homepage 

background:
  image: https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80
  blur: sm # sm, "", md, xl... see https://tailwindcss.com/docs/backdrop-blur
  saturate: 50 # 0, 50, 100... see https://tailwindcss.com/docs/backdrop-saturate
  brightness: 50 # 0, 50, 75... see https://tailwindcss.com/docs/backdrop-brightness
  opacity: 50 # 0-100

# ^^^^  add the above block
  providers:
    openweathermap: openweathermapapikey
    weatherapi: weatherapiapikey
```

If we want to set out homepage to dark mode and the color to `slate`, we can like:

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: My Awesome Homepage 
theme: dark # <----- add this line
color: slate # <----- add this line
background:
  image: https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80
  blur: sm # sm, "", md, xl... see https://tailwindcss.com/docs/backdrop-blur
  saturate: 50 # 0, 50, 100... see https://tailwindcss.com/docs/backdrop-saturate
  brightness: 50 # 0, 50, 75... see https://tailwindcss.com/docs/backdrop-brightness
  opacity: 50 # 0-100

# ^^^^  add the above block
  providers:
    openweathermap: openweathermapapikey
    weatherapi: weatherapiapikey
```

Why do this?  Isn't this a lot of work?

1 word, it's "repeatable".  We can back up our yaml files and even share them if we want.  Also works great with Kubernetes since you can pass a `ConfigMap` file to your deployment thus not needed a volume.

## Services

services are configured in `service.yaml` and really are button for accessing some of your services

edit `service.yaml`

```bash
nano config/service.yaml
```

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/services

- My First Group:
    - My First Service:
        href: http://localhost/
        description: Homepage is awesome

- My Second Group:
    - My Second Service:
        href: http://localhost/
        description: Homepage is the best

- My Third Group:
    - My Third Service:
        href: http://localhost/
        description: Homepage is 😎
- Top Services:
    - Proxmox:
        icon: proxmox.png # icons found here https://github.com/walkxcode/dashboard-icons
        href: https://192.168.0.15:8006
        description: Proxmox VE
    - PiHole:
        icon: pi-hole.svg # icons found here https://github.com/walkxcode/dashboard-icons
        href: http://192.168.60.10/admin
        description: Server 1
    - Cowboy:
        icon: mdi-account-cowboy-hat-#FF0000 # icons found here https://pictogrammers.com/library/mdi/
        href: https://localhost/
        description: giddyup service
    - McDonald’s:
        icon: si-mcdonalds-#FFD700 # icons found here https://simpleicons.org/
        href: https://www.mcdonalds.com/
        description: homepage
    # ^^^ add this block
```

As you can see we configured 4 services:

- one that use png images
- one that used svg images
- one that use [Material Design icons](https://pictogrammers.com/library/mdi/)
- one that used [Simple Icons](https://simpleicons.org/)

** If you're using Material Design Icons or Simple Icons you can change the color of the icon by appending the hex values to the icon name as shown above.

## Service Widgets

These extend the functionality of service buttons.  Optional but cool.

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/services

- My First Group:
    - My First Service:
        href: http://localhost/
        description: Homepage is awesome

- My Second Group:
    - My Second Service:
        href: http://localhost/
        description: Homepage is the best

- My Third Group:
    - My Third Service:
        href: http://localhost/
        description: Homepage is 😎
- Top Services:
    - Proxmox:
        icon: proxmox.png # icons found here https://github.com/walkxcode/dashboard-icons
        href: https://192.168.0.15:8006
        description: Proxmox VE
    - PiHole:
        icon: pi-hole.svg # icons found here https://github.com/walkxcode/dashboard-icons
        href: http://192.168.60.10/admin
        description: Server 1
        widget:
          type: pihole
          url: http://192.168.60.10
          key: "{{HOMEPAGE_VAR_PIHOLE_API_KEY}}" # <--- updated with API key from PiHole
    - Cowboy:
        icon: mdi-account-cowboy-hat-#FF0000 # icons found here https://pictogrammers.com/library/mdi/
        href: https://localhost/
        description: giddyup service
    - McDonald’s:
        icon: si-mcdonalds-#FFD700 # icons found here https://simpleicons.org/
        href: https://www.mcdonalds.com/
        description: homepage
```

We should now see pi hole statistics

## Widgets

Widgets are standalone items like the resource and search at the top

If you want to edit these items

```bash
nano config/widgets.yaml
```

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/service-widgets

- resources:
    cpu: true
    memory: true
    disk: /

- search:
    provider: google # <--- updated with google
    target: _blank

- datetime:
    text_size: xl
    format:
      timeStyle: short
   # ^^^ add this block
```

Now we can see that search has been changed to Google and we've added a date widget.

## My Dashboard

![My Homepage Dashboard](/assets/img/posts/homepage-dashboard-mine.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5RfCXxz8JeH/hBrr+JfhroHiHxzA0GmeF/F7aZbLNp0LW8wkbVLZLq1g1GW1SOH7BOsMU+4MbuSbq36H7DMa1XD4qjjadDAYeNaONwroRqVq81yqg6FaWlJXc1W5oSulH2fK22vzGvluRxqYrL6mWV6+KxtT2uHxH9qYvD4ahGWtaMsJRT5nGb54Wq8k+eUJxjGMXL4In8Z63PPNPJqE0jzSySu7W1oGd5HLs7ALgMxJJA4BPHFYucW23HVu+y6n08MtwtOEIRpRjGEYwjFOdkopJJe9skrI//2Q==" }
_Here's a fully working example of my own Homepage dashboard that I use!_

As promised, here is both the config for Docker and even Kubernetes!

### Docker Config

`docker-compose.yaml`

```yaml
version: "3.3"
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    restart: unless-stopped
    ports:
      - 3000:3000
    env_file: .env
    volumes:
      - ./config:/app/config # Make sure your local config directory exists
      - /var/run/docker.sock:/var/run/docker.sock # (optional) For docker integrations, see alternative methods
    environment:
      PUID: $PUID
      PGID: $PGID
```

`config/bookmarks.yaml`

```yaml
---
```

`config/services.yaml`

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/services
# icons found here https://github.com/walkxcode/dashboard-icons

- Hypervisor:
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
        description: pve1
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
            username: "{{HOMEPAGE_VAR_PROXMOX_USER}}"
            password: "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"
            node: xing-01
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
        description: pve2
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
            username: "{{HOMEPAGE_VAR_PROXMOX_USER}}"
            password: "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"
            node: xing-02
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
        description: pve2
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
            username: "{{HOMEPAGE_VAR_PROXMOX_USER}}"
            password: "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"
            node: xing-03
    - Proxmox:
        icon: proxmox.svg
        href: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
        description: pve4
        widget:
            type: proxmox
            url: "{{HOMEPAGE_VAR_PROXMOX_URL}}"
            username: "{{HOMEPAGE_VAR_PROXMOX_USER}}"
            password: "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"
            node: storinator
- Containers:
    - Rancher:
        icon: rancher.svg
        href: "{{HOMEPAGE_VAR_RACNHER_URL}}"
        description: k8s
    - Longhorn:
        icon: longhorn.svg
        href: "{{HOMEPAGE_VAR_LONGHORN_URL}}"
        description: k8s storage
    - Portainer:
        icon: portainer.svg
        href: "{{HOMEPAGE_VAR_PORTAINER_URL}}"
        description: docker
        widget:
            type: portainer
            url: "{{HOMEPAGE_VAR_PORTAINER_URL}}"
            env: 2
            key: "{{HOMEPAGE_VAR_PORTAINER_API_KEY}}"
- DNS:
    - Pi-Hole1:
        icon: pi-hole.svg
        href: "{{HOMEPAGE_VAR_PIHOLE_URL_1}}"
        description: quasar
        widget:
            type: pihole
            url: "{{HOMEPAGE_VAR_PIHOLE_URL_1}}"
            key: "{{HOMEPAGE_VAR_PIHOLE_API_KEY_1}}"
    - Pi-Hole2:
        icon: pi-hole.svg
        href: "{{HOMEPAGE_VAR_PIHOLE_URL_2}}"
        description: blazar
        widget:
            type: pihole
            url: "{{HOMEPAGE_VAR_PIHOLE_URL_2}}"
            key: "{{HOMEPAGE_VAR_PIHOLE_API_KEY_2}}"
    - Pi-Hole3:
        icon: pi-hole.svg
        href: "{{HOMEPAGE_VAR_PIHOLE_URL_3}}"
        description: electron
        widget:
            type: pihole
            url: "{{HOMEPAGE_VAR_PIHOLE_URL_3}}"
            key: "{{HOMEPAGE_VAR_PIHOLE_API_KEY_3}}"
- Network:
    - UniFi:
        icon: unifi.svg
        href: "{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"
        description: network
        widget:
            type: unifi
            url: "{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"
            username: "{{HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME}}"
            password: "{{HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD}}"
    - Uptime Kuma:
        icon: uptime-kuma.svg
        href: "{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"
        description: internal
        widget:
            type: uptimekuma
            url: "{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"
            slug: home
    - Uptime Robot:
        icon: https://play-lh.googleusercontent.com/cUrv0t00FYQ1GKLuOTvv8qjo1lSDjqZC16IOp3Fb6ijew6Br5m4o16HhDp0GBu_Bw8Y=w240-h480-rw
        href: https://uptimerobot.com/dashboard
        description: external
        widget:
            type: uptimerobot
            url: https://api.uptimerobot.com
            key: "{{HOMEPAGE_VAR_UPTIME_ROBOT_API_KEY}}"
- Storage:
    - TrueNAS:
        icon: truenas.svg
        href: "{{HOMEPAGE_VAR_TRUENAS_URL}}"
        description: scale
        widget:
            type: truenas
            url: "{{HOMEPAGE_VAR_TRUENAS_URL}}"
            key: "{{HOMEPAGE_VAR_TRUENAS_API_KEY}}"
    - MinIO:
        icon: minio.svg
        href: "{{HOMEPAGE_VAR_MINIO_URL}}"
        description: object storage
- Media:
    - Plex:
        icon: plex.svg
        href: "{{HOMEPAGE_VAR_PLEX_URL}}"
        description: media server
        widget:
            type: plex
            url: "{{HOMEPAGE_VAR_PLEX_URL}}"
            key: "{{HOMEPAGE_VAR_PLEX_API_TOKEN}}"
    - Tautulla:
        icon: tautulli.svg
        href: "{{HOMEPAGE_VAR_TAUTULLI_URL}}"
        description: plex stats
        widget:
            type: tautulli
            url: "{{HOMEPAGE_VAR_TAUTULLI_URL}}"
            key: "{{HOMEPAGE_VAR_TAUTULLI_API_KEY}}"
    - HDHomerun:
        icon: hdhomerun.png
        href: "{{HOMEPAGE_VAR_HDHOMERUN_URL}}"
        description: flex 4k
        widget:
            type: hdhomerun
            url: "{{HOMEPAGE_VAR_HDHOMERUN_URL}}"
- Remote Access:
    - PiKVM:
        icon: https://avatars.githubusercontent.com/u/41749659?s=200&v=4
        href: "{{HOMEPAGE_VAR_PIKVM_URL}}"
        description: remote kvm
    - IPMI:
        icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
        href: "{{HOMEPAGE_VAR_IPMI_1_URL}}"
        description: storinator
    - IPMI:
        icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
        href: "{{HOMEPAGE_VAR_IPMI_2_URL}}"
        description: hl15
    - Netboot:
        icon: https://netboot.xyz/img/nbxyz-laptop.gif
        href: "{{HOMEPAGE_VAR_NETBOOT_URL}}"
        description: network boot utility
    - Tripp Lite:
        icon: https://upload.wikimedia.org/wikipedia/commons/f/f9/Tripp_Lite_logo.svg
        href: "{{HOMEPAGE_VAR_UPS_1_URL}}"
        description: 1500
    - Eaton:
        icon: https://cdn11.bigcommerce.com/s-fg272t4iw0/images/stencil/1280x1280/products/2549/2802/C-12556__63907.1557814942.jpg?c=2
        href: "{{HOMEPAGE_VAR_UPS_2_URL}}"
        description: 5p
- Home Automation:
    - Home Assistant:
        icon: home-assistant.svg
        href: "{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"
        description: home
        widget:
            type: homeassistant
            url: "{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"
            key: "{{HOMEPAGE_VAR_HOME_ASSISTANT_API_KEY}}"
    - UniFi:
        icon: https://play-lh.googleusercontent.com/DmgQvSdocOrGr0D0rxSBE9sqh23Fw3ck3BgKRN788cZnOKgcZlcEAFRYwmUbp6vMTVI
        href: "{{HOMEPAGE_VAR_UNIFI_PROTECT_URL}}"
        description: protect
    - Scryped:
        icon: https://www.scrypted.app/images/web_hi_res_512.png
        href: "{{HOMEPAGE_VAR_SCRYPTED_URL}}"
        description: mgmt console
    - Broadlink Control:
        icon: https://nwzimg.wezhan.net/contents/sitefiles3606/18030899/images/5430245.png
        href: "{{HOMEPAGE_VAR_BROADLINK_CONTROL_URL}}"
        description: light control
- Other:
    - GitLab:
        icon: gitlab.svg
        href: https://gitlab.com
        description: source code
    - GitHub:
        icon: github.svg
        href: https://github.com
        description: source code
    - Shlink:
        icon: https://shlink.io/images/shlink-logo-blue.svg
        href: "{{HOMEPAGE_VAR_SHLINK_URL}}"
        description: dashboard%

```

`config/settings.yaml`

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/settings

title: Techno Tim Homepage

background:
  image: https://cdnb.artstation.com/p/assets/images/images/006/897/659/large/mikael-gustafsson-wallpaper-mikael-gustafsson.jpg
  blur: sm # sm, md, xl... see https://tailwindcss.com/docs/backdrop-blur
  saturate: 100 # 0, 50, 100... see https://tailwindcss.com/docs/backdrop-saturate
  brightness: 50 # 0, 50, 75... see https://tailwindcss.com/docs/backdrop-brightness
  opacity: 100 # 0-100

theme: dark
color: slate

useEqualHeights: true

layout:
  Hypervisor:
    header: true
    style: row
    columns: 4
  Containers:
    header: true
    style: row
    columns: 4
  DNS:
    header: true
    style: row
    columns: 4
  Network:
    header: true
    style: row
    columns: 4
  Remote Access:
    header: true
    style: row
    columns: 4
  Storage:
    header: true
    style: row
    columns: 4
  Media:
    header: true
    style: row
    columns: 4
  Home Automation:
    header: true
    style: row
    columns: 4
  Other:
    header: true
    style: row
    columns: 4
```

`config/widgets.yaml`

```yaml
---
# For configuration options and examples, please see:
# https://gethomepage.dev/latest/configs/service-widgets

- resources:
    cpu: true
    memory: true
    disk: /

- datetime:
    text_size: xl
    format:
      timeStyle: short
```

`.env`

```bash
PUID=1000
PGID=1000

HOMEPAGE_VAR_PIHOLE_API_KEY_1=
HOMEPAGE_VAR_PIHOLE_API_KEY_2=
HOMEPAGE_VAR_PIHOLE_API_KEY_3=

HOMEPAGE_VAR_PIHOLE_URL_1=
HOMEPAGE_VAR_PIHOLE_URL_2=
HOMEPAGE_VAR_PIHOLE_URL_3=

HOMEPAGE_VAR_PLEX_URL=
HOMEPAGE_VAR_PLEX_API_TOKEN=

HOMEPAGE_VAR_TAUTULLI_URL=
HOMEPAGE_VAR_TAUTULLI_API_KEY=

HOMEPAGE_VAR_HDHOMERUN_URL=

HOMEPAGE_VAR_HOME_ASSISTANT_URL=
HOMEPAGE_VAR_HOME_ASSISTANT_API_KEY=

HOMEPAGE_VAR_TRUENAS_URL=
HOMEPAGE_VAR_TRUENAS_API_KEY=

HOMEPAGE_VAR_UNIFI_NETWORK_URL=
HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME=
HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD=

HOMEPAGE_VAR_UNIFI_PROTECT_URL=

HOMEPAGE_VAR_UPTIME_KUMA_URL=

HOMEPAGE_VAR_MINIO_URL=

HOMEPAGE_VAR_RACNHER_URL=

HOMEPAGE_VAR_LONGHORN_URL=

HOMEPAGE_VAR_PORTAINER_URL=
HOMEPAGE_VAR_PORTAINER_API_KEY=

HOMEPAGE_VAR_PROXMOX_URL=
HOMEPAGE_VAR_PROXMOX_USER=
HOMEPAGE_VAR_PROXMOX_API_KEY=

HOMEPAGE_VAR_UPTIME_ROBOT_API_KEY=

HOMEPAGE_VAR_SCRYPTED_URL=

HOMEPAGE_VAR_PIKVM_URL=

HOMEPAGE_VAR_NETBOOT_URL=

HOMEPAGE_VAR_BROADLINK_CONTROL_URL=

HOMEPAGE_VAR_IPMI_1_URL=
HOMEPAGE_VAR_IPMI_2_URL=

HOMEPAGE_VAR_UPS_1_URL=
HOMEPAGE_VAR_UPS_2_URL=

HOMEPAGE_VAR_SHLINK_URL=
```

### Kubernetes Config

Coming soon!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I finally replaced my homepage Dashboard!<a href="https://t.co/e571uMSQ89">https://t.co/e571uMSQ89</a> <a href="https://t.co/eN5sFrsVyN">pic.twitter.com/eN5sFrsVyN</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1746914958204350468?ref_src=twsrc%5Etfw">January 15, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
