---
layout: post
title: "Meet Homepage - Your HomeLab Services Dashboard"
date: 2024-01-15 08:00:00 -0500
categories: self-hosted
tags: homepage dashboard docker open-source homelab
image:
 path: /assets/img/headers/homepage-dashboard-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP46v2dvGXwj8WeKvh58NfEX7KnwQ1q7u5NK0PUPHOoeJ/2lo/EWsTvqVqt1req6bo37QejeEV1G5s2uLfytD8O6FpsE0kV3b2MbweXJ8xxzn8+F+GM1z2GH+uf2dhq2JeFeInhVXVKnKp7P6xSjOdNScUm1Gfu3Ti1ofVcB5BS4m4jweU1sRPCwrKTdaFKlXnGzivdp1lKnze9dNxfK0mlc7fXP2QZn1vWHtfH+maZatqmoNbabZeABLZ6fA13MYbK0l1XxdqepyW1pGVggk1HUtQv3ijRry+u7gyTyfilHxwoVqNKr/qlVj7WlTqcq4mxXu88FK2mWpaXtol6LY/oJfR/xTSa40oJNJ2fCOCk1ddZPNG2/N6vd6n//2Q==
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

Make a directory

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

Edit it

```bash
nano docker-compose.yaml
```

Place the contents

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

Create an `.env` file for variables

```bash
touch .env
```

Edit it

```bash
nano .env
```

add to file:

```bash
PUID=1000
PGID=1000
```

Save and exit

Start the container

```bash
docker compose up -d
```

> *Note: The container can take up to 60 seconds to start the first time.  It's a good idea to check the container to see if it is passing health checks before browsing to your site.*
{: .prompt-info }

Check to be sure you see that the container is healthy.

You can check by running:

```bash
docker ps
```

You should see something like:

```
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS                    PORTS                                       NAMES
8d841cf77e6f   ghcr.io/gethomepage/homepage:latest   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes (healthy)    0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   homepage
```

Once it's healthy, visit `http://<IP-ADDRESS-DOCKER-MACHINE>:3000`

You should see your new homepage!

## Configure

On docker machine, cd into `config` directory

```bash
cd config
```

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

Save, exit, and revisit your homepage

Should refresh, if not click the refresh in lower right hand corner

Title of document should now be

> My Awesome Homepage

If we want, we can also customize the background but updating this file too

Edit `settings.yaml`

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

> *Why do this?  Isn't this a lot of work?* <br /> 1 word, it's "repeatable".  We can back up our yaml files and even share them if we want.  Also works great with Kubernetes since you can pass a `ConfigMap` file to your deployment thus not needing a volume.
{: .prompt-info }

## Services

Services are configured in `service.yaml` and really are button for accessing some of your services

Edit `service.yaml`

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

> *Note: If you're using Material Design Icons or Simple Icons you can change the color of the icon by appending the hex values to the icon name as shown above.*
{: .prompt-info }

## Service Widgets

These extend the functionality of service buttons.  Optional but cool.

Edit `service.yaml`

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
        widget:
          type: pihole
          url: http://192.168.60.10
          key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY}}"{% endraw %} # <--- updated with API key from PiHole
    - Cowboy:
        icon: mdi-account-cowboy-hat-#FF0000 # icons found here https://pictogrammers.com/library/mdi/
        href: https://localhost/
        description: giddyup service
    - McDonald’s:
        icon: si-mcdonalds-#FFD700 # icons found here https://simpleicons.org/
        href: https://www.mcdonalds.com/
        description: homepage
