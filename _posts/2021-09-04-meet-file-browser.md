---
layout: post
title: "Meet File Browser, a Small but Mighty Web File Browser"
date: 2021-09-04 10:00:00 -0500
categories: self-hosted
tags: homelab portainer self-hosted docker rancher file-browser
---

[![Meet File Browser, a Small but Mighty Web File Browser](https://img.youtube.com/vi/W2yZ5_sd9Hc/0.jpg)](https://www.youtube.com/watch?v=W2yZ5_sd9Hc "Meet File Browser, a Small but Mighty Web File Browser")

Meet [File Browser](https://github.com/filebrowser/filebrowser), an open source, self-hosted alternative to services like Dropbox and other web based file browsers.  Today we'll configure a containerized version of File Browser and have you up and going in just a few minutes.  We'll also walk through creating, editing, moving, copying, and even sharing files and folders so that you get a better understanding about what File Browser is all about.

[Watch Video](https://www.youtube.com/watch?v=W2yZ5_sd9Hc)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## Docker Setup

See [this post](https://docs.technotim.live/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

If you're using Docker compose

```bash
mkdir filebrowser
cd filebrowser
touch docker-compose.yml
nano docker-compose.yml # copy the contents from below
touch filebrowser.db
docker-compose up -d --force-recreate
```

`docker-compose.yml`

```yml
---
version: '3'
services:
  file-browser:
    image: filebrowser/filebrowser
    container_name: file-browser
    user: 1000:1000
    ports:
      - 8081:80
    volumes:
      - /home/serveradmin/:/srv
      - /home/serveradmin/filebrowser/filebrowser.db:/database.db
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```

If you're using Rancher, Portainer, Open Media Vault, Unraid, or anything else with a GUI, just copy and paste the environment variables above into the form on the web page.
