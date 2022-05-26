---
layout: post
title: "High Availability Rancher on kubernetes"
date: 2020-12-19 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes k3s
---

[![High Availability Rancher on kubernetes](https://img.youtube.com/vi/APsZJbnluXg/0.jpg)](https://www.youtube.com/watch?v=APsZJbnluXg "High Availability Rancher on kubernetes")

Are you running Kubernetes in your homelab or in the enterprise?
Do you want an easy way to manage and create Kubernetes clusters?
Join me as we walk through installing Rancher on an existing high availability k3s cluster in this step-by-step tutorial.

We install Rancher, configure a load balancer, install and configure helm, install cert-manager, configure Rancher, walk through the GUI, scale up our cluster, and set up a health check and liveness check! Join me, it's easy in this straightforward guide.

[Watch Video](https://www.youtube.com/watch?v=APsZJbnluXg)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## install

**Note:**
It's advised you consult the [Rancher Support Matrix](https://rancher.com/support-maintenance-terms/all-supported-versions)
to get the recommended version for all Rancher dependencies.

[https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/#1-install-the-required-cli-tools](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/#1-install-the-required-cli-tools)

`kubectl`

install `helm`

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

add `helm` repo, `stable`

```bash
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```

create rancher namespace

```bash
kubectl create namespace cattle-system
```

ssl configuration

user rancher generated (default)

install `cert-manager`

```bash
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
```

create name-space for `cert-manager`

```bash
kubectl create namespace cert-manager
```

Add the Jetstack Helm repository

 ```bash
 helm repo add jetstack https://charts.jetstack.io
 ```

update helm repo

```bash
helm repo update
```

install `cert-manager` helm chart

*Note: If you receive an "Error: Kubernetes cluster unreachable" message when installing cert-manager, try copying

the contents of "/etc/rancher/k3s/k3s.yaml" to "~/.kube/config" to resolve the issue.*

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.7.1
```

check rollout of cert-manager

```bash
kubectl get pods --namespace cert-manager
```

Be sure each pod is fully running before proceeding

Install Rancher with Helm

*Note:If you have ".local" for your private TLD then Rancher will NOT finish the setup within the webUI*

```bash
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com
```

check rollout

```bash
kubectl -n cattle-system rollout status deploy/rancher
```

you should see

```bash
Waiting for deployment "rancher" rollout to finish: 0 of 3 updated replicas are available...
Waiting for deployment "rancher" rollout to finish: 1 of 3 updated replicas are available...
Waiting for deployment "rancher" rollout to finish: 2 of 3 updated replicas are available...
deployment "rancher" successfully rolled out
```

check status

```bash
kubectl -n cattle-system rollout status deploy/rancher
```

you should see

```log
deployment "rancher" successfully rolled out
```

## load balancer

If you are using `k3s` you can use the `traefik` ingress controller that ships with `k3s`

run

```bash
kubectl get svc --all-namespaces -o wide
```

look for

```log
kube-system     traefik                LoadBalancer   10.43.202.72   192.168.100.10   80:32003/TCP,443:32532/TCP   5d23h   app=traefik,release=traefik
```

then create a DNS entry for `rancher.example.com    192.168.100.10`

This can be a host entry on your machine, or a DNS entry in your local DNS system (router, pi hole, etc...)

otherwise you can use `nginx`

nginx lb

[https://rancher.com/docs/rancher/v2.x/en/installation/resources/k8s-tutorials/infrastructure-tutorials/nginx/](https://rancher.com/docs/rancher/v2.x/en/installation/resources/k8s-tutorials/infrastructure-tutorials/nginx/)

## other considerations

Separating Rancher Cluster from your User Cluster

[https://rancher.com/docs/rancher/v2.x/en/overview/architecture-recommendations/#separation-of-rancher-and-user-clusters](https://rancher.com/docs/rancher/v2.x/en/overview/architecture-recommendations/#separation-of-rancher-and-user-clusters)
