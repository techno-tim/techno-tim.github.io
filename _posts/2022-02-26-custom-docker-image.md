---
layout: post
title: "Building your first Dockerfile, Image, and Container"
date: 2022-02-26 8:00:00 -0500
categories: docker
tags: docker docker-compose container image
---

[![Build YOUR OWN Dockerfile, Image, and Container](https://img.youtube.com/vi/SnSH8Ht3MIc/0.jpg)](https://www.youtube.com/watch?v=SnSH8Ht3MIc "Build YOUR OWN Dockerfile, Image, and Container")

We spin up all types of containers on my channel in my tutorials, but we have yet to build our own custom Docker container image.  Today we'll start from scratch with an empty Dockerfile and create, build, and run our very own custom Docker image!  We'll learn all the commands that everyone should know when building and maintaining images with Docker.  This tutorial is a great way to get started with Docker!

[Watch Video](https://www.youtube.com/watch?v=SnSH8Ht3MIc)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

## Install Docker

To install docker, see [https://docs.technotim.live/posts/docker-compose-install/](https://docs.technotim.live/posts/docker-compose-install/)

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



