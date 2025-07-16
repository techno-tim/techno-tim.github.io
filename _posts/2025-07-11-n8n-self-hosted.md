---
layout: post
title: "Self-Host Your Own Automation Platform with n8n + Docker"
date: 2025-07-11 08:00:00 -0500
categories: self-hosted
tags: homelab n8n self-hosted workflow automation
image:
 path: /assets/img/headers/n8n-self-hosted-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APwPsvGXiPwJ+ylpPiy1bRtQ0m9+Out+CbzQ7nTLoX9xoGheEPDPirUNGbWX1WewGi+IdU8Vrd3kI8Of21p1/pFtd6N4hsIri4szrRjGnXp1KvNiacKnNUoVHGnGrCVZT9k50IU6kFGmnQhOMuf2b5pudVe0M8RNVqsalGnTwcVhqNB0cP7SdKdWlQpUp4ybxVTE1vrGIqU54mtCFaGEVavVjh8Lh8PGhQofmhqVzbT6hfzWVkNPs5r26ltLAXEt0LG2knd4LQXM4864FtEUhE8372bZ5knzsaqrVg6lR06XsqbnNwp87n7ODk+WHPJc0uSNo80tZWu9WZK6STd2kru1rvq7LRX3sj//2Q==
---

n8n is a powerful self-hosted workflow automation tool.  In this tutorial, I’ll show you how to self-host n8n on Linux using Docker. You’ll learn how to set up the environment, configure it with a .env file, and build workflows that connect to services like Google Sheets and Discord.

We’ll start with a simple manual trigger, then create a scheduled workflow, and move on to a more advanced automation that pulls in data from external services and processes it through n8n’s visual workflow editor. Whether you’re just exploring n8n or ready to start building, this guide will help you get up and running with a flexible, powerful automation platform.

{% include embed/youtube.html id='gyn8bcOLdcA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=gyn8bcOLdcA)

## Info

For this setup, I’ll be using **Docker Compose on Ubuntu Linux**—specifically the latest Ubuntu LTS and the latest version of Docker with Compose support. This makes the setup clean, consistent, and easy to repeat.

To to learn more about n8n, [check out the GitHub repo](https://github.com/n8n-io/n8n)

## Install Docker

To install docker, see [this post](/posts/docker-compose-install/)

## Setting Up

Let’s walk through the initial setup.

### Check Docker Installation

First, make sure Docker is installed and working by running:

```shell
docker -v
```

If that returns a version, you're good to go.

### Create the Project Folder

I like to keep things organized under `/opt/stacks`, but you can adjust this to fit your structure:

```shell
sudo mkdir -p /opt/stacks/n8n
sudo chown serveradmin:serveradmin -R /opt/stacks
cd /opt/stacks/n8n
```

### Create the Docker Compose File

Create the file:

```shell
nano compose.yaml
```

Paste in the following yaml:

```yaml
services:
  n8n:
    image: n8nio/n8n:latest
    restart: always
    ports:
      - "5678:5678"
    env_file:
      - .env
    volumes:
      - ./data:/home/node/.n8n
      - ./files:/files
    depends_on:
      - postgres
    # labels:
      # - "traefik.enable=true"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.rule=Host(`${TRAEFIK_DOMAIN}`)"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.entrypoints=websecure"
      # - "traefik.http.routers.${TRAEFIK_ROUTER_NAME}.tls.certresolver=${TRAEFIK_CERT_RESOLVER}"
      # - "traefik.http.services.${TRAEFIK_ROUTER_NAME}.loadbalancer.server.port=5678"

  # If you're running your own external PostgreSQL instance, you can comment out this service
  postgres:
    image: postgres:15
    restart: always
    env_file:
      - .env
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
```

This gives us a working setup using Docker Compose, with support for environment variables, volumes for persistence, and optional Traefik labels if you want to enable TLS down the line.

## Create the `.env` File

Create and edit the environment file:

```shell
nano .env
```

Paste in your values:

```shell
# n8n Settings
DOMAIN_NAME=example.com
SUBDOMAIN=n8n
GENERIC_TIMEZONE=America/New_York
N8N_HOST=n8n.example.com
N8N_PROTOCOL=https
WEBHOOK_URL=https://n8n.example.com/
N8N_SECURE_COOKIE=false
NODE_ENV=production

# Traefik (optional)
TRAEFIK_ROUTER_NAME=n8n
TRAEFIK_DOMAIN=n8n.example.com
TRAEFIK_CERT_RESOLVER=mytlschallenge

# PostgreSQL
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=changeme123
```

This file lets us easily manage settings, especially if you're running multiple stacks. If you’re using Traefik, the optional labels in `compose.yaml` will pull values from here automatically.

## Starting the Stack

Navigate to your project directory:

```shell
cd /opt/stacks/n8n
```

Then bring everything up in the background:

```shell
docker compose up -d
```

Docker will pull the required images and spin up your containers. Once that’s done, n8n should be up and running—by default on port **5678**, or at the domain you configured if you're using a reverse proxy like Traefik.

## Confirm It’s Running

To confirm everything started correctly, run:

```shell
docker ps
```

You should see both the `n8n` and `postgres` containers listed and running. If not, check the logs with:

```shell
docker compose logs
```

This can help troubleshoot any startup issues.

## Exploring n8n

With everything up and running, open your browser and go to:

```
http://localhost:5678
```

or use your domain if you’ve set up a reverse proxy. You’ll be prompted to create an admin account the first time you log in.

From here, you’re ready to start building workflows.

## More info

If you are looking to combine this stack with an AI/LLM stack, [this post](/posts/ai-stack-tutorial/)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Just published a full tutorial on self-hosting n8n with Docker on Ubuntu.<br>From setup to building workflows with Google Sheets, Ollama, and Discord - this guide walks you through everything.<a href="https://t.co/cUK7wtNFe2">https://t.co/cUK7wtNFe2</a> <a href="https://t.co/4yKMd8mJvU">pic.twitter.com/4yKMd8mJvU</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1943700350768169206?ref_src=twsrc%5Etfw">July 11, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
