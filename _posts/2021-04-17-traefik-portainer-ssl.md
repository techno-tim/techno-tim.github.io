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


## Docker Setup

### Install Docker

```bash
 sudo apt-get update
 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

```bash
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

```bash
 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io
```

```bash
 sudo usermod -aG docker $USER
```
You'll need to log out then back in to apply this

### Install Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

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

`traefik.config` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/traefik) 

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
echo $(htpasswd -nb USER PASSWORD) | sed -e s/\\$/\\$\\$/g
```

use this in your `docker-compose.yml` (`USER:BASIC_AUTH_PASSWORD`)

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
