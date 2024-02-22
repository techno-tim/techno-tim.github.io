---
layout: post
title: "I Heard You Like GPUs in Servers... GPU Passthrough on Linux and Docker"
date: 2020-10-10 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes docker portainer nvidia hardware
image:
  path: /assets/img/headers/gpu-pc.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APxP+GXgr4aeHviV4V8e2XgyC20v/hKPEOp+OPD9pB4Sl1DxveJ448V3ViJPEuv+CvELaLZ22lC20u6srfR7uHVbiE6rf+ZMLa3tP3jDYfJsn4+p0MLkuFxGWvMPY08rzOtiMbhqdGryUnDnU6FeTi6ntYzdVNThHorGmMoY2jkGcxp5hyVv7LoVZ4uOCwv1iTnWTj7Oc41PqzTgo1J4b2U6tKVSjKShUmn+nlj+yr8GfENjZ6+9h4nt31y1t9YaBtZ0aUwNqcKXrQmWLwtaRSGMzlDJHa20bldyW8KkRr9tm08C81zN08lyWhTeYYx06FLKsujSoweJqctKlH6r7tOnG0ILpFJHw+DhUWDwiqYrGVaiw1BTqyxmLUqk1SjzVGvbuznK8mrvV7n/2Q==
---

We've already figured out how to pass through a GPU to Windows machine but why let Windows have all the fun?  Today, we do it on an Ubuntu headless server that's virtualized, run some AI and Deep Learning workloads, then turn up the transcoding on Plex to 11.

{% include embed/youtube.html id='9OfoFAljPn4' %}

📺 [Watch Video](https://www.youtube.com/watch?v=9OfoFAljPn4)

```text
88          88                                      
88          ""                                      
88                                                  
88,dPPYba,  88 8b,dPPYba,   ,adPPYb,d8  ,adPPYba,   
88P'    "8a 88 88P'   `"8a a8"    `Y88 a8"     "8a  
88       d8 88 88       88 8b       88 8b       d8  
88b,   ,a8" 88 88       88 "8a,   ,d88 "8a,   ,a8"  
8Y"Ybbd8"'  88 88       88  `"YbbdP"Y8  `"YbbdP"'   
                            aa,    ,88              
                             "Y8bbdP"               
```

If you need to passthrough a GPU, follow [this guide](/posts/gpu-passthrough/) but install Ubuntu instead.

## Proxmox

Shut down your VM in proxmox, edit your conf file, it should be here (note, change path to your VM's ID)

`/etc/pve/qemu-server/100.conf`

add `cpu: host,hidden=1,flags=+pcid` to that file

start the server.

## Linux Guest

```bash
sudo apt-get update

sudo apt-get upgrade

sudo apt-get install qemu-guest-agent # this is optional if you are virtualizing this machine

sudo apt-get install build-essential # build-essential is required for nvidia drivers to compile

sudo apt install --no-install-recommends nvidia-cuda-toolkit nvidia-headless-450 nvidia-utils-450 libnvidia-encode-450
```

Then reboot.

Then install `nvtop`

```bash
sudo apt-get install nvtop
```

## tensorflow workload

```bash
nvidia-docker run --rm -ti tensorflow/tensorflow:r0.9-devel-gpu
```

## Rancher / Kubernetes

In your Rancher server (or kubernetes host)

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

sudo apt-get install nvidia-container-runtime
```

update `daemon.json`

```bash
sudo nano /etc/docker/daemon.json
```

Replace with:

```json
{
  "default-runtime": "nvidia",
  "runtimes": {
    "nvidia": {
      "path": "/usr/bin/nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
```

Install one more util for nvidia:

```bash
sudo apt-get install -y nvidia-docker2
```

Reboot

Then, using `kubectl` on your kubernetes / rancher host

```bash
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
