---
layout: post
title: "Self-Hosting Your Homelab Services with SSL -- Let's Encrypt, MetalLB, Traefik, Rancher, Kubernetes"
date: 2020-08-15 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes traefik wsl metal-lb
image:
  path: /assets/img/headers/traffic-light.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4U4PEMf/CLaHosGl21td6frGpXkuswSPHd6hDqP2dBZ3iRhFkWzNoGtZ3keaISyxxsiEKPVwsZ0p1ayrV2q8qEVQlVk6FF0PbRlOjTvaE66qU1VcbX9hTatLmb8LMOXFyw1KdDCRWEw2KpurTwlCOLxP1idKvT+tYpR9pXWFlGvGhGrz8sMROEm6dOlCJLdN5kn7uH779YIGP3j1ZoizH1JJJ6kk16UqnvS9yHxPeMG9+rcbt+b1PEhRhyQ1qfBHatWitltFVLJdktFsj/AP/Z
---

Are you self-hosting lots of services at home in your homelab?  Have you been port forwarding or using VPN to access your self-hosted services wishing you had certificates so that you can access them securely over SSL?  Well after this video, you can!  In this step by step tutorial we'll walk through setting up Rancher and Kubernetes with a reverse proxy, Kubernetes Ingress, MetalLB, Traefik, Let's Encrypt, and DNS giving you free certificates.

{% include embed/youtube.html id='pAM2GBCDGTo' %}

📺 [Watch Video](https://www.youtube.com/watch?v=pAM2GBCDGTo)

## Install WSL on Windows 10

<https://www.youtube.com/watch?v=kL8iGErULiw>

## Install `kubectl`

<https://kubernetes.io/docs/tasks/tools/install-kubectl/>

## Install MetalLB

<https://metallb.universe.tf/installation/>

`kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml`

`kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml`

You should only ever run this step once.

`kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"`

sample `config.yaml`

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.1.240-192.168.1.250
```

`kubectl apply -f config.yaml`

## Traefik

traefik sample answers yaml

*change "staging: true" to "staging: false" once you confirm its all working to get the live certs*

```yml
---
  defaultImage: true
  imageTag: "1.7.14"
  serviceType: "LoadBalancer"
  debug: 
    enabled: false
  rbac: 
    enabled: true
  ssl: 
    enabled: true
    enforced: true
    permanentRedirect: false
  acme: 
    enabled: true
    email: "you@example.com"
    onHostRule: true
    staging: true
    logging: true
    challengeType: "dns-01"
    dnsProvider:
      name: "cloudflare"
      existingSecretName: "cloudflare-dns"
  persistence: 
    enabled: true
  dashboard: 
    enabled: true
    domain: "traefik.example.com"
    auth: 
      basic: ""
```

## Traefik Helm

<https://hub.helm.sh/charts/stable/traefik>

## Traefik DNS Providers

<https://docs.traefik.io/https/acme/#providers>

## Troubleshooting

Be sure that your Traefik yaml matches the code above exactly, including whitespace.Yaml is whitespace sensitive.

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
