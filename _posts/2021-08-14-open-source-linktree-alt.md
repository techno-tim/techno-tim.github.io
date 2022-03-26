---
layout: post
title: "Self-Hosted, DIY, Open Source Alternative to Linktree"
date: 2021-08-14 11:00:00 -0500
categories: self-hosted
tags: homelab pi-hole dns littlelink-server portainer self-hosted docker rancher
---

[![Self-Hosted, DIY, Open Source Alternative to Linktree](https://img.youtube.com/vi/42SqfI_AjXU/0.jpg)](https://www.youtube.com/watch?v=42SqfI_AjXU "Self-Hosted, DIY, Open Source Alternative to Linktree")

Meet LittleLink & LittleLink-Server  - a DIY, self hosted, and open source alternative to the popular service Linktree.  This web site inside of a container allows you to create and host your own web site with all of your social information and links, giving your followers multiple ways to connect with you!  In this video we talk about what LittleLink-Server is, what it does, and how to create your own site using this Docker container with only a few environment variables, no knowledge of web development required.  Be sure to check the documentation for details!

[Watch Video](https://www.youtube.com/watch?v=42SqfI_AjXU)

See all the hardware I recommend at <https://l.technotim.live/gear>

(see video description for gear links)

You can find the LittleLink-Server repo [here](https://github.com/techno-tim/littlelink-server).

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## Docker Setup

See [this post](https://docs.technotim.live/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

```bash
mkdir littlelink-server
cd littlelink-server
touch docker-compose.yml
```

If you're using Docker compose (see the [GitHub repo](https://github.com/techno-tim/littlelink-server) for the latest file)

`docker-compose.yml`

```yml
---
version: '3'
services:
  little-link:
    image: ghcr.io/techno-tim/littlelink-server:latest
    container_name: littlelink-server
    environment:
      - META_TITLE=Techno Tim
      - META_DESCRIPTION=Techno Tim Link page
      - META_AUTHOR=Techno Tim
      - THEME=Dark
      - FAVICON_URL=https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_200x200.jpg
      - AVATAR_URL=https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_200x200.jpg
      - AVATAR_2X_URL=https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_400x400.jpg
      - AVATAR_ALT=Techno Tim Profile Pic
      - NAME=TechnoTim
      - BIO=Hey! Just a place where you can connect with me!
      - GITHUB=https://l.technotim.live/github
      - TWITTER=https://l.technotim.live/twitter
      - INSTAGRAM=https://l.technotim.live/instagram
      - YOUTUBE=https://l.technotim.live/subscribe
      - TWITCH=https://l.technotim.live/twitch/
      - DISCORD=https://l.technotim.live/discord
      - TIKTOK=https://l.technotim.live/tiktok
      - KIT=https://l.technotim.live/gear
      # - FACEBOOK=https://facebook.com
      # - FACEBOOK_MESSENGER=https://facebook.com
      # - LINKED_IN=https://linkedin.com
      # - PRODUCT_HUNT=https://www.producthunt.com/
      # - SNAPCHAT=https://www.snapchat.com/
      # - SPOTIFY=https://www.spotify.com/
      # - REDDIT=https://www.reddit.com/
      # - MEDIUM=https://medium.com
      # - PINTEREST=https://www.pinterest.com/
      # - EMAIL=you@example.com
      # - EMAIL_ALT=you@example.com
      # - SOUND_CLOUD=https://souncloud.com
      # - FIGMA=https://figma.com
      # - TELEGRAM=https://telegram.org/
      # - TUMBLR=https://www.tumblr.com/
      # - STEAM=https://steamcommunity.com/
      # - VIMEO=https://vimeo.com/
      # - WORDPRESS=https://wordpress.com/
      # - GOODREADS=https://www.goodreads.com/
      # - SKOOB=https://www.skoob.com.br/
      - FOOTER=Thanks for stopping by!
    ports:
      - 8080:3000
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```

If you're running docker only

Docker command

```bash
docker run -d \
  --name=littlelink-server \
  -p 8080:3000 \
  -e META_TITLE='Techno Tim' \
  -e META_DESCRIPTION='Techno Tim Link page' \
  -e META_AUTHOR='Techno Tim' \
  -e THEME='Dark' \
  -e FAVICON_URL='https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_200x200.jpg' \
  -e AVATAR_URL='https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_200x200.jpg' \
  -e AVATAR_2X_URL='https://pbs.twimg.com/profile_images/1286144221217316864/qIAsKOpB_400x400.jpg' \
  -e AVATAR_ALT='Techno Tim Profile Pic' \
  -e NAME='TechnoTim' \
  -e BIO='Hey! Just a place where you can connect with me!' \
  -e GITHUB='https://l.technotim.live/github' \
  -e TWITTER='https://l.technotim.live/twitter' \
  -e INSTAGRAM='https://l.technotim.live/instagram' \
  -e YOUTUBE='https://l.technotim.live/subscribe' \
  -e TWITCH='https://l.technotim.live/twitch' \
  -e DISCORD='https://l.technotim.live/discord' \
  -e TIKTOK='https://l.technotim.live/tiktok' \
  -e KIT='https://l.technotim.live/gear' \
  --restart unless-stopped \
  ghcr.io/techno-tim/littlelink-server:latest
```

If you're using Rancher, Portainer, Open Media Vault, Unraid, or anything else with a GUI, just copy and paste the environment variables above into the form on the web page.
