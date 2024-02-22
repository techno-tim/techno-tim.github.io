---
layout: post
title: "The FASTEST way to deploy apps to Kubernetes - GitOps with FLUX"
date: 2022-05-13 08:00:00 -0500
categories: kubernetes 
tags: flux devops gitops kubernetes
image:
  path: /assets/img/headers/flux-streak.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP49fhD8dNCfxC+m+FPhR4U8F399bCKbxBpkWkXuqNbCWANA0eoeGptNkjknEd1NavYtpU80Uaz6ZLAqQr+lZLxBha+KnQwWTYTLKlWnLnxOH+ryquCcfcSeDhBR5uWTgkqMpRXPSlZW/O86yDEU8LGrjc4xeY0qc01hazrU6PPaT5rwxTq3UbxjN1HWgm3CtGWp96x/BPw/qEaX9540+ME93fIt5dTt8Tdajaa5uQJp5WjtooLdGkldnKQQQwqTtiijQKg/TFw3hKiU6mYZ9OpNc9Sf9s4qHPOWspcsOWEeaTb5YRUVe0Ukkj8mnxRiKM5UqWV8Pwp0pSp04LJcDJQhBuMIqU6U5yUYpK85yk7XlKTu3//Z

---

I think I found the perfect GitOps and DevOps toolkit with FluxCD and Kubernetes.Flux is an open source GitOps solution that helps your deploy app and infrastructure with automation.It can monitor git  repositories, source control, image container repositories, helm repositories, and more.It can install apps using Kustomize, Helm, Kubernetes manifests so it's designed to fit into your existing workflow.It can even push alerts to your chat system letting you know when deployments happen.In this tutorial we'll cover all of this and more.

<https://fluxcd.io>

Be sure to ⭐ the [Flux GitHub repo](https://github.com/fluxcd/flux2)

{% include embed/youtube.html id='PFLimPh5-wo' %}

📺 [Watch Video](https://www.youtube.com/watch?v=PFLimPh5-wo)

## Kubernetes Cluster

If you're looking to install your own Kubernetes cluster, be sure to check out [this video that creates a cluster with Ansible](https://www.youtube.com/watch?v=CbkEWcUZ7zM)

## Reference Repo

If you're looking for the repo I created this in video, you can [find it here](https://l.technotim.live/quick-start) `/demos/flux-demo`

## Install Flux CLI

```bash
curl -s https://fluxcd.io/install.sh | sudo bash
```

## Installing Flux using a GitHub Repo

You'll need to grab a personal access token from [here](https://github.com/settings/tokens)

```bash
flux bootstrap github \
  --components-extra=image-reflector-controller,image-automation-controller \
  --owner=YourGitHUbUserName \
  --repository=flux \
  --branch=main \
  --path=clusters/home \
  --personal \
  --token-auth
```

Check flux pods

```bash
kubectl get pods -n flux-system
```

## Source Controller (installing manifests)

See [reference repo](https://l.technotim.live/quick-start) for files, located in `/demos/flux-demo`

## Helm Controller (installing helm charts)

See [reference repo](https://l.technotim.live/quick-start) for files, `/demos/flux-demo`

## Image Automation Controller (monitoring a container registry)

See [reference repo](https://l.technotim.live/quick-start) for files, `/demos/flux-demo`

First create a workload (see redis deployment file)

Deploy the redis workload  (`deployment.yml`)

```bash
git add -A && \
git commit -m "add redis deployment" && \
git push origin main
```

Create `ImageRepository` in the cluster, namespace, and chart that correspond.

```bash
flux create image repository podinfo \
--image=redis \
--interval=1m \
--export > ./clusters/home/default/redis/redis-registry.yaml
```

Create `ImagePolicy` in the cluster, namespace, and chart that correspond.

```bash
flux create image policy podinfo \
--image-ref=podinfo \
--select-semver=5.0.x \
--export > ./clusters/home/default/redis/redis-policy.yaml
```

Then deploy the `ImageRepository` and `ImagePolicy`

```bash
git add -A && \
git commit -m "add redis image scan" && \
git push origin main
```

tell flux to apply changes

```bash
flux reconcile kustomization flux-system --with-source
```

Now edit your `deployment.yml` and add a comment

```yml
    spec:
      containers:
      - name: redis
        image: redis:6.0.0 # {"$imagepolicy": "flux-system:redis"}
```

Create `ImageUpdateAutomation`

```bash
flux create image update flux-system \
--git-repo-ref=flux-system \
--git-repo-path="./clusters/home" \
--checkout-branch=main \
--push-branch=main \
--author-name=fluxcdbot \
--author-email=fluxcdbot@users.noreply.github.com \
--commit-template="{{range .Updated.Images}}{{println .}}{{end}}" \
--export > ./clusters/home/flux-system-automation.yaml
```

Commit and deploy

```bash
git add -A && \
git commit -m "add image updates automation" && \
git push origin main
```

tell flux to apply changes

```bash
flux reconcile kustomization flux-system --with-source
```

Now do a git pull to see that flux has applied the tags

```bash
git pull
```

Your `deployment.yml` should be updated and it should be deployed to your cluster!

```yml
    spec:
      containers:
      - name: redis
        image: redis:6.0.16 # {"$imagepolicy": "flux-system:redis"}
```

## Notifications

Create a secret

```bash
kubectl -n flux-system create secret generic discord-url \
--from-literal=address=https://discord.com/api/webhooks/YOUR/WEBHOOK/URL
```

Create a notification provider

```yaml
apiVersion: notification.toolkit.fluxcd.io/v1beta1
kind: Provider
metadata:
  name: discord
  namespace: flux-system
spec:
  type: discord
  channel: general
  secretRef:
    name: discord-url
```

Define an Alert

```yaml
apiVersion: notification.toolkit.fluxcd.io/v1beta1
kind: Alert
metadata:
  name: on-call-webapp
  namespace: flux-system
spec:
  providerRef:
    name: discord
  eventSeverity: info
  eventSources:
    - kind: GitRepository
      name: '*'
    - kind: Kustomization
      name: '*'
```

Get alerts

```bash
kubectl -n flux-system get alerts

NAME             READY   STATUS        AGE
on-call-webapp   True    Initialized   1m
```

## Updating Flux

If you need to update flux, check out [Updating Flux Installation Using the Latest Binary from CLI](/posts/update-flux/)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
