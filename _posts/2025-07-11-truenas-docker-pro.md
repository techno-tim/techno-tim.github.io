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

### drawio `docker-compose.yml`

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

### nginx `docker-compose.yml`

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

### nginx `index.html`

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

### code-server `docker-compose.yml`

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

## Bonus: Run Home Assistant with macvlan and Traefik on TrueNAS

If you’re self-hosting Home Assistant on TrueNAS, and you want:

- Native device discovery on your LAN (or VLAN!)
- Reverse proxy access through your domain
- A clean, Compose-managed setup

Then this combo of **Docker Compose + macvlan + Traefik** is exactly what you’re looking for.

> *Note: This setup is designed for users with a single NIC.*  I have it connected to a bond in my homelab, which works fine, but I just want to keep it simple for this example. Also, you can host your Home Assistant on one network or VLAN while having your TrueNAS on another (that's how I do it).
{: .prompt-info }

---

### Why macvlan?

By using `macvlan`, you give your Home Assistant container a **LAN IP**, just like a physical device. This enables:

- Proper device discovery (e.g., Google Home, Shelly, Zigbee)
- Direct network communication with other LAN devices
- Better compatibility with smart home protocols

---

### What You Need

Assumptions for this setup:

- Your NIC is `eth0`
- Your LAN subnet is `192.168.20.0/24`
- Your gateway is `192.168.20.1`
- You want Home Assistant to have IP `192.168.20.202`
- You're using **Traefik** as a reverse proxy (but optional)

---

### `docker-compose.yml`

```yaml
services:
  homeassistant:
    container_name: homeassistant
    image: ghcr.io/home-assistant/home-assistant:stable
    pull_policy: always
    restart: unless-stopped
    env_file:
      - .env
    security_opt:
      - no-new-privileges:true
    networks:
      iot_macvlan:
        ipv4_address: 192.168.20.202
      traefik:
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      - /mnt/storage0/home-assistant/config:/config
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.homeassistant.rule=Host(`homeassistant.yourdomain.com`)"
      - "traefik.http.routers.homeassistant.entrypoints=https"
      - "traefik.http.routers.homeassistant.tls=true"
      - "traefik.http.routers.homeassistant.tls.certresolver=cloudflare"
      - "traefik.http.services.homeassistant.loadbalancer.server.port=8123"

networks:
  iot_macvlan:
    external: true
  traefik:
    external: true
```

> *Note: The `iot_macvlan` and `traefik` networks must already exist as external Docker networks. You can create the `macvlan` network using the command below.*
{: .prompt-info }

---

### Create the macvlan Network

You only need to create the macvlan network once:

```bash
docker network create -d macvlan \
  --subnet=192.168.20.0/24 \
  --gateway=192.168.20.1 \
  -o parent=eth0 \
  iot_macvlan
```

> *Warning: macvlan works best with physical interfaces like `eth0`. It can work with bonded or VLAN interfaces too, but compatibility depends on your network setup and driver support. (I am using a bond without ay issues but worth mentioning in case you run into issues)*
{: .prompt-warning }

> *Danger: If you assign the same IP to more than one container or device, it will cause an IP conflict and could take your Home Assistant or host offline.*
{: .prompt-danger }

---

### macvlan + Traefik

| Setting               | Value                             | Description                                             |
|----------------------|-----------------------------------|---------------------------------------------------------|
| **Interface**         | `eth0`                            | Your physical NIC  or bond that has access to tagged packets      |
| **Subnet**            | `192.168.20.0/24`                 | Matches your LAN range                                  |
| **Gateway**           | `192.168.20.1`                    | Gateway IP                              |
| **Home Assistant IP** | `192.168.20.202`                  | LAN IP assigned to the container                        |
| **Domain**            | `homeassistant.yourdomain.com`   | Used in your Traefik rule                               |
| **Networks**          | `iot_macvlan`, `traefik`          | Must exist as external networks, created with the docker command                        |

---

### Results

With this setup:

- Home Assistant has a dedicated IP on your LAN
- You can access it securely via Traefik + HTTPS
- Everything is defined in Compose.

## Bonus: Fix Custom Icons for TrueNAS Custom Apps

By default, when you deploy a custom app on TrueNAS using your own Docker Compose, the app will likely show up with a missing or blank icon in the Apps UI.

Fortunately, you can fix that by editing the app’s metadata file.

---

### Update the App Metadata

Edit the following file on your TrueNAS system:

```bash
/mnt/.ix-apps/app_configs/YOUR_APP_NAME/metadata.yaml
```

Add the `icon:` property inside the `metadata:` block. For example:

```yaml
custom_app: true
human_version: 1.0.0_custom
metadata:
  app_version: custom
  capabilities: []
  description: This is a custom app where user can use his/her own docker compose
    file for deploying services
  home: ''
  host_mounts: []
  maintainers: []
  name: custom-app
  run_as_context: []
  sources: []
  title: Custom App
  train: stable
  version: 1.0.0
  icon: https://media.sys.truenas.net/apps/homepage/icons/icon.png
migrated: false
notes: null
portals: {}
version: 1.0.0
```

> *Note: You will need to redeploy the app and refresh the UI for the icon to show up.*
{: .prompt-info }

---

### Mount App Configs in Code Server

If you’re using Code Server like I am, you can easily edit app configs like this by mounting the app config directory into your container:

```yaml
volumes:
  - /mnt/.ix-apps/app_configs/:/ix-apps
```

This makes `/ix-apps` accessible from inside Code Server, so you can quickly edit metadata, YAML, or other settings.

---

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">&quot;Keep your data close… but your apps closer.&quot;<br>My new setup runs Docker apps on TrueNAS the clean way — using Compose, .env, and no hacks.<a href="https://t.co/RQ90braua3">https://t.co/RQ90braua3</a> <a href="https://t.co/NNvDO0zn0O">pic.twitter.com/NNvDO0zn0O</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1945145367072309294?ref_src=twsrc%5Etfw">July 15, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
