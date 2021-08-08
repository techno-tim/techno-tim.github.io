---
layout: post
title: "2 Factor Auth and Single Sign on with Authelia"
date: 2021-06-05 09:00:00 -0500
categories: traefik
tags: authelia homelab traefik portainer ssl docker self-hosted
---

[![2 Factor Auth and Single Sign on with Authelia?](https://img.youtube.com/vi/u6H-Qwf4nZA/0.jpg)](https://www.youtube.com/watch?v=u6H-Qwf4nZA "2 Factor Auth and Single Sign on with Authelia?")

Authelia is an open source Single Sign On and 2FA companion for reverse proxies.  It helps you secure your endpoints with single factor and 2 factor auth.  It works with Nginx, Traefik, and HA proxy.  Today, we'll configure Authelia with Portainer and Traefik and have 2 Factor up and running with brute force protection! 

[Watch Video](https://www.youtube.com/watch?v=u6H-Qwf4nZA)

## Traefik

Authelia will work with other reverse proxies but I used Traefik.  If you want to configure Traefik as your reverse proxy see this [guide](https://techno-tim.github.io/posts/traefik-portainer-ssl/).


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

## Authelia

`configuration.yml`,  `users_database.yml`, and `docker-compose.yml` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/authelia-traefik/authelia) 
 
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
