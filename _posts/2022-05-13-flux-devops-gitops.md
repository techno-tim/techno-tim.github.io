---
layout: post
title: "The FASTEST way to deploy apps to Kubernetes - GitOps with FLUX"
date: 2022-05-13 08:00:00 -0500
categories: kubernetes 
tags: flux devops gitops kubernetes
---

[![The FASTEST way to deploy apps to Kubernetes](https://img.youtube.com/vi/PFLimPh5-wo/0.jpg)](https://www.youtube.com/watch?v=PFLimPh5-wo "The FASTEST way to deploy apps to Kubernetes")

I think I found the perfect GitOps and DevOps toolkit with FluxCD and Kubernetes.  Flux is an open source GitOps solution that helps your deploy app and infrastructure with automation.  It can monitor git  repositories, source control, image container repositories, helm repositories, and more.  It can install apps using Kustomize, Helm, Kubernetes manifests so it's designed to fit into your existing workflow.  It can even push alerts to your chat system letting you know when deployments happen.  In this tutorial we'll cover all of this and more.

<https://fluxcd.io>

Be sure to ⭐ the [Flux GitHub repo](https://github.com/fluxcd/flux2)

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

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
