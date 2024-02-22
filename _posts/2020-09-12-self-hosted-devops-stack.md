---
layout: post
title: "Build & Deploy Your Own Code in Your Homelab!"
date: 2020-09-12 09:00:00 -0500
categories: self-hosted homelab
tags: homelab rancher kubernetes gitlab
image:
  path: /assets/img/headers/infinity-glass.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP6G/wDgpnbapPptt4rsNaksj4G1PVPDWlaRNYWFzYySXFjYXt9qtxcW0OnanJcXG+zhgglvpoLWO0lwJft04q5VKdJJyw1CtLkq2lVdZOPtIcqcVSrUknB2nG/MnKK5lKK5T918NMFLF1LSxuOoQrezxHs8PUocvNRruMI1HisPipTjaM01CVFSjUakpOMZL8Kv+E61c8uImc8uwjt1DMfvMFNuxAJyQCzEdNx61w+0/uL75f5n9A/Vf+n9b/yj/wDKT//Z

---

So you're a software engineer or a developer who wants to self-host your own code in your own homelab?  Well this is the tutorial for you!  In this step-by-step guide we'll walk through setting up a repo, building and testing our own code (with unit tests) in a self-hosted Gitlab CI runner in our CI pipeline, then we'll build a Docker image and push it up to a container registry, then we'll use kubectl in our CD pipeline to deploy our Docker container to our self-hosted kubernetes cluster!  This all happens in a couple of minutes and then we'll truly have continuous integration and continuous delivery in our homelab!

{% include embed/youtube.html id='Xc94HJn1nNo' %}

📺 [Watch Video](https://www.youtube.com/watch?v=Xc94HJn1nNo)

## Helpful videos

1 - [Set Up Kubernetes with Rancher](https://www.youtube.com/watch?v=oILc0ywDVTk)

2 - [Set up a reverse proxy and SSL with Traefik](https://www.youtube.com/watch?v=pAM2GBCDGTo)

3 - [Expose Rancher and Kubernetes API Securely](https://www.youtube.com/watch?v=Af7HXhElams)

## GitLab react app

See the app here:

[https://github.com/techno-tim/techno-react](https://github.com/techno-tim/techno-react)

Docker file:

[https://github.com/techno-tim/techno-react/blob/master/Dockerfile](https://github.com/techno-tim/techno-react/blob/master/Dockerfile)

Kubernetes deployment yaml

[https://github.com/techno-tim/techno-react/blob/master/kubernetes/deployment.yaml](https://github.com/techno-tim/techno-react/blob/master/kubernetes/deployment.yaml)

nginx config for your react application

[https://github.com/techno-tim/techno-react/blob/master/nginx.conf](https://github.com/techno-tim/techno-react/blob/master/nginx.conf)

`pbcopy` for WSL on Windows

[https://www.techtronic.us/pbcopy-pbpaste-for-wsl/](https://www.techtronic.us/pbcopy-pbpaste-for-wsl/)
[https://www.techtronic.us/pbcopy-pbpaste-for-wsl/](https://www.techtronic.us/pbcopy-pbpaste-for-wsl/)

Example `config.toml` for your GitLab runner.

```toml
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "rancher-gitlab-runner"
  url = "https://gitlab.com"
  token = "your-gitlab-runner-token"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
  [runners.docker]
    tls_verify = false
    image = "docker:stable"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = [\"/var/run/docker.sock:/var/run/docker.sock\", \"/cache\"]
    shm_size = 0
```

example `~/.kube/config` for your GitLab secret

```yml

apiVersion: v1
kind: Config
clusters:
- name: "cluster1"
  cluster:
    server: "https://your.rancher.url/k8s/clusters/c-cluster-id"
users:
- name: "cluster1"
  user:
    token: "your kubernetes token"

contexts:
- name: "cluster1"
  context:
    user: "cluster1"
    cluster: "cluster1"

current-context: "cluster1"
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
