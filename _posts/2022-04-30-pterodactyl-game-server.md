---
layout: post
title: "I Built the PERFECT Game Server with Pterodactyl and Docker"
date: 2022-04-30 08:00:00 -0500
categories: homelab 
tags: gaming pterodactyl docker redis mariabdb opensource
image:
  path: /assets/img/headers/retro-gaming.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP54f2KfCvw5i+FH/CwW+HugXvibRPg98R9Wng1sP4i8K+ItVOrnwnZX/iDwvr66laST6Ta6rNqWmSaNcaLLDrFrps80txZ2f2CX+muFcHwwvDbD5pPhjBzzaEcwp4vG/Wa8lj6cqtWlSjXw+IWIp0nQVOHLPCuhKT5n7s+SdM4Yyniuv4sYmjh+NcVRyChgcsr4DIsRlWGxlPAYzHZfgKePxdPEfWKEK1WSxNWrglisJWjhMRDDSrLG4elUwtf5bvfG/wAM0vLtZPhXetIt1OrtF42t7eJnErhmjt08GlIIyclIUJWJcIpIUV+dyWUQlKH1HGvkbjf+0aOvK7X/AORY97d36n+i0sdwRhG8LU4RzTFVMM3h6mKqcSZfTniZ0X7OVedOjwnClTnWlF1JQpRjTi5OMIxikl//2Q==
---

Pterodactyl is a free an open source dedicated game server.It comes with both a panel to configure and deploy your game servers as well as game server nodes to run your games.It runs games in Docker containers to keep them isolated and making them easier than ever to deploy.We're going to also use Docker to create our Pterodactyl server and the Wings agent making this truly Docker to the core.

<https://pterodactyl.io>

