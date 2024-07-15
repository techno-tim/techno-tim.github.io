---
layout: post
title: "How to Self-Host Your Own Private AI Stack"
date: 2024-07-08 08:00:00 -0500
categories: homelab self-hosted
tags: ai docker software llm ollama whisper
image:
 path: /assets/img/headers/ai-stack-tutorial.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5oPBP7UPhPwl8J9G01/wBln4Ca3NYadpnhJ72/m+L0L6zfaFpwkk8X66tn8UoXm8Q+Ibi4juPEa6LPoOkzbJ7TRNN0HTruWyH1H+1VsdhaKxUqWGw2HpznSo0oUpYqNStWdOji503CnjMPRqpTjRx9DFxcb0/di1bwKWb4TDYOvg6uVUMXipKpicNjMR9VrRwVT91F1cNRxOBxFfD4mpySVXEYLG4Oc6cuS0bOUvzt1+4sdX13WtWttE0vw/bapq2pajb6DojaodG0SC9vJrmLSNJOtanrOsHTNNjlWysDq2r6rqZtYYjf6lfXXm3UvNKEVKS3s3rtfXeysl6JJdkVGtNxTTSuk7JKy02V1eyP/9k=
---

In this tutorial we'll walk through my local, private, self-hosted AI stack so that you can run it too.

{% include embed/youtube.html id='yoze1IxdBdM' %}
📺 [Watch Video](https://www.youtube.com/watch?v=yoze1IxdBdM)

## Disclosures

- Nothing in this video was sponsored

## Info

 If you're looking for the overview of this stack, you can out the video here [Self-Hosted AI That's Actually Useful](/posts/private-practical-local-ai/)

## Hardware

