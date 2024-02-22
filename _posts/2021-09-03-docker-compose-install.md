---
layout: post
title: "How to Install Docker and Docker Compose Ubuntu"
date: 2021-08-14 11:00:00 -0500
categories: docker
tags: homelab docker docker-compose
image:
  path: /assets/img/headers/docker-gold.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP48Pg5420Dw38GviHoVz8J/hl4u8Q+MLXVF074ieMdM17WfFngKGx01xOvgyyTxFaeCftN7bx3ES33ivwj4qutHuLttV8PSaRq9vaX0HzGZfXKmd4KUMxxeHw1FUYzwNF0Y4fEuVSTcq83SeJV3KF1RxFHmjRhCTdOdeNX1sJCj9RqqVCnKpJz5a0ubnpqMU0orm5HtK3NGTTm5atQ5flf7S/oK+vPH5Y9vxZ//2Q==
---

This guide will walk you through how to Install Docker Engine, containerd, and Docker Compose on Ubuntu.

If you have an existing version of Docker install, it is best to remove it first.See the [Cleaning Up](#cleaning-up)

If you're installing this on Debian, see [Docker's Debian Install Guide](https://docs.docker.com/engine/install/debian/)

## Install

Set up Docker's `apt` repository.

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

> *If you use an Ubuntu derivative distro, such as Linux Mint, you may need to use `UBUNTU_CODENAME` instead of `VERSION_CODENAME`.*
{: .prompt-info }

Install the latest version

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
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
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