Be sure to ⭐ the [Pterodactyl GitHub repo](https://github.com/pterodactyl/panel) and the [Eggs repo (additional games)](https://github.com/parkervcp/eggs)

{% include embed/youtube.html id='_ypAmCcIlBE' %}

📺 [Watch Video](https://www.youtube.com/watch?v=_ypAmCcIlBE)

## Install Docker

To install docker, see [this post](/posts/docker-compose-install/)

## Reverse Proxy

Both your Pterodactyl Panel server as well as your Pterodactyl Wing server will need to be configured in your reverse proxy, each with their own public URL. If you need help configuring your reverse proxy, [see my guide on how to do that](/posts/traefik-portainer-ssl/).

## Need games 🎮?

Check out game deals on [Humble Games (affiliate link)](https://l.technotim.live/humble-store)

## Game Panel

```bash
mkdir pterodactyl
cd pterodactyl
mkdir panel
cd panel
nano docker-compose.yml
```

`docker-compose.yml`

```yml
version: '3.8'
x-common:
  database:
    &db-environment
    # Do not remove the "&db-password" from the end of the line below, it is important
    # for Panel functionality.
    MYSQL_PASSWORD: &db-password "CHANGE_ME"
    MYSQL_ROOT_PASSWORD: "CHANGE_ME_TOO"
  panel:
    &panel-environment
    # This URL should be the URL that your reverse proxy routes to the panel server
    APP_URL: "https://pterodactyl.example.com"
    # A list of valid timezones can be found here: http://php.net/manual/en/timezones.php
    APP_TIMEZONE: "UTC"
    APP_SERVICE_AUTHOR: "noreply@example.com"
    TRUSTED_PROXIES: "*" # Set this to your proxy IP
    # Uncomment the line below and set to a non-empty value if you want to use Let's Encrypt
    # to generate an SSL certificate for the Panel.
    # LE_EMAIL: ""
  mail:
    &mail-environment
    MAIL_FROM: "noreply@example.com"
    MAIL_DRIVER: "smtp"
    MAIL_HOST: "mail"
    MAIL_PORT: "1025"
    MAIL_USERNAME: ""
    MAIL_PASSWORD: ""
    MAIL_ENCRYPTION: "true"

#
# ------------------------------------------------------------------------------------------
# DANGER ZONE BELOW
#
# The remainder of this file likely does not need to be changed. Please only make modifications
# below if you understand what you are doing.
#
services:
  database:
    image: mariadb:10.5
    restart: always
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - "/srv/pterodactyl/database:/var/lib/mysql"
    environment:
      <<: *db-environment
      MYSQL_DATABASE: "panel"
      MYSQL_USER: "pterodactyl"
  cache:
    image: redis:alpine
    restart: always
  panel:
    image: ghcr.io/pterodactyl/panel:latest
    restart: always
    ports:
      - "80:80"
      - "443:443"
    links:
      - database
      - cache
    volumes:
      - "/srv/pterodactyl/var/:/app/var/"
      - "/srv/pterodactyl/nginx/:/etc/nginx/http.d/"
      - "/srv/pterodactyl/certs/:/etc/letsencrypt/"
      - "/srv/pterodactyl/logs/:/app/storage/logs"
    environment:
      <<: [*panel-environment, *mail-environment]
      DB_PASSWORD: *db-password
      APP_ENV: "production"
      APP_ENVIRONMENT_ONLY: "false"
      CACHE_DRIVER: "redis"
      SESSION_DRIVER: "redis"
      QUEUE_DRIVER: "redis"
      REDIS_HOST: "cache"
      DB_HOST: "database"
      DB_PORT: "3306"
networks:
  default:
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

Start the stack

```bash
docker-compose up -d
```

## Create a User

```bash
docker-compose run --rm panel php artisan p:user:make
```

## Wings

```bash
mkdir pterodactyl
cd pterodactyl
mkdir wings
cd wings
nano docker-compose.yml
```

`docker-compose.yml`

```yml
version: '3.8'

services:
  wings:
    image: ghcr.io/pterodactyl/wings:v1.6.1
    restart: always
    networks:
      - wings0
    ports:
      - "8080:8080"
      - "2022:2022"
      - "443:443"
    tty: true
    environment:
      TZ: "UTC"
      WINGS_UID: 988
      WINGS_GID: 988
      WINGS_USERNAME: pterodactyl
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "/var/lib/docker/containers/:/var/lib/docker/containers/"
      - "/etc/pterodactyl/:/etc/pterodactyl/"
      - "/var/lib/pterodactyl/:/var/lib/pterodactyl/"
      - "/var/log/pterodactyl/:/var/log/pterodactyl/"
      - "/tmp/pterodactyl/:/tmp/pterodactyl/"
      - "/etc/ssl/certs:/etc/ssl/certs:ro"
      # you may need /srv/daemon-data if you are upgrading from an old daemon
      #- "/srv/daemon-data/:/srv/daemon-data/"
      # Required for ssl if you use let's encrypt. uncomment to use.
      #- "/etc/letsencrypt/:/etc/letsencrypt/"
networks:
  wings0:
    name: wings0
    driver: bridge
    ipam:
      config:
        - subnet: "172.21.0.0/16"
    driver_opts:
      com.docker.network.bridge.name: wings0
```

Start the stack

```bash
docker-compose up -d
```


```bash
sudo nano /etc/pterodactyl/config.yml
```

Paste the contents from the config your panel generated for your node into this file
Note: The `FQDN` field when configuring the node in the panel should be the URL that your reverse proxy routes to your wing server. Also ensure you entered `443` for the `Daemon Port` field.

`config.yml`

```yml
debug: false
uuid: 716deb8f-7047-42ad-9323-4a25ae49118b
token_id: 7PoSfql3hdKjbMKn
token: apEo1esCKe5sEWkpfnRB5xakj3mc0aM6jglacgBcsIsgglBtOm0oV1W3efTbwarN
api:
  host: 0.0.0.0
  port: 443
  ssl:
    enabled: false
    cert: /etc/letsencrypt/live/node-01.example.com/fullchain.pem
    key: /etc/letsencrypt/live/node-01.example.com/privkey.pem
  upload_limit: 100
system:
  data: /var/lib/pterodactyl/volumes
  sftp:
    bind_port: 2022
allowed_mounts: []
remote: 'https://pterodactyl.example.com'
```

Restart the stack

```bash
docker-compose up -d --force-recreate
```

## Troubleshooting

### Missing Metrics


If you aren't seeing your stats in the console


```bash
sudo nano /etc/default/grub
```

add additional parameters to `GRUB_CMDLINE_LINUX_DEFAULT`

```bash
GRUB_CMDLINE_LINUX_DEFAULT="swapaccount=1 systemd.unified_cgroup_hierarchy=1"
```

```bash
sudo update-grub
sudo reboot
```


## Kubernetes

If you are looking to install the Pterodactyl Panel on kubernetes, [see the manifests here](https://github.com/techno-tim/launchpad/tree/master/kubernetes/pterodactyl).

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
