---
layout: post
title: "How I Run Docker on TrueNAS Like a Pro"
date: 2025-07-14 08:00:00 -0500
categories: self-hosted
tags: homelab truenas self-hosted docker
image:
 path: /assets/img/headers/truenas-docker-pro-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4uvCv7Tup/Dnw1/wAIfZeBvDWpQmLVLK81a5utXtdT1C2vpblLqG8+wXUFlcRlJUjgE1pI8UVtbwM8sH2mK55cXgqOMn7SrXzWLbjJU6GfZ3hMPBwSgvZ4TCY+hhqSnGEXVVOlFV5r2lZTnqGHqyoyqclHA30hKpPLsDVr1IrmklVxFahUrVORzl7Lnm3SjKUabim0epeG/wBmDwvr3h3QNcfxL4ktn1nRdK1Z7dTYSrA2o2MF40IlNqhkERmKCQohcLuKqTgdvtH5fj/mRyLz/D/I/wD/2Q==
---

Learn how to run Docker apps on TrueNAS like a pro — with full control, clean YAML, and no extra dashboards.

Have questions or a different setup that works for you?  Leave a comment, I'd love to hear how others are running Docker on TrueNAS.

{% include embed/youtube.html id='gPL7_tzsJO8' %}
📺 [Watch Video](https://www.youtube.com/watch?v=gPL7_tzsJO8)

## The Approach

We're going to:

- Create a dataset to store our containers and configs
- Use Docker Compose and `.env` files
- Optionally manage everything from a browser using Code Server

## Example 1: Basic Stateless Container (Draw.io)

First make the dataset `drawio` in the TrueNAS UI.

Then create the `compose.yaml` file

```shell
nano compose.yaml
```

```yaml
---
services:
  drawio:
    image: jgraph/drawio
    container_name: drawio
    restart: unless-stopped
    ports:
      - 9080:8080
      - 9443:8443
    environment:
      - PUBLIC_DNS=${PUBLIC_DNS:-domain}
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8080 || exit 1"]
      interval: 5s
      timeout: 5s
      retries: 5
      start_period: 10s
```

Then add it to your `includes:` while creating a Custom App based on YAML.

## Example 2: NGINX with Volume Mounts

First make the dataset `nginx` in the TrueNAS UI.

Then create the `compose.yaml` file

```shell
nano compose.yaml
```

```yaml
---
services:
  nginx:
    image: nginx:1-alpine
    ports:
      - 8099:80
    volumes:
      - ./html/:/usr/share/nginx/html
```

Create the html folder

```shell
mkdir html
```

inside of there create an `index.html` file

```shell
cd html
nano index.html
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Hello World App</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: sans-serif;
      display: flex;
      height: 100vh;
      justify-content: center;
      align-items: center;
      background-color: #f0f0f0;
      margin: 0;
    }
    h1 {
      color: #333;
    }
  </style>
</head>
<body>
  <h1>Hello, World!</h1>
</body>
</html>
```

Then add it to your `includes:` while creating a Custom App based on YAML.

## Example 3: Code Server for Web-Based Editing

First make the dataset `code-server` in the TrueNAS UI.

Then create the `compose.yaml` file

```shell
nano compose.yaml
```

```yaml
---
services:
  code-server:
    image: lscr.io/linuxserver/code-server:latest
    container_name: code-server
    env_file:
      - .env
    environment:
      - PUID=${PUID:-950} #update with your userId or update .env
      - PGID=${PGID:-950} #update with your groupId or update .env
    volumes:
      - ./config:/config
      - /mnt/storage0/nginx/:/nginx
      - /mnt/storage0/code-server/:/code-server
      - /mnt/storage0/drawio/:/drawio

    ports:
      - 8443:8443
    restart: unless-stopped
```

Then create the `.env` file

```shell
nano .env
```

```bash
PUID=950
PGID=950
TZ=America/Chicago
```
---

Then add it to your `includes:` while creating a Custom App based on YAML.

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
