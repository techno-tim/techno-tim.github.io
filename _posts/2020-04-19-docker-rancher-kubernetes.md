---
layout: post
title: "Docker, Rancher, Kubernetes... Minecraft? (Setup and Install Tutorial)"
date: 2020-04-09 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes docker minecraft gaming
---

[![Docker, Rancher, Kubernetes... Minecraft? (Setup and Install Tutorial)](https://img.youtube.com/vi/oILc0ywDVTk/0.jpg)](https://www.youtube.com/watch?v=oILc0ywDVTk "Docker, Rancher, Kubernetes... Minecraft? (Setup and Install Tutorial)")

If you want to set up Kubernetes at home using Rancher to run Docker containers, this is the guide for you. This is a step by step tutorial of how to install and configure Rancher, Docker, and Kubernetes for your homelab.  In this video we set up and configure a Minecraft server in just a matter of minutes with some enterprise like features.  You can use this same process to spin up other Docker containers at home on your server or desktop.

[Watch Video](https://www.youtube.com/watch?v=oILc0ywDVTk)

See all the hardware I recommend at <https://l.technotim.live/gear>

## Install Docker

To install docker, see [https://docs.technotim.live/posts/docker-compose-install/](https://docs.technotim.live/posts/docker-compose-install/)

## Install Rancher

The two paths in the workload configuration need to be reversed:

- `Path on the Node` should be `mc`
- `Mount Point` should be `/data`

You'll want to use a command similar to this so that there aren't any port conflicts with other services or kubernetes itself.

Also, you may want to consider pinning your docker tag to a version other than `latest` to make backing up and upgrading easier. See [here](https://github.com/rancher/rancher/tags) for the latest version.

```bash
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 --privileged -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server rancher/rancher:latest
```

## Troubleshooting

- Make sure you have a static IP on your Rancher host
- Be sure to use the ports above if you want to add SSL later and use commands in future videos
- The new UI is now the "Cluster Explorer".  You can toggle between this and the "Cluser Manager" UI by clicking the button.
- Do not create workloads in the `local` cluster.  This is a management cluster for Rancher.  You should create new cluster for your workload, just like in this video.

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.
