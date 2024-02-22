---
layout: post
title:  "Multi-CPU Architecture Kubernetes Cluster with a Raspberry Pi"
date:   2021-03-14 09:00:00 -0500
categories: kubernetes k3s 
tags: raspberry-pi k3s kubernetes homelab hardware
image:
  path: /assets/img/headers/gears-green.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/ANb4n/tJ/EHUf27/ANtvRtC1XWzpfwO8QfEf4V6ZB8UPEmp/GafxB4JsdX1rwn4n0bUJ/F3lR6ZBr2r6eutaUuiW1iPD+kynw9eDxHdRQeI4/wA6zXLaWWZnhKlPFZhXnjK9RzeJxFGtFfV1GVKlyywzvhowjNKmnGqq0lXWISni6WL9nKs+xeZvHUquGy6hhsueHhTo4bDToyl7Wbo1KvtYV044h1HGo5SjOi6alRnQk1h6uG+Tfh3+yVeSfD/wNJY/FrX9PsZPB3hl7OwTR/NSxtW0Wya3s1kGuQiRbaEpCriKIOEDCNM7R+eYzjVUcZiqSyqnJUsTXpqUsXK8lCrKKbtQSu7XdklfZI/ScNk1f6th/wDb4r9xS0WEVv4cdr127erb8z//2Q==

---

Building a Multi-architecture CPU Kubernetes cluster is easier than you think with `k3s`.In this video we'll build a Raspberry Pi 4 with an ARM CPU and add it to our existing x86 x64 amd64 CPU Kubernetes cluster.Our foundation will be Ubuntu for ARM, then we'll add `k3s`, and then join it to our cluster.We'll also discuss how this works with Docker images built for specific CPU types.We'll also talk about some build configurations and requirements for your Pi.

Happy Pi Day!

{% include embed/youtube.html id='_xykXkNia-Y' %}

📺 [Watch Video](https://www.youtube.com/watch?v=_xykXkNia-Y)

```bash
k3s --version
```

get `k3s` token from a server

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

set `k3s` version (the value you got from `k3s --version`)

```bash
 export INSTALL_K3S_VERSION=v1.20.5+k3s1
```

install `k3s` as an agent using your token from above

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://example.local.com:6443 K3S_TOKEN=hksadhahdklahkadjhasjdhasdhasjk::server:asljkdklasjdaskdljaskjdlasj sh -
```

check all `k3s` nodes from your workstation

```bash
kubectl get nodes
```

get all pods running on a specific node (`elio`)

```bash
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=elio
```

set a label on a node (`elio`)

```bash
kubectl label nodes elio cputype=arm
```

describe a node (`elio`)

```bash
kubectl describe node elio
```

Example pod spec

`nginx-pod.yml`

```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    cputype: arm64
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
