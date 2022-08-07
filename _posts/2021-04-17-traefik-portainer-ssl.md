---
layout: post
title: "Put Wildcard Certificates and SSL on EVERYTHING"
date: 2021-04-24 09:00:00 -0500
categories: traefik
tags: homelab pi-hole dns traefik portainer ssl self-hosted docker
---

[![Put Wildcard Certificates and SSL on EVERYTHING](https://img.youtube.com/vi/liV3c9m_OX8/0.jpg)](https://www.youtube.com/watch?v=liV3c9m_OX8 "Put Wildcard Certificates and SSL on EVERYTHING")

Today, we're going to use SSL for everything.  No more self-sign certs.  No more http.  No more hosting things on odd ports.  We're going all in with SSL for our internal services and our external services too.  We going to set up a reverse proxy using Traefik, Portainer, and use that to get wildcard certificates from Let's Encrypt. Join me and let's secure all the things.

[Watch Video](https://www.youtube.com/watch?v=liV3c9m_OX8)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

> *Looking to do this same thing in Kubernetes? Check out [traefik + cert-manager on Kubernetes](https://docs.technotim.live/posts/kube-traefik-cert-manager-le/)*
{: .prompt-info }

## Docker Setup

See [this post](https://docs.technotim.live/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

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

Your folder structure should look like the below, if you are following along with the example.  But feel free to make it however you wish just keep in mind you'll need to change the location in the corresponding files. 

```
./traefik
├── data
│   ├── acme.json
│   ├── config.yml
│   └── traefik.yml
└── docker-compose.yml
```
