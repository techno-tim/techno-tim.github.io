---
layout: post
title: "How to Install Docker and Docker Compose"
date: 2021-08-14 11:00:00 -0500
categories: docker
tags: homelab docker-docker-compose
---

## Install Docker

If you have an existing version of Docker install, it might be best to remove it first.  See the cleaning up section at the end

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
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Check Install

```bash
docker -v
```

## Install Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

Check Install

```bash
docker-compose -v
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