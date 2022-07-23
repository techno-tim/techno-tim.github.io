---
layout: post
title: "2 Factor Auth and Single Sign on with Authelia"
date: 2021-06-05 09:00:00 -0500
categories: traefik
tags: authelia homelab traefik portainer ssl docker self-hosted
---

[![2 Factor Auth and Single Sign on with Authelia?](https://img.youtube.com/vi/u6H-Qwf4nZA/0.jpg)](https://www.youtube.com/watch?v=u6H-Qwf4nZA "2 Factor Auth and Single Sign on with Authelia?")

Authelia is an open source Single Sign On and 2FA companion for reverse proxies.  It helps you secure your endpoints with single factor and 2 factor auth.  It works with Nginx, Traefik, and HA proxy.  Today, we'll configure Authelia with Portainer and Traefik and have 2 Factor up and running with brute force protection!

[Watch Video](https://www.youtube.com/watch?v=u6H-Qwf4nZA)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## Traefik

Authelia will work with other reverse proxies but I used Traefik.  If you want to configure Traefik as your reverse proxy see this [guide](https://docs.technotim.live/posts/traefik-portainer-ssl/).

## Docker Setup

See [this post](https://docs.technotim.live/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Authelia

`configuration.yml`,  `users_database.yml`, and `docker-compose.yml` can be found [here](https://github.com/techno-tim/launchpad/tree/master/docker/authelia)

Example `heimdall` can be found here [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/authelia-traefik/heimdall)

Traefik configuration changes can be found  [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/authelia-traefik/traefik)

## Generation a hashed password

```bash
$ docker run authelia/authelia:latest authelia hash-password 'yourpassword'
Password hash: $argon2id$v=19$m=65536$3oc26byQuSkQqksq$zM1QiTvVPrMfV6BVLs2t4gM+af5IN7euO0VB6+Q8ZFs
```

## Files and folders

```bash
mkdir authelia
cd authelia
mkdir config
cd config
nano configuration.yml
nano users_database.yml
cd ..
nano docker-compose.yml
```

### Create Authelia container

```bash
docker-compose up -d
```
