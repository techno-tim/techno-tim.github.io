---
layout: post
title: "Put Wildcard Certificates and SSL on EVERYTHING"
date: 2021-04-24 09:00:00 -0500
categories: traefik
tags: homelab pi-hole dns traefik portainer ssl self-hosted docker
image:
  path: /assets/img/headers/card-joker.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5LLS6lGp6WYY4Elur23tjNK19I0FvEs95cpbwQ39tZFr2KJ7WZr21vRHuguIUSe1jJ9aSbqUpKTjyuzivhkmnv53Sae+h83TmnSrU5QjLSM4y1UoyU1Fa63jrdx699Ln0Amj2jojlcF0VyNq8FgD6e9d6hBpPlWquee6kk2rR0dtkf/9k=
---

Today, we're going to use SSL for everything.No more self-sign certs.No more http.No more hosting things on odd ports.We're going all in with SSL for our internal services and our external services too.We going to set up a reverse proxy using Traefik, Portainer, and use that to get wildcard certificates from Let's Encrypt. Join me and let's secure all the things.

{% include embed/youtube.html id='liV3c9m_OX8' %}

📺 [Watch Video](https://www.youtube.com/watch?v=liV3c9m_OX8)

> *Looking for the Traefik 3.0 guide? Check out [traefik 3 on Docker](/posts/traefik-3-docker-certificates/)*
{: .prompt-info }

> *Looking to do this same thing in Kubernetes? Check out [traefik + cert-manager on Kubernetes](/posts/kube-traefik-cert-manager-le/)*
{: .prompt-info }

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Traefik

```bash
mkdir traefik
cd traefik
mkdir data
cd data
touch acme.json
chmod 600 acme.json
touch traefik.yml
```

`traefik.yml` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/traefik)

create docker network

```bash
docker network create proxy
```

```bash
touch docker-compose.yml
```

`docker-compose.yml` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/traefik)

```bash
cd data
touch config.yml
```

```bash
docker-compose up -d
```

## Portainer

```bash
mkdir portainer
cd portainer
touch docker-compose.yml
mkdir data
```

`docker-compose.yml` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/portainer)

### Generate Basic Auth Password

```bash
sudo apt update
sudo apt install apache2-utils
```

```bash
echo $(htpasswd -nb "<USER>" "<PASSWORD>") | sed -e s/\\$/\\$\\$/g
```

NOTE: Replace `<USER>` with your username and `<PASSWORD>` with your password to be hashed.

> *If you're having an issue with your password, it might not be escaped properly and you can use the following command to prompt for your password*
{: .prompt-info }

```bash
echo $(htpasswd -nB USER) | sed -e s/\\$/\\$\\$/g
```

Paste the output in your `docker-compose.yml` in line (`traefik.http.middlewares.traefik-auth.basicauth.users=<USER>:<HASHED-PASSWORD>`)

#### Spin up the container

```bash
docker-compose up -d
```

## Traefik Routes Config

```bash
cd traefik/data
nano config.yml
```

`config.yml` [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/traefik)

```bash
docker-compose up -d --force-recreate
```

Your folder structure should look like the below, if you are following along with the example.But feel free to make it however you wish just keep in mind you'll need to change the location in the corresponding files.

```bash
./traefik
├── data
│   ├── acme.json
│   ├── config.yml
│   └── traefik.yml
└── docker-compose.yml
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