- Machine Used for AI: [Building My ULTIMATE, All-inOne, HomeLab Server](https://www.youtube.com/watch?v=1lXSdg-8evA)

## GPUs

Here are some cards that are good for local AI.  Keep in mind that it's always better to get a newer one for better CUDA support and more RAM.  8GB of RAM should be good for small models like the ones in this stack, however 12-24 is probably best.

### NVIDIA RTX 3000 Series

- [MSI Gaming GeForce RTX 3060 12GB](https://amzn.to/3WerOUI)
- [GIGABYTE GeForce RTX 3060 Gaming OC 12G](https://amzn.to/3WdqHV9)
- [NVIDIA GeForce RTX 3090 Founders Edition Graphics Card (Renewed) 24GB](https://amzn.to/4cTIS7Q)
- [Zotac Gaming GeForce RTX 3090 Trinity OC, 24GB](https://amzn.to/3WdhJqV)

### NVIDIA RTX 4000 Series

- [ASUS TUF Gaming GeForce RTX™ 4090 OG OC Edition Gaming Graphics Card 24GB](https://amzn.to/463LHRF)
- [MSI Gaming GeForce RTX 4060 8GB](https://amzn.to/4eVxrON)
- [ASUS Dual GeForce RTX™ 4070 White OC Edition 12GB](https://amzn.to/460rqN0)

## CPU

You'll want a modern CPU, if you are going desktop class here are a few I would choose

- [Intel Core i7-12700K Gaming Desktop Processor](https://amzn.to/3XTj1Zu)
- [Intel Core i7-13700K Gaming Desktop Processor](https://amzn.to/3Lg7M5V)
- [Intel Core i7-14700K Gaming Desktop Processor](https://amzn.to/3WftehU)

## Storage

For flash storage, I always go with these SSDs

- [Samsung 870 EVO SATA](https://amzn.to/3XTW6gA)
- [SAMSUNG 990 PRO SSD NVMe](https://amzn.to/4cW1xA9)

## Operating System

I am running [Ubuntu Server 24.04 LTS](https://ubuntu.com/server)

## Drivers

Installing NVIDIA Drivers

If you need help, [you can check out this article](https://ubuntu.com/server/docs/nvidia-drivers-installation) but here are the commands I ran.

Install the best desktop graphics card for your machine.

```bash
sudo ubuntu-drivers install
```

Install NVIDIA tools

Be sure you install the version that matches your driver from above

```bash
sudo apt install nvidia-utils-535
```

Then reboot your machine

```bash
sudo reboot
```

Once the machine is back up, check to be sure your drivers are functioning properly

```bash
nvidia-smi 
```

## Software Overview

Here are the packages and repo's we're be using

- [Ollama](https://ollama.com/)
- [Open WebUI](https://github.com/open-webui/open-webui)
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [Stable Diffusion web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [pluja/whishper](https://github.com/pluja/whishper)
- [HuggingFace](https://huggingface.co/)
- [Home Assistant Wyoming Protocol](https://www.home-assistant.io/integrations/wyoming/)
- [Continue Code Assistant](https://github.com/continuedev/continue)
- [searXNG](https://github.com/searxng/searxng)
- [MacWhisper](https://goodsnooze.gumroad.com/l/macwhisper)

## Traefik

### Using

I am using Traefik as the only entry point into this stack.  No ports are exposed on the host.  If you don't want to use traefik, just comment out the labels (and optionally rename the network named `traefik`).  You will then need to expose ports for `open-webui`, `stable-diffusion-webui`, and `whisper` in your Docker compose file.

If you need help installing Traefik, see this post on [installing traefik 3 on Docker](/posts/traefik-3-docker-certificates/)

### DNS

> *Note: If using `traefik` (or any reverse proxy, remember that all of your internal DNS records will point to this machine!  e.g. If the machine running this stack's ip is `192.168.0.100` you'll need a DNS record like `chat.local.example.com` that points to `192.168.0.100`*
{: .prompt-info }

### Auth Middleware

This stack contains middleware for basic auth so that the Ollama so that it is secure with a username and password.  This is optional.  If you don't want to use basic auth, just remove the auth middleware labels from the `ollama` service in your compose.

Otherwise, here's how you create the credential:

Hashing your password for `traefik` middleware

```bash
echo $(htpasswd -nB ollamauser) | sed -e s/\\$/\\$\\$/g
```

You'll then want to place this in your `.env` [here](#variables-with-env) using the `OLLAMA_API_CREDENTIALS` variable.  This is then used in the `ollama` service in your compose file.

### Basic Auth Hash

If you want to create a hash value for Basic Auth (Used for Continue extension).  You'll need to use the credential from above.

```bash
echo 'ollamauser:ollamapassword!' | base64
```

## NVIDIA Container Toolkit

If you run into issues, you can always visit the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

Configure the production repository

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

Update the packages list from the repository:

```bash
sudo apt-get update
```

Install the NVIDIA Container Toolkit packages

```bash
sudo apt-get install -y nvidia-container-toolkit
```

Configure the container runtime by using the `nvidia-ctk` command and restart docker

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

This will fail if you don't have Docker installed yet.

## Docker

If you need to install Docker see [this post](/posts/docker-compose-install/) on how to install `docker` and `docker compose`

After installing Docker you will need to reconfigure the runtime

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

## Testing

This will test to make sure that the NVIDIA container toolkit can access the NVidia driver.

```bash
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

You should see the same output as running `nvidia-smi` without Docker.

## Folder Structure

Stacks live in `/opt/stacks`

Here is the folder structure. Most subfolders are created when binding volumes.

```bash
├── ai-stack
│   ├── .env
│   ├── compose.yaml
│   ├── ollama
│   ├── open-webui
│   ├── searxng
│   ├── stable-diffusion-webui-docker
│   └── whisper
├── home-assistant-stack
│   ├── compose.yaml
│   ├── faster-whisper
│   ├── home-assistant
│   └── wyoming-piper
```

## Folder Permissions

If you run into any folder permission errors while running any of this, you can simple change the owner to yourself using the command.  Please replace the user and group with your own user and group.

```bash
sudo chown serveradmin:serveradmin -R /opt/stacks
```

## Variables with .env

My `ai-stack` `.env`is pretty minimal

```bash
OLLAMA_API_CREDENTIALS=
DB_USER=
DB_PASS=
WHISHPER_HOST=https://whisper.local.example.com
WHISPER_MODELS=tiny,small
PUID=
PGID=
```

## AI Stack (Docker Compose)

Here is my `compose.yaml`

You'll want to create this in the root of your stack folder (see folder structure above)

The command I use to start, build, and remove orphans is:

```bash
docker compose up -d --build --force-recreate --remove-orphans
```

otherwise you can use

```bash
docker compose up -d --build
```

There are additional steps you'll need to do before starting this stack.  Please continue on to the end.

Here are 2 Docker compose files that you can use on your system.

### My Docker Compose Stack

The stack is the one I use in the video as well as at home.  If you want to use the general stack without traefik and macvlan, see [the general Docker compose stack](#general-docker-compose-stack)

Before running this, you will need to create the network for Docker to use.

This might already exist if you are using traefik.  If so skip this step.

```bash
docker network create traefik
```

This will create the `macvlan` network.  Adjust accordingly.

```bash
docker network create -d macvlan \
--subnet=192.168.20.0/24 \
--gateway=192.168.20.1 \
-o parent=eth1 \
iot_macvlan
```

`compose.yaml`

```yaml
services:

# Ollama

  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - OLLAMA_KEEP_ALIVE=24h
      - ENABLE_IMAGE_GENERATION=True
      - COMFYUI_BASE_URL=http://stable-diffusion-webui:7860
    networks:
      - traefik
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./ollama:/root/.ollama
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.ollama.rule=Host(`ollama.local.example.com`)"
      - "traefik.http.routers.ollama.entrypoints=https"
      - "traefik.http.routers.ollama.tls=true"
      - "traefik.http.routers.ollama.tls.certresolver=cloudflare"
      - "traefik.http.routers.ollama.middlewares=default-headers@file"
      - "traefik.http.routers.ollama.middlewares=ollama-auth"
      - "traefik.http.services.ollama.loadbalancer.server.port=11434"
      - "traefik.http.routers.ollama.middlewares=auth"
      - "traefik.http.middlewares.auth.basicauth.users=${OLLAMA_API_CREDENTIALS}"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

# open web ui
  open-webui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: open-webui
    restart: unless-stopped
    networks:
      - traefik
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - 'OLLAMA_BASE_URL=http://ollama:11434'
      - ENABLE_RAG_WEB_SEARCH=True
      - RAG_WEB_SEARCH_ENGINE=searxng
      - RAG_WEB_SEARCH_RESULT_COUNT=3
      - RAG_WEB_SEARCH_CONCURRENT_REQUESTS=10
      - SEARXNG_QUERY_URL=http://searxng:8080/search?q=<query>
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./open-webui:/app/backend/data
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.open-webui.rule=Host(`chat.local.example.com`)"
      - "traefik.http.routers.open-webui.entrypoints=https"
      - "traefik.http.routers.open-webui.tls=true"
      - "traefik.http.routers.open-webui.tls.certresolver=cloudflare"
      - "traefik.http.routers.open-webui.middlewares=default-headers@file"
      - "traefik.http.services.open-webui.loadbalancer.server.port=8080"
    depends_on:
      - ollama
    extra_hosts:
      - host.docker.internal:host-gateway

  searxng:
    image: searxng/searxng:latest
    container_name: searxng
    networks:
      - traefik
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./searxng:/etc/searxng
    depends_on:
      - ollama
      - open-webui
    restart: unless-stopped

# stable diffusion

  stable-diffusion-download:
    build: ./stable-diffusion-webui-docker/services/download/
    image: comfy-download
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./stable-diffusion-webui-docker/data:/data

  stable-diffusion-webui:
    build: ./stable-diffusion-webui-docker/services/comfy/
    image: comfy-ui
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - CLI_ARGS=
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./stable-diffusion-webui-docker/data:/data
      - ./stable-diffusion-webui-docker/output:/output

    stop_signal: SIGKILL
    tty: true
    deploy:
      resources:
        reservations:
          devices:
              - driver: nvidia
                device_ids: ['0']
                capabilities: [compute, utility]
    restart: unless-stopped
    networks:
      - traefik
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.stable-diffusion.rule=Host(`stable-diffusion.local.example.com`)"
      - "traefik.http.routers.stable-diffusion.entrypoints=https"
      - "traefik.http.routers.stable-diffusion.tls=true"
      - "traefik.http.routers.stable-diffusion.tls.certresolver=cloudflare"
      - "traefik.http.services.stable-diffusion.loadbalancer.server.port=7860"
      - "traefik.http.routers.stable-diffusion.middlewares=default-headers@file"

# whisper
  mongo:
    image: mongo
    env_file:
      - .env
    networks:
      - traefik
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/db_data:/data/db
      - ./whisper/db_data/logs/:/var/log/mongodb/
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - MONGO_INITDB_ROOT_USERNAME=${DB_USER:-whishper}
      - MONGO_INITDB_ROOT_PASSWORD=${DB_PASS:-whishper}
    command: ['--logpath', '/var/log/mongodb/mongod.log']

  translate:
    container_name: whisper-libretranslate
    image: libretranslate/libretranslate:latest-cuda
    env_file:
      - .env
    networks:
      - traefik
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/libretranslate/data:/home/libretranslate/.local/share
      - ./whisper/libretranslate/cache:/home/libretranslate/.local/cache
    user: root
    tty: true
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - LT_DISABLE_WEB_UI=True
      - LT_LOAD_ONLY=${LT_LOAD_ONLY:-en,fr,es}
      - LT_UPDATE_MODELS=True
    deploy:
      resources:
        reservations:
          devices:
          - driver: nvidia
            count: all
            capabilities: [gpu]

  whisper:
    container_name: whisper
    pull_policy: always
    image: pluja/whishper:latest-gpu
    env_file:
      - .env
    networks:
      - traefik
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/uploads:/app/uploads
      - ./whisper/logs:/var/log/whishper
      - ./whisper/models:/app/models
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whisper.rule=Host(`whisper.local.example.com`)"
      - "traefik.http.routers.whisper.entrypoints=https"
      - "traefik.http.routers.whisper.tls=true"
      - "traefik.http.routers.whisper.tls.certresolver=cloudflare"
      - "traefik.http.services.whisper.loadbalancer.server.port=80"
      - "traefik.http.routers.whisper.middlewares=default-headers@file"
    depends_on:
      - mongo
      - translate
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - PUBLIC_INTERNAL_API_HOST=${WHISHPER_HOST}
      - PUBLIC_TRANSLATION_API_HOST=${WHISHPER_HOST}
      - PUBLIC_API_HOST=${WHISHPER_HOST:-}
      - PUBLIC_WHISHPER_PROFILE=gpu
      - WHISPER_MODELS_DIR=/app/models
      - UPLOAD_DIR=/app/uploads
    deploy:
      resources:
        reservations:
          devices:
          - driver: nvidia
            count: all
            capabilities: [gpu]
networks:
  traefik:
    external: true
```

### General Docker Compose Stack

This Docker compose stack does not use traefik and also exposes the port on the host for each service.  If you don't want to expose the port, comment that section out.  If you want to use the stack with traefik and macvlan, see the [stack I used in the video](#ai-stack-docker-compose)

Before running this, you will need to create the network for Docker to use.

```bash
docker network create ai-stack
```

```yaml
services:

  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: unless-stopped
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - OLLAMA_KEEP_ALIVE=24h
      - ENABLE_IMAGE_GENERATION=True
      - COMFYUI_BASE_URL=http://stable-diffusion-webui:7860
    networks:
      - ai-stack
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./ollama:/root/.ollama
    ports:
      - "11434:11434" # Add this line to expose the port
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

  open-webui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: open-webui
    restart: unless-stopped
    networks:
      - ai-stack
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - 'OLLAMA_BASE_URL=http://ollama:11434'
      - ENABLE_RAG_WEB_SEARCH=True
      - RAG_WEB_SEARCH_ENGINE=searxng
      - RAG_WEB_SEARCH_RESULT_COUNT=3
      - RAG_WEB_SEARCH_CONCURRENT_REQUESTS=10
      - SEARXNG_QUERY_URL=http://searxng:8080/search?q=<query>
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./open-webui:/app/backend/data
    depends_on:
      - ollama
    extra_hosts:
      - host.docker.internal:host-gateway
    ports:
      - "8080:8080" # Add this line to expose the port

  searxng:
    image: searxng/searxng:latest
    container_name: searxng
    networks:
      - ai-stack
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./searxng:/etc/searxng
    depends_on:
      - ollama
      - open-webui
    restart: unless-stopped
    ports:
      - "8081:8080" # Add this line to expose the port

  stable-diffusion-download:
    build: ./stable-diffusion-webui-docker/services/download/
    image: comfy-download
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./stable-diffusion-webui-docker/data:/data

  stable-diffusion-webui:
    build: ./stable-diffusion-webui-docker/services/comfy/
    image: comfy-ui
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - CLI_ARGS=
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./stable-diffusion-webui-docker/data:/data
      - ./stable-diffusion-webui-docker/output:/output
    stop_signal: SIGKILL
    tty: true
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ['0']
              capabilities: [compute, utility]
    restart: unless-stopped
    networks:
      - ai-stack
    ports:
      - "7860:7860" # Add this line to expose the port

  mongo:
    image: mongo
    env_file:
      - .env
    networks:
      - ai-stack
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/db_data:/data/db
      - ./whisper/db_data/logs/:/var/log/mongodb/
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - MONGO_INITDB_ROOT_USERNAME=${DB_USER:-whishper}
      - MONGO_INITDB_ROOT_PASSWORD=${DB_PASS:-whishper}
    command: ['--logpath', '/var/log/mongodb/mongod.log']
    ports:
      - "27017:27017" # Add this line to expose the port

  translate:
    container_name: whisper-libretranslate
    image: libretranslate/libretranslate:latest-cuda
    env_file:
      - .env
    networks:
      - ai-stack
    restart: unless-stopped
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/libretranslate/data:/home/libretranslate/.local/share
      - ./whisper/libretranslate/cache:/home/libretranslate/.local/cache
    user: root
    tty: true
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - LT_DISABLE_WEB_UI=True
      - LT_LOAD_ONLY=${LT_LOAD_ONLY:-en,fr,es}
      - LT_UPDATE_MODELS=True
    deploy:
      resources:
        reservations:
          devices:
          - driver: nvidia
            count: all
            capabilities: [gpu]
    ports:
      - "5000:5000" # Add this line to expose the port

  whisper:
    container_name: whisper
    pull_policy: always
    image: pluja/whishper:latest-gpu
    env_file:
      - .env
    networks:
      - ai-stack
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./whisper/uploads:/app/uploads
      - ./whisper/logs:/var/log/whishper
      - ./whisper/models:/app/models
    restart: unless-stopped
    depends_on:
      - mongo
      - translate
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - PUBLIC_INTERNAL_API_HOST=${WHISHPER_HOST}
      - PUBLIC_TRANSLATION_API_HOST=${WHISHPER_HOST}
      - PUBLIC_API_HOST=${WHISHPER_HOST:-}
      - PUBLIC_WHISHPER_PROFILE=gpu
      - WHISPER_MODELS_DIR=/app/models
      - UPLOAD_DIR=/app/uploads
    deploy:
      resources:
        reservations:
          devices:
          - driver: nvidia
            count: all
            capabilities: [gpu]
    ports:
      - "8000:80" # Add this line to expose the port

networks:
  ai-stack:
    external: true
```

## Changes for ComfyUI

Before starting the stack, in the room `ai-stack` folder, you'll want to clone the repo (or just copy the necessary files).

(this will create the folder for you)

```bash
git clone https://github.com/AbdBarho/stable-diffusion-webui-docker.git
```

After cloning, you'll want to make a change to the Docker file

```bash
nano stable-diffusion-webui-docker/services/comfy/Dockerfile
```

I commented out the pinning to commit hash and just grabbed the latest comfy.

```Dockerfile
FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1

RUN apt-get update && apt-get install -y git && apt-get clean

ENV ROOT=/stable-diffusion
RUN --mount=type=cache,target=/root/.cache/pip \
  git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
  cd ${ROOT} && \
  git checkout master && \
#  git reset --hard 276f8fce9f5a80b500947fb5745a4dde9e84622d && \
  pip install -r requirements.txt

WORKDIR ${ROOT}
COPY . /docker/
RUN chmod u+x /docker/entrypoint.sh && cp /docker/extra_model_paths.yaml ${ROOT}

ENV NVIDIA_VISIBLE_DEVICES=all PYTHONPATH="${PYTHONPATH}:${PWD}" CLI_ARGS=""
EXPOSE 7860
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD python -u main.py --listen --port 7860 ${CLI_ARGS}
```

If you cloned the repo and want to verify your changes, you can do so with:

```bash
git diff
```

You should see something like

```diff
diff --git a/services/comfy/Dockerfile b/services/comfy/Dockerfile
index 2de504d..a84c8ce 100644
--- a/services/comfy/Dockerfile
+++ b/services/comfy/Dockerfile
@@ -9,7 +9,7 @@ RUN --mount=type=cache,target=/root/.cache/pip \
   git clone https://github.com/comfyanonymous/ComfyUI.git ${ROOT} && \
   cd ${ROOT} && \
   git checkout master && \
-  git reset --hard 276f8fce9f5a80b500947fb5745a4dde9e84622d && \
+#  git reset --hard 276f8fce9f5a80b500947fb5745a4dde9e84622d && \
   pip install -r requirements.txt

 WORKDIR ${ROOT}
(END)
```

## Downloading Models

You'll want to grab any models you like from [HuggingFace](https://huggingface.co).  I am using [stabilityai/stable-diffusion-3-medium](https://huggingface.co/stabilityai/stable-diffusion-3-medium)

You'll want to download all of the models and then transfer them to your server
and put them in the appropriate folders

Models will need to bt placed in the `Stable-diffusion` folder.  

```bash
stable-diffusion-webui-docker/data/models/Stable-diffusion
```

Models are any file in the root of `stable-diffusion-3-medium` that have the extension `*.safetensors`

For clips, you'll need to create this folder (because it doesn't exist)

```bash
mkdir stable-diffusion-webui-docker/data/models/CLIPEncoder
```

In there you'll place your clips, from the `text_encoders` folder from `stable-diffusion-3-medium`

## Example Workflows for ComfyUI and Stable Diffusion 3 Medium

You'll need to download the same workflows to the machine that accesses ComfyUI so you can import them into the browser.

Example workflows are also available on HuggingFace in the [Stable Diffusion 3 Medium repo](https://huggingface.co/stabilityai/stable-diffusion-3-medium/tree/main/comfy_example_workflows)

## Verifying Models

If you're going to spend all of that time downloading these model files, you should also pend a few minutes verifying them.  I typically do this once they are on the server running the AI Stack

```bash
shasum -a 256 ./sd3_medium.safetensors
```

This should output something like:

```bash
cc236278d28c8c3eccb8e21ee0a67ebed7dd6e9ce40aa9de914fa34e8282f191  ./sd3_medium.safetensors
```

You'll want to be sure the checksum matches the checksum from the source ([HuggingFace](https://huggingface.co/stabilityai/stable-diffusion-3-medium/blob/main/sd3_medium.safetensors), etc).

## Home Assistant Stack (Docker Compose)

Please see [folder structure](#folder-structure) above

Before running this, you will need to create the network for Docker to use.

This might already exist if you are using traefik.  If so skip this step.

```bash
docker network create traefik
```

This will create the `macvlan` network.  Adjust accordingly.

```bash
docker network create -d macvlan \
--subnet=192.168.20.0/24 \
--gateway=192.168.20.1 \
-o parent=eth1 \
iot_macvlan
```

```yaml
---
services:
  homeassistant:
    container_name: homeassistant
    networks:
      iot_macvlan:
        ipv4_address: 192.168.20.202 #optional, I am using mac vlan, if you don't want to, remove iot_macvlan and don't create the network above
      traefik:
    image: ghcr.io/home-assistant/home-assistant:stable
    depends_on:
      - faster-whisper-gpu
      - wyoming-piper
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./home-assistant/config:/config
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.homeassistant.rule=Host(`homeassistant.local.example.com`)"
      - "traefik.http.routers.homeassistant.entrypoints=https"
      - "traefik.http.routers.homeassistant.tls=true"
      - "traefik.http.routers.homeassistant.tls.certresolver=cloudflare"
      - "traefik.http.routers.homeassistant.middlewares=default-headers@file"
      - "traefik.http.services.homeassistant.loadbalancer.server.port=8123"

  faster-whisper-gpu:
    image: lscr.io/linuxserver/faster-whisper:gpu
    container_name: faster-whisper-gpu
    networks:
      - traefik
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
      - WHISPER_MODEL=tiny-int8
      - WHISPER_BEAM=1 #optional
      - WHISPER_LANG=en #optional
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./faster-whisper/data:/config
    restart: unless-stopped
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
  wyoming-piper:
    container_name: wyoming-piper
    networks:
      - traefik
    image: rhasspy/wyoming-piper # no gpu
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - ./wyoming-piper/data:/data
    environment:
      - PUID=${PUID:-1000}
      - PGID=${PGID:-1000}
    restart: unless-stopped
    command: --voice en_US-lessac-medium
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

networks:
  traefik:
    external: true
  iot_macvlan:
    external: true
```

## Code Completion (VSCode)

I am using Basic Auth Middleware with traefik.  Please see [traefik section](#traefik) for details on how to set this up.

### Extension

I am using [Continue](https://www.continue.dev/) for code completion and integrated chat.

Example config.

If you aren't going to use auth, remove the `requestOptions` key.

If you are going to use auth, please replace the `xxx` with the value from [above](#basic-auth-hash)

```json
{
  "models": [
    { 
      "title": "Ollama (Self-Hosted)",
      "provider": "ollama",
      "model": "AUTODETECT",
      "completionOptions": {},
      "apiBase": "https://ollama.local.example.com",
      "requestOptions": {
        "headers": {
          "Authorization": "Basic xxx"
        }
      }
    }
  ], 
  "tabAutocompleteModel": {
    "title": "Starcoder 3b",
    "provider": "ollama",
    "model": "starcoder2:3b",
    "apiBase": "https://ollama.local.example.com",
    "requestOptions": {
      "headers": {
        "Authorization": "Basic xxx"
      }
    }
  }
}
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">You know that video on self-hosted AI that I just released? <br><br>Well I just followed up with one of the most in-depth tutorials I have ever released.<br><br>FULL TUTORIAL HERE👇<a href="https://t.co/5JAo9Phd1Y">https://t.co/5JAo9Phd1Y</a> <a href="https://t.co/zdqgd0IgS8">pic.twitter.com/zdqgd0IgS8</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1810415330550063300?ref_src=twsrc%5Etfw">July 8, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