```

Stop the Docker container

`docker stop homepage`

Start the Docker container

`docker start homepage`

> *Note: I have noticed that sometimes you need to recreate the container in order for the variables from your `.env` to be replaced.  Not sure if this is a feature or a bug, but `docker compose up -d --force-recreate` will stop the old container, remove it, and create a new one*
{: .prompt-warning }

We should now see pi hole statistics

## Widgets

Widgets are standalone items like the resource and search at the top.

If you want to edit these items:

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
        href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
        description: pve1
        widget:
            type: proxmox
            url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            username: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
            password: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
            node: xing-01
    - Proxmox:
        icon: proxmox.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
        description: pve2
        widget:
            type: proxmox
            url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            username: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
            password: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
            node: xing-02
    - Proxmox:
        icon: proxmox.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
        description: pve2
        widget:
            type: proxmox
            url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            username: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
            password: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
            node: xing-03
    - Proxmox:
        icon: proxmox.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
        description: pve4
        widget:
            type: proxmox
            url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            username: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
            password: {% raw %} "{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
            node: storinator
- Containers:
    - Rancher:
        icon: rancher.svg
        href: {% raw %}"{{HOMEPAGE_VAR_RACNHER_URL}}"{% endraw %}
        description: k8s
    - Longhorn:
        icon: longhorn.svg
        href: {% raw %}"{{HOMEPAGE_VAR_LONGHORN_URL}}"{% endraw %}
        description: k8s storage
    - Portainer:
        icon: portainer.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_URL}}"{% endraw %}
        description: docker
        widget:
            type: portainer
            url: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_URL}}"{% endraw %}
            env: 2
            key: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_API_KEY}}"{% endraw %}
- DNS:
    - Pi-Hole1:
        icon: pi-hole.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_1}}"{% endraw %}
        description: quasar
        widget:
            type: pihole
            url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_1}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_1}}"{% endraw %}
    - Pi-Hole2:
        icon: pi-hole.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_2}}"{% endraw %}
        description: blazar
        widget:
            type: pihole
            url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_2}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_2}}"{% endraw %}
    - Pi-Hole3:
        icon: pi-hole.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_3}}"{% endraw %}
        description: electron
        widget:
            type: pihole
            url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_3}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_3}}"{% endraw %}
- Network:
    - UniFi:
        icon: unifi.svg
        href: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"{% endraw %}
        description: network
        widget:
            type: unifi
            url: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"{% endraw %}
            username: {% raw %} "{{HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME}}"{% endraw %}
            password: {% raw %} "{{HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD}}"{% endraw %}
    - Uptime Kuma:
        icon: uptime-kuma.svg
        href: {% raw %}"{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"{% endraw %}
        description: internal
        widget:
            type: uptimekuma
            url: {% raw %}"{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"{% endraw %}
            slug: home
    - Uptime Robot:
        icon: https://play-lh.googleusercontent.com/cUrv0t00FYQ1GKLuOTvv8qjo1lSDjqZC16IOp3Fb6ijew6Br5m4o16HhDp0GBu_Bw8Y=w240-h480-rw
        href: https://uptimerobot.com/dashboard
        description: external
        widget:
            type: uptimerobot
            url: https://api.uptimerobot.com
            key: {% raw %}"{{HOMEPAGE_VAR_UPTIME_ROBOT_API_KEY}}"{% endraw %}
- Storage:
    - TrueNAS:
        icon: truenas.svg
        href: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_URL}}"{% endraw %}
        description: scale
        widget:
            type: truenas
            url: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_URL}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_API_KEY}}"{% endraw %}
    - MinIO:
        icon: minio.svg
        href: {% raw %}"{{HOMEPAGE_VAR_MINIO_URL}}"{% endraw %}
        description: object storage
- Media:
    - Plex:
        icon: plex.svg
        href: {% raw %}"{{HOMEPAGE_VAR_PLEX_URL}}"{% endraw %}
        description: media server
        widget:
            type: plex
            url: {% raw %}"{{HOMEPAGE_VAR_PLEX_URL}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_PLEX_API_TOKEN}}"{% endraw %}
    - Tautulli:
        icon: tautulli.svg
        href: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_URL}}"{% endraw %}
        description: plex stats
        widget:
            type: tautulli
            url: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_URL}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_API_KEY}}"{% endraw %}
    - HDHomerun:
        icon: hdhomerun.png
        href: {% raw %}"{{HOMEPAGE_VAR_HDHOMERUN_URL}}"{% endraw %}
        description: flex 4k
        widget:
            type: hdhomerun
            url: {% raw %}"{{HOMEPAGE_VAR_HDHOMERUN_URL}}"{% endraw %}
- Remote Access:
    - PiKVM:
        icon: https://avatars.githubusercontent.com/u/41749659?s=200&v=4
        href: {% raw %}"{{HOMEPAGE_VAR_PIKVM_URL}}"{% endraw %}
        description: remote kvm
    - IPMI:
        icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
        href: {% raw %}"{{HOMEPAGE_VAR_IPMI_1_URL}}"{% endraw %}
        description: storinator
    - IPMI:
        icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
        href: {% raw %}"{{HOMEPAGE_VAR_IPMI_2_URL}}"{% endraw %}
        description: hl15
    - Netboot:
        icon: https://netboot.xyz/img/nbxyz-laptop.gif
        href: {% raw %}"{{HOMEPAGE_VAR_NETBOOT_URL}}"{% endraw %}
        description: network boot utility
    - Tripp Lite:
        icon: https://upload.wikimedia.org/wikipedia/commons/f/f9/Tripp_Lite_logo.svg
        href: {% raw %}"{{HOMEPAGE_VAR_UPS_1_URL}}"{% endraw %}
        description: 1500
    - Eaton:
        icon: https://cdn11.bigcommerce.com/s-fg272t4iw0/images/stencil/1280x1280/products/2549/2802/C-12556__63907.1557814942.jpg?c=2
        href: {% raw %}"{{HOMEPAGE_VAR_UPS_2_URL}}"{% endraw %}
        description: 5p
- Home Automation:
    - Home Assistant:
        icon: home-assistant.svg
        href: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"{% endraw %}
        description: home
        widget:
            type: homeassistant
            url: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"{% endraw %}
            key: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_API_KEY}}"{% endraw %}
    - UniFi:
        icon: https://play-lh.googleusercontent.com/DmgQvSdocOrGr0D0rxSBE9sqh23Fw3ck3BgKRN788cZnOKgcZlcEAFRYwmUbp6vMTVI
        href: {% raw %}"{{HOMEPAGE_VAR_UNIFI_PROTECT_URL}}"{% endraw %}
        description: protect
    - Scryped:
        icon: https://www.scrypted.app/images/web_hi_res_512.png
        href: {% raw %}"{{HOMEPAGE_VAR_SCRYPTED_URL}}"{% endraw %}
        description: mgmt console
    - Broadlink Control:
        icon: https://nwzimg.wezhan.net/contents/sitefiles3606/18030899/images/5430245.png
        href: {% raw %}"{{HOMEPAGE_VAR_BROADLINK_CONTROL_URL}}"{% endraw %}
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
        href: {% raw %}"{{HOMEPAGE_VAR_SHLINK_URL}}"{% endraw %}
        description: dashboard

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

> *Note: These variables will be replace in the configuration above.  You will need to supply your own values here in your file.*
{: .prompt-info }

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

Here's my Kubernetes config!

`deployment.yaml`

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: homepage
  namespace: default
  labels:
    app: homepage
  annotations:
    reloader.stakater.com/auto: "true"
spec:
  selector:
    matchLabels:
      app: homepage
  replicas: 3
  progressDeadlineSeconds: 600
  revisionHistoryLimit: 1
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 1
  template:
    metadata:
      labels:
        app: homepage
      annotations:
        deploy-date: "deploy-date-value"
    spec:
      containers:
        - name: homepage
          image: ghcr.io/gethomepage/homepage:v0.8.4
          resources:
            requests:
              memory: 128Mi
              cpu: 200m
          envFrom:
            - secretRef:
              name: homepage-secret
          ports:
            - containerPort: 3000
              name: http
          readinessProbe:
            httpGet:
              path: /
              port: http
            initialDelaySeconds: 60
            periodSeconds: 10
            failureThreshold: 5
            timeoutSeconds: 5
          livenessProbe:
            httpGet:
              path: /
              port: http
            initialDelaySeconds: 10
            periodSeconds: 10
            timeoutSeconds: 5
          volumeMounts:
            - mountPath: /app/config/custom.js
              name: homepage-config
              subPath: custom.js
            - mountPath: /app/config/custom.css
              name: homepage-config
              subPath: custom.css
            - mountPath: /app/config/bookmarks.yaml
              name: homepage-config
              subPath: bookmarks.yaml
            - mountPath: /app/config/docker.yaml
              name: homepage-config
              subPath: docker.yaml
            - mountPath: /app/config/kubernetes.yaml
              name: homepage-config
              subPath: kubernetes.yaml
            - mountPath: /app/config/services.yaml
              name: homepage-config
              subPath: services.yaml
            - mountPath: /app/config/settings.yaml
              name: homepage-config
              subPath: settings.yaml
            - mountPath: /app/config/widgets.yaml
              name: homepage-config
              subPath: widgets.yaml
            - mountPath: /app/config/logs
              name: logs
      volumes:
        - name: homepage-config
          configMap:
            name: homepage
        - name: logs
          emptyDir: {}
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: topology.kubernetes.io/zone
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: homepage
```

