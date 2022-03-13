---
layout: post
title: "Build & Deploy Your Own Code in Your Homelab!"
date: 2020-09-12 09:00:00 -0500
categories: self-hosted homelab
tags: homelab rancher kubernetes gitlab
---

[![Build & Deploy Your Own Code in Your Homelab!](https://img.youtube.com/vi/Xc94HJn1nNo/0.jpg)](https://www.youtube.com/watch?v=Xc94HJn1nNo "Build & Deploy Your Own Code in Your Homelab!")

So you're a software engineer or a developer who wants to self-host your own code in your own homelab?  Well this is the tutorial for you!  In this step-by-step guide we'll walk through setting up a repo, building and testing our own code (with unit tests) in a self-hosted Gitlab CI runner in our CI pipeline, then we'll build a Docker image and push it up to a container registry, then we'll use kubectl in our CD pipeline to deploy our Docker container to our self-hosted kubernetes cluster!  This all happens in a couple of minutes and then we'll truly have continuous integration and continuous delivery in our homelab!

[Watch Video](https://www.youtube.com/watch?v=Xc94HJn1nNo)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

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
