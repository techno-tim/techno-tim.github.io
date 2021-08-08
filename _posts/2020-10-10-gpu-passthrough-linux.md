---
layout: post
title: "I Heard You Like GPUs in Servers... GPU Passthrough on Linux and Docker"
date: 2020-10-10 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes docker portainer nvidia hardware
---

[![I Heard You Like GPUs in Servers... GPU Passthrough on Linux and Docker](https://img.youtube.com/vi/9OfoFAljPn4/0.jpg)](https://www.youtube.com/watch?v=9OfoFAljPn4 "I Heard You Like GPUs in Servers... GPU Passthrough on Linux and Docker")

Do you have a lot of virtual machines?  Are you running Windows, Linux, and Mac and need remote access from a single UI?  Well, Apache Guacamole is for you!  Apache Guacamole is a clientless remote access gateway that give you a web portal to access any of your clients over standard protocols like VNC, RDP, SSH, TELNET, and more. Join me in this step by step tutorial as we set up a self-hosted version of Guacamole in your homelab.  As an added bonus, we'll set up 2FA (multifactor authentication) to help secure Guacamole.  Oh, yeah, and we'll do this all in Docker and or Kubernetes, it's up to you!  :)


[Watch Video](https://www.youtube.com/watch?v=9OfoFAljPn4)



```
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



If you need to passthrough a GPU, follow [this guide](https://github.com/techno-tim/youtube-videos/tree/master/gpu-passthrough) but install Ubuntu instead.


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