`config.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: homepage
  namespace: default
  labels:
    app: homepage
data:
  kubernetes.yaml: |
    mode: cluster
  settings.yaml: |
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
  custom.css: ""
  custom.js: ""
  bookmarks.yaml: ""
  services.yaml: |
    - Hypervisor:
        - Proxmox:
            icon: proxmox.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            description: pve1
            widget:
                type: proxmox
                url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
                username: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
                password: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
                node: xing-01
        - Proxmox:
            icon: proxmox.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            description: pve2
            widget:
                type: proxmox
                url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
                username: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
                password: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
                node: xing-02
        - Proxmox:
            icon: proxmox.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            description: pve2
            widget:
                type: proxmox
                url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
                username: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
                password: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
                node: xing-03
        - Proxmox:
            icon: proxmox.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
            description: pve4
            widget:
                type: proxmox
                url: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_URL}}"{% endraw %}
                username: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_USER}}"{% endraw %}
                password: {% raw %}"{{HOMEPAGE_VAR_PROXMOX_API_KEY}}"{% endraw %}
                node: storinator
    - Containers:
        - Rancher:
            icon: rancher.svg
            href: {% raw %}"{{HOMEPAGE_VAR_RACNHER_URL}}"{% endraw %}
            description: k8s
        - Longhorn:
            icon: longhorn.svg
            href: {% raw %}"{{HOMEPAGE_VAR_LONGHORN_URL}}"{% endraw %}
            description: k8s storage
        - Portainer:
            icon: portainer.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_URL}}"{% endraw %}
            description: docker
            widget:
                type: portainer
                url: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_URL}}"{% endraw %}
                env: 2
                key: {% raw %}"{{HOMEPAGE_VAR_PORTAINER_API_KEY}}"{% endraw %}
    - DNS:
        - Pi-Hole1:
            icon: pi-hole.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_1}}"{% endraw %}
            description: quasar
            widget:
                type: pihole
                url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_1}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_1}}"{% endraw %}
        - Pi-Hole2:
            icon: pi-hole.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_2}}"{% endraw %}
            description: blazar
            widget:
                type: pihole
                url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_2}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_2}}"{% endraw %}
        - Pi-Hole3:
            icon: pi-hole.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_3}}"{% endraw %}
            description: electron
            widget:
                type: pihole
                url: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_URL_3}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_PIHOLE_API_KEY_3}}"{% endraw %}
    - Network:
        - UniFi:
            icon: unifi.svg
            href: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"{% endraw %}
            description: network
            widget:
                type: unifi
                url: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_URL}}"{% endraw %}
                username: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_USERNAME}}"{% endraw %}
                password: {% raw %}"{{HOMEPAGE_VAR_UNIFI_NETWORK_PASSWORD}}"{% endraw %}
        - Uptime Kuma:
            icon: uptime-kuma.svg
            href: {% raw %}"{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"{% endraw %}
            description: internal
            widget:
                type: uptimekuma
                url: {% raw %}"{{HOMEPAGE_VAR_UPTIME_KUMA_URL}}"{% endraw %}
                slug: home
        - Uptime Robot:
            icon: https://play-lh.googleusercontent.com/cUrv0t00FYQ1GKLuOTvv8qjo1lSDjqZC16IOp3Fb6ijew6Br5m4o16HhDp0GBu_Bw8Y=w240-h480-rw
            href: https://uptimerobot.com/dashboard
            description: external
            widget:
                type: uptimerobot
                url: https://api.uptimerobot.com
                key: {% raw %}"{{HOMEPAGE_VAR_UPTIME_ROBOT_API_KEY}}"{% endraw %}
    - Storage:
        - TrueNAS:
            icon: truenas.svg
            href: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_URL}}"{% endraw %}
            description: scale
            widget:
                type: truenas
                url: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_URL}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_TRUENAS_API_KEY}}"{% endraw %}
        - MinIO:
            icon: minio.svg
            href: {% raw %}"{{HOMEPAGE_VAR_MINIO_URL}}"{% endraw %}
            description: object storage
    - Media:
        - Plex:
            icon: plex.svg
            href: {% raw %}"{{HOMEPAGE_VAR_PLEX_URL}}"{% endraw %}
            description: media server
            widget:
                type: plex
                url: {% raw %}"{{HOMEPAGE_VAR_PLEX_URL}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_PLEX_API_TOKEN}}"{% endraw %}
        - Tautulla:
            icon: tautulli.svg
            href: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_URL}}"{% endraw %}
            description: plex stats
            widget:
                type: tautulli
                url: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_URL}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_TAUTULLI_API_KEY}}"{% endraw %}
        - HDHomerun:
            icon: hdhomerun.png
            href: {% raw %}"{{HOMEPAGE_VAR_HDHOMERUN_URL}}"{% endraw %}
            description: flex 4k
            widget:
                type: hdhomerun
                url: {% raw %}"{{HOMEPAGE_VAR_HDHOMERUN_URL}}"{% endraw %}
    - Remote Access:
        - PiKVM:
            icon: https://avatars.githubusercontent.com/u/41749659?s=200&v=4
            href: {% raw %}"{{HOMEPAGE_VAR_PIKVM_URL}}"{% endraw %}
            description: remote kvm
        - IPMI:
            icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
            href: {% raw %}"{{HOMEPAGE_VAR_IPMI_1_URL}}"{% endraw %}
            description: storinator
        - IPMI:
            icon: https://upload.wikimedia.org/wikipedia/commons/1/1d/Super_Micro_Computer_Logo.svg
            href: {% raw %}"{{HOMEPAGE_VAR_IPMI_2_URL}}"{% endraw %}
            description: hl15
        - Netboot:
            icon: https://netboot.xyz/img/nbxyz-laptop.gif
            href: {% raw %}"{{HOMEPAGE_VAR_NETBOOT_URL}}"{% endraw %}
            description: network boot utility
        - Tripp Lite:
            icon: https://upload.wikimedia.org/wikipedia/commons/f/f9/Tripp_Lite_logo.svg
            href: {% raw %}"{{HOMEPAGE_VAR_UPS_1_URL}}"{% endraw %}
            description: 1500
        - Eaton:
            icon: https://cdn11.bigcommerce.com/s-fg272t4iw0/images/stencil/1280x1280/products/2549/2802/C-12556__63907.1557814942.jpg?c=2
            href: {% raw %}"{{HOMEPAGE_VAR_UPS_2_URL}}"{% endraw %}
            description: 5p
    - Home Automation:
        - Home Assistant:
            icon: home-assistant.svg
            href: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"{% endraw %}
            description: home
            widget:
                type: homeassistant
                url: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_URL}}"{% endraw %}
                key: {% raw %}"{{HOMEPAGE_VAR_HOME_ASSISTANT_API_KEY}}"{% endraw %}
        - UniFi:
            icon: https://play-lh.googleusercontent.com/DmgQvSdocOrGr0D0rxSBE9sqh23Fw3ck3BgKRN788cZnOKgcZlcEAFRYwmUbp6vMTVI
            href: {% raw %}"{{HOMEPAGE_VAR_UNIFI_PROTECT_URL}}"{% endraw %}
            description: protect
        - Scryped:
            icon: https://www.scrypted.app/images/web_hi_res_512.png
            href: {% raw %}"{{HOMEPAGE_VAR_SCRYPTED_URL}}"{% endraw %}
            description: mgmt console
        - Broadlink Control:
            icon: https://nwzimg.wezhan.net/contents/sitefiles3606/18030899/images/5430245.png
            href: {% raw %}"{{HOMEPAGE_VAR_BROADLINK_CONTROL_URL}}"{% endraw %}
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
            href: {% raw %}"{{HOMEPAGE_VAR_SHLINK_URL}}"{% endraw %}
            description: dashboard
  widgets.yaml: |
    - resources:
        cpu: true
        memory: true
        disk: /

    - datetime:
        text_size: xl
        format:
          timeStyle: short
  docker.yaml: ""
```

