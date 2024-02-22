---
layout: post
title: "Building your first Dockerfile, Image, and Container"
date: 2022-02-26 8:00:00 -0500
categories: docker
tags: docker docker-compose container image
image:
  path: /assets/img/headers/whale-water.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4o/DNy+o3eg2T5itpHi0544xEQwvbnAnyYd3mQzzGQAsVaLfB8hfzV/W8P7RctaNVpcihOi0nSnHZSUdHCqpK/tE7Ne7KD91x+UqcrU6bjrF3jNO0lK/pZxs9V3Saad74s2uzLNKohjwsjqOT0DEDtWTx0nryf+TL/AOQG4OLced6Nr7tO5//Z
---

We spin up all types of containers on my channel in my tutorials, but we have yet to build our own custom Docker container image.Today we'll start from scratch with an empty Dockerfile and create, build, and run our very own custom Docker image!  We'll learn all the commands that everyone should know when building and maintaining images with Docker.This tutorial is a great way to get started with Docker!

{% include embed/youtube.html id='SnSH8Ht3MIc' %}

📺 [Watch Video](https://www.youtube.com/watch?v=SnSH8Ht3MIc)

## Install Docker

To install docker, see [this post](/posts/docker-compose-install/)

## Docker commands

[Source files](https://github.com/techno-tim/launchpad/tree/master/docker/custom-image)

build image

```bash
docker build .
```

build image with tag

```bash
docker build -t hello-internet
```

list docker images

```bash
docker images
```

list docker containers

```bash
docker ps
```

list docker containers including stopped

```bash
docker ps -a
```

create container from image

```bash
docker run -d -p 80:80 <image id>
```

exec into running container

```bash
docker exec -it <container id> /bin/sh
```

stop running container

```bash
docker stop <container id>
```

start a stopped container

```bash
docker start <container id>
```

remove a container

```bash
docker rm <container id>
```

remove an image

```bash
docker rmi <image id>
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
