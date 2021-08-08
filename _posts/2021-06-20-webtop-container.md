---
layout: post
title: "Linux desktop, inside of a container, inside of a browser???  Yes. A Webtop."
date: 2021-06-20 09:00:00 -0500
categories: self-hosted
tags: homelab traefik portainer docker self-hosted ubuntu webtop
---

[![Linux desktop, inside of a container, inside of a browser???  Yes. A Webtop.?](https://img.youtube.com/vi/Gd9bvdkIXOQ/0.jpg)](https://www.youtube.com/watch?v=Gd9bvdkIXOQ "Linux desktop, inside of a container, inside of a browser???  Yes. A Webtop.?")

Have you ever thought about running a Linux desktop inside of a container?  Me neither until I found this awesome project from LinuxServer called Webtops.  A webtop is a technology stack that allows you to run Ubuntu or Alpine Linux within a container that is fully accessible from a browser.  This allows you to use most Linux features with a container with a fraction of the cost of resources.  Join me as we configure one from beginning to end. 

[Watch Video](https://www.youtube.com/watch?v=Gd9bvdkIXOQ)

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

## Webtop

`docker-compose.yml` and `.env` can be found [here](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/webtop-container/) 
 

## Files and folders

```bash 
mkdir webtop
cd webtop
mkdir config
cd ..
nano docker-compose.yml
```

### Create Webtop container

```bash
docker-compose up -d
```
