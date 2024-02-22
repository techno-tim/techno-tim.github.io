---
layout: post
title: "2 Factor Auth and Single Sign on with Authelia"
date: 2021-06-05 09:00:00 -0500
categories: traefik
tags: authelia homelab traefik portainer ssl docker self-hosted
image:
  path: /assets/img/headers/lock-night.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5I9P8AH/j+38MeEL//AIS7Uv7WsdV+JI8I6lCI7d/Cax+BfDcHi+G0t4/9Gvbfxzot5aaTrMN1H/y5zXsrXk2o3SV9dLl9rGPKtVC7u9ffmo27crV469bbJH5zTlL6tOqpNLmk4x0bXNTpynzSt7zkppSfKruPM7uUjxO48deMJLieSbxFq0ksk0ryv9uuk3yO7M77EmCJuYk7UAVc4UAACt7N6+5rr8F/x5l+SMJKkm01WbTabVWKvr29k7el36n/2Q==

---

Authelia is an open source Single Sign On and 2FA companion for reverse proxies.It helps you secure your endpoints with single factor and 2 factor auth.It works with Nginx, Traefik, and HA proxy.Today, we'll configure Authelia with Portainer and Traefik and have 2 Factor up and running with brute force protection!

{% include embed/youtube.html id='u6H-Qwf4nZA' %}

📺 [Watch Video](https://www.youtube.com/watch?v=u6H-Qwf4nZA)

## Traefik

Authelia will work with other reverse proxies but I used Traefik.If you want to configure Traefik as your reverse proxy see this [guide](/posts/traefik-portainer-ssl/).

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

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

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