`secret.yaml`

```yaml
kind: Secret
apiVersion: v1
type: Opaque
metadata:
    name: homepage-secret
    namespace: default
stringData:
    HOMEPAGE_VAR_PIHOLE_API_KEY_1: ""
    HOMEPAGE_VAR_PIHOLE_API_KEY_2: ""
    HOMEPAGE_VAR_PIHOLE_API_KEY_3: ""
    HOMEPAGE_VAR_PIHOLE_URL_1: ""
    HOMEPAGE_VAR_PIHOLE_URL_2: ""
    HOMEPAGE_VAR_PIHOLE_URL_3: ""
    HOMEPAGE_VAR_PLEX_url: ""
    HOMEPAGE_VAR_PLEX_API_TOKEN: ""
    HOMEPAGE_VAR_TAUTULLI_url: ""
    HOMEPAGE_VAR_TAUTULLI_API_key: ""
    HOMEPAGE_VAR_HDHOMERUN_url: ""
    HOMEPAGE_VAR_HOME_ASSISTANT_url: ""
    HOMEPAGE_VAR_HOME_ASSISTANT_API_key: ""
    HOMEPAGE_VAR_TRUENAS_url: ""
    HOMEPAGE_VAR_TRUENAS_API_key: ""
    HOMEPAGE_VAR_UNIFI_NETWORK_url: ""
    HOMEPAGE_VAR_UNIFI_NETWORK_username: ""
    HOMEPAGE_VAR_UNIFI_NETWORK_password: ""
    HOMEPAGE_VAR_UNIFI_PROTECT_url: ""
    HOMEPAGE_VAR_UPTIME_KUMA_url: ""
    HOMEPAGE_VAR_MINIO_url: ""
    HOMEPAGE_VAR_RACNHER_url: ""
    HOMEPAGE_VAR_LONGHORN_url: ""
    HOMEPAGE_VAR_PORTAINER_url: ""
    HOMEPAGE_VAR_PORTAINER_API_key: ""
    HOMEPAGE_VAR_PROXMOX_url: ""
    HOMEPAGE_VAR_PROXMOX_USER: ""
    HOMEPAGE_VAR_PROXMOX_API_key: ""
    HOMEPAGE_VAR_UPTIME_ROBOT_API_key: ""
    HOMEPAGE_VAR_SCRYPTED_url: ""
    HOMEPAGE_VAR_PIKVM_url: ""
    HOMEPAGE_VAR_NETBOOT_url: ""
    HOMEPAGE_VAR_BROADLINK_CONTROL_url: ""
    HOMEPAGE_VAR_IPMI_1_url: ""
    HOMEPAGE_VAR_IPMI_2_url: ""
    HOMEPAGE_VAR_UPS_1_url: ""
    HOMEPAGE_VAR_UPS_2_url: ""
    HOMEPAGE_VAR_SHLINK_url: ""
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I finally replaced my homepage Dashboard!<a href="https://t.co/e571uMSQ89">https://t.co/e571uMSQ89</a> <a href="https://t.co/eN5sFrsVyN">pic.twitter.com/eN5sFrsVyN</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1746914958204350468?ref_src=twsrc%5Etfw">January 15, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
