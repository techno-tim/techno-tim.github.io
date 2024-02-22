---
layout: post
title: "Mirror your Kubernetes configs, secrets, and resources to other namespaces"
date: 2023-04-26 21:37:00 -0500
categories: homelab
tags: kubernetes k8s cert-manager reflector helm
image:
  path: /assets/img/headers/mirror-image-chess.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP6jNS8Kapc6r4r1y38c+L7FPEXhWXw9Z6Lb3to+ieGrx4Uij8TaHZXFnKYNegdTMkskr2sjySfaLabKFOqlhYRxVSvKriJqsqadCVVewpxhFX9hDk/dzna8ptzvJt2tofCVs6p1cnyvKVkuTUp5biq+JnmtPCzjmuZKtUnUWGzHEqtathqKmqdKnGFNxpwglK6bloPdyb2/3m7+5rs5I9vzPCP/2Q==

---

## What is Reflector?

**Reflector** is a Kubernetes addon designed to monitor changes to resources (secrets and configmaps) and reflect changes to mirror resources in the same or other namespaces.Since secrets and configs are scoped to a single namespace, this helps you create and change resources in one namespace and "reflect" them to resources in other namespaces.This is especially helpful for things like certificates and configs that are needed in multiple namespaces.You can find the [GitHub repo here](https://github.com/emberstack/kubernetes-reflector)!

## Install

This might go without saying but you'll want to be sure you have a working Kubernetes cluster!  If you need help setting on up, check out my [Ansible Playbook](/posts/k3s-etcd-ansible/)!

You'll also want to be sure you have [helm](https://helm.sh/docs/intro/install/) installed.

Then we'll run:

```bash
helm repo add emberstack https://emberstack.github.io/helm-charts
helm repo update
helm upgrade --install reflector emberstack/reflector
```

This command will add the `helm` repo locally, then update the repo, then install `reflector` in your cluster.

## Reflecting Resources

Now that it's installed, all we need to do is add some annotations to "reflect" our resources to other namespaces.

### Secrets

Let's say you create the following `Secret` with the annotation below:

```yaml
apiVersion: v1
kind: Secret
metadata:
 name: some-secret
 annotations:
   reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
   reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces: "namespace-1,namespace-2,namespace-[0-9]*"
data:
 ...
```

This will:

- create a `Secret`
- "reflect" the same secret to `namespace-1` , `namespace-2` and all other namespaces that match the pattern `namespace-[0-9]*`

### ConfigMaps

`ConfigMaps` are just as easy!  Let's say you have a `ConfigMap` with the following contents:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
 name: source-config-map
 annotations:
   reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
   reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces: "namespace-1,namespace-2,namespace-[0-9]*"
data:
 ...
```

This will:

- create a `ConfigMap`
- "reflect" the same `ConfigMap` to `namespace-1` , `namespace-2` and all other namespaces that match the pattern `namespace-[0-9]*`

### Certificates

This is the real reason I brought this chart into my cluster, was support for `cert-manager` certificates. There are many cases where I need to create the same certificate in multiple namespaces and rather than create them manually, I have reflector create them for me.

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
...
spec:
  secretTemplate:
    annotations:
      reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
      reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces: "namespace-1,namespace-2,namespace-[0-9]*"
  ...
```

This will:

- create a `Certificate`
- "reflect" the same `Certificate` to `namespace-1` , `namespace-2` and all other namespaces that match the pattern `namespace-[0-9]*`

The benefit of doing it this way with `cert-manager` is that when your certificates are updated with something like [Let's Encrypt](https://letsencrypt.org/), all certificates you reflect are also updated! Of course you will only want to limit your reflections to other namespaces you trust.If you'd like to check out `cert-manager` see my post on [how to install traefik and cert-manager](/posts/kube-traefik-cert-manager-le)!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Ok, I think I made it just in time! <br><br>A post on reflector for Kubernetes!<a href="https://t.co/IOYIhTk6g5">https://t.co/IOYIhTk6g5</a><a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1651435186297421825?ref_src=twsrc%5Etfw">April 27, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
