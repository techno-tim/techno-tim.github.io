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

create an `.env`` file for variables

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

Coming soon!

## Kubernetes

Coming soon!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I finally replaced my homepage Dashboard!<a href="https://t.co/e571uMSQ89">https://t.co/e571uMSQ89</a> <a href="https://t.co/eN5sFrsVyN">pic.twitter.com/eN5sFrsVyN</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1746914958204350468?ref_src=twsrc%5Etfw">January 15, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
