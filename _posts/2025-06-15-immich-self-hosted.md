---
layout: post
title: "Take Control of Your Photos – Self-Host Immich on Your Server"
date: 2025-06-15 08:00:00 -0500
categories: self-hosted
tags: homelab immich self-hosted
image:
 path: /assets/img/headers/immich-self-hosted-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP57vgP8e/2S9X8OR6B8QP2QNR+KHifwppTm+8WeJvjn4ktLHW9Ul0jW9Rlvbbwrb+Hb1PDKXkti0t4uha7byMVWC2ktlmM9v52Io+wlTwtKlRq0eekqqqSnSVOM1Tg3h4QhUSfvVXyXpxbUXdOo1S0rV5ZflNXGUsRXr18Bl869SVWEKVTEzo0lUl7XEQnVlUlUmtakqadvecX8K8W1C58JXd/fXWl+GH0jTLm8ubjTtJN+moHS7GaZ5LTTjfy2cEt6bK3aO2N3JDDJc+V5zxRs5QdVDCOvQo1niMQnWpU6rXtpOzqQU7X5Ve17Xsr72R+ZYzj/AOq4vFYX+xcDU+rYmvQ5/h5/Y1ZU+fl5Xbm5b2u7Xtd7n//Z
---

Protect your personal photos and videos by hosting them yourself. In this video, you’ll learn how to install Immich, an open-source photo and video platform, on your own home server using Docker. Take control of your data with a fast, modern interface, GPU-accelerated features, and the ability to use your own NAS or network storage.

