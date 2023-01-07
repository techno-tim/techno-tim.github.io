---
layout: post
title: "How to Install Docker and Docker Compose"
date: 2021-08-14 11:00:00 -0500
categories: docker
tags: homelab docker docker-compose
---

## Install Docker Engine, containerd, and Docker Compose

If you have an existing version of Docker install, it might be best to remove it first.  See the [Cleaning Up](#cleaning-up)

```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

Check Installed version

```bash
docker -v
```

Check docker compose

```bash
docker compose
```

Check runtime

```bash
 sudo docker run hello-world
```

## Use Docker without sudo

```bash
sudo usermod -aG docker $USER
```

You'll need to log out then back in to apply this

## Cleaning Up

If you need to uninstall Docker, run the following

```bash
 sudo apt-get remove docker docker-engine docker.io containerd runc
```

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.