{% include embed/youtube.html id='ehX0cl3IfdA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=ehX0cl3IfdA)

## Info

To to learn more about immich, [check out the GitHub repo](https://github.com/immich-app/immich)

## Install Docker

To install docker, see [this post](/posts/docker-compose-install/)

## GPU

check for card

```shell
lspci
```

Supported NVIDIA cards (5.2 CUDA and higher)

- <https://developer.nvidia.com/cuda-gpus>

list all drivers

```shell
ubuntu-drivers devices
```

install recommended nvidia drivers

```shell
sudo ubuntu-drivers install
```

reboot

```shell
sudo reboot
```

check to see if drivers are installed and working

```shell
nvidia-smi
```

## NVIDIA Container Toolkit

<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html>

Configure the production repository:

```shell
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

update packages

```shell
sudo apt-get update
```

Install NVIDIA Container Toolkit packages

```shell
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.17.8-1
  sudo apt-get install -y \
      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
```

Configure docker to run the toolkit

```shell
sudo nvidia-ctk runtime configure --runtime=docker
```

restart docker

```shell
sudo systemctl restart docker
```

run nvidia smi inside the ubuntu container

```shell
docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

## Configure

create folders for our stack

```shell
sudo mkdir -p /opt/stacks/immich
```

change ownership of the folder (change group:user)

```shell
sudo chown serveradmin:serveradmin -R /opt/stacks
```

change directories

```shell
cd /opt/stacks/immich
```

create our compose file

```shell
nano compose.yml
```

```yaml
name: immich

services:
  immich-server:
    container_name: immich_server
    image: ghcr.io/immich-app/immich-server:${IMMICH_VERSION:-release}
    extends:
      file: hwaccel.transcoding.yml
      service: ${TRANSCODING_BACKEND:-cpu}
    volumes:
      - ${UPLOAD_LOCATION}:/usr/src/app/upload
    #   - /mnt/photos:/mnt/photos:ro # update and uncomment if you are using a network share
      - /etc/localtime:/etc/localtime:ro
    env_file:
      - .env
    ports:
      - '2283:2283'
    depends_on:
      - redis
      - database
    restart: always
    healthcheck:
      disable: false
    # labels:
      # - "traefik.enable=true"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.rule=Host(`${TRAEFIK_DOMAIN}`)"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.entrypoints=websecure"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.tls.certresolver=${TRAEFIK_CERT_RESOLVER}"
      # - "traefik.http.services.${TRAEFIK_ROUTER_NAME}.loadbalancer.server.port=2283"

  immich-machine-learning:
    container_name: immich_machine_learning
    image: ghcr.io/immich-app/immich-machine-learning:${IMMICH_VERSION:-release}-cuda
    extends:
      file: hwaccel.ml.yml
      service: cuda
    volumes:
      - model-cache:/cache 
    env_file:
      - .env
    restart: always
    healthcheck:
      disable: false

  redis:
    container_name: immich_redis
    image: docker.io/valkey/valkey:8-bookworm
    healthcheck:
      test: redis-cli ping || exit 1
    restart: always

  database:
    container_name: immich_postgres
    image: ghcr.io/immich-app/postgres:14-vectorchord0.3.0-pgvectors0.2.0
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_USER: ${DB_USERNAME}
      POSTGRES_DB: ${DB_DATABASE_NAME}
      POSTGRES_INITDB_ARGS: '--data-checksums'
      DB_STORAGE_TYPE: ${DB_STORAGE_TYPE:-SSD}
    volumes:
      - ${DB_DATA_LOCATION}:/var/lib/postgresql/data
    env_file:
      - .env
    restart: always

volumes:
  model-cache:
```

```shell
nano hwaccel.ml.yml
```

```yaml
services:
  cuda:
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities:
                - gpu
```

```shell
nano hwaccel.transcoding.yml
```

```yaml
services:
  nvenc:
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities:
                - gpu
                - compute
                - video
```

```shell
nano .env
```

```shell
# Required paths
UPLOAD_LOCATION=./library
DB_DATA_LOCATION=./postgres

# Optional timezone (not needed if localtime is mounted)
# TZ=Etc/UTC

# Version control
IMMICH_VERSION=release

# Postgres authentication
DB_PASSWORD=postgres
DB_USERNAME=postgres
DB_DATABASE_NAME=immich

# Optional tuning
DB_STORAGE_TYPE=SSD

# transcoding
TRANSCODING_BACKEND=nvenc

# traefik
TRAEFIK_ROUTER_NAME=immich
TRAEFIK_DOMAIN=immich.example.com
TRAEFIK_CERT_RESOLVER=myresolver
```

## SMB Share

make creds dir

```shell
 sudo mkdir -p /etc/smb-credentials
```

create credentials file

```shell
sudo nano /etc/smb-credentials/photos
```

add contents (update with your username and password that has access to your share)

```shell
username=photosuser
password=Ph0t0sUs3r!
```

update permissions for file

```shell
sudo chmod 600 /etc/smb-credentials/photos
sudo chown root:root /etc/smb-credentials/photos
```

check permissions

```shell
 ls -l /etc/smb-credentials/photos
```

update fstab

```shell
sudo nano /etc/fstab
```

add mount path

```shell
//192.168.10.10/photos /mnt/photos cifs credentials=/etc/smb-credentials/photos,iocharset=utf8,vers=3.0,ro,nofail 0 0
```

install additional packages for cifs

```shell
sudo apt update && sudo apt install cifs-utils
```

reboot (mandatory)

```shell
sudo reboot
```

After rebooting you should see your share mounted at `/mnt/photos`

## Starting container

start docker stack

```shell
cd /opt/stacks/immich
docker compose up -d
```

check docker containers

```shell
docker ps
```

visit server (update with your server's IP)

- <http://192.168.10.111:2283>

## More info

immich back up docs

- <https://immich.app/docs/administration/backup-and-restore/>

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Just launched: My guide to self‑hosted photo backups with Immich!<br><br>- Docker<br>- Optional GPU acceleration<br>- Mount external NAS shares<br>- Full control over your library (no more vendor lock‑in!<br><br>Check it out! <a href="https://t.co/kAZGPZWPBg">https://t.co/kAZGPZWPBg</a> <a href="https://t.co/nrSFvb6WZz">pic.twitter.com/nrSFvb6WZz</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1934278938324279667?ref_src=twsrc%5Etfw">June 15, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
