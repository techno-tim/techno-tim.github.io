---
layout: post
title: "Configuring Traefik 2 Ingress for Kubernetes"
date: 2021-04-08 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes k3s traefik
---

## About

> *Note: There is an updated tutorial on installing traefik + cert-manager on Kubernetes [here](https://docs.technotim.live/posts/kube-traefik-cert-manager-le/). However, if you want to store your certificates on disk, this tutorial here is perfectly fine.*
{: .prompt-info }

This guide is for installing `traefik 2` on `k3s`.  If you're not using rancher, that's fine, just skip to `Reconfiguring k3s`

It assumes you have followed:

* [Fully Automated K3S etcd High Availability Install](https://www.youtube.com/watch?v=CbkEWcUZ7zM)
* (or) [HIGH AVAILABILITY k3s (Kubernetes) in minutes!](https://www.youtube.com/watch?v=UoOcLXfa8EU)
* (if you need rancher) [High Availability Rancher on a Kubernetes Cluster](https://www.youtube.com/watch?v=APsZJbnluXg)

There is a little bit of "undoing" we'll have to do since k3s ships with `traefik` and Rancher doesn't play well with service load balancer. So, we'll pick up after instaling these two.

## Reconfigure Rancher

Make note of your version of Rancher

Remove Rancher

```bash
helm uninstall rancher
```

Install Rancher

(replace with version above)

```bash
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com \
  --version 2.5.6
```

## Reconfiguring k3s

Get the version of `k3s` that's currently running

```bash
k3s --version
export INSTALL_K3S_VERSION=v1.20.5+k3s1
```

Run the same command you ran initially to install `k3s` on your servers but add `--disable traefik --disable servicelb` and be sure to set your version.

example (be sure you are using the right version)

```bash
export INSTALL_K3S_VERSION=v1.20.5+k3s1
```

```bash
curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san your.load.balancer.ip --write-kubeconfig-mode 644 --disable traefik --disable servicelb
```

This should reconfigure your servers.  Just run it on all server nodes, not agent nodes.

## Install Metal LB

[Metal LB installation](https://metallb.universe.tf/installation/)

You can follow [Self-Hosting Your Homelab Services with SSL](https://www.youtube.com/watch?v=pAM2GBCDGTo) to get the idea of Metal LB. It's recommended to:

* Install with [helm](https://metallb.universe.tf/installation/#installation-with-helm)
* Use [Layer2 configuration](https://metallb.universe.tf/configuration/#layer-2-configuration) if you follow this series

## Exposing Rancher directly to your Metal LB

It's a good idea to do this until traefik is configured otherwise you won't have access to the Rancher UI

```bash
kubectl expose deployment rancher -n cattle-system --type=LoadBalancer --name=rancher-lb --port=443
```

Then, you can access Rancher UI after getting external-IP

```bash
kubectl get service/rancher-lb -n cattle-system
```

## Install Traefik 2

You can can choose between creating `Ingress` in Rancher or `IngresRoute` with `traefik`

If you choose `IngressRoute` see [IngressRoute](#exposing-a-service-with-traefik-ingressroute) otherwise continue on.

* You must have a persistent volume set up already for `acme.json` certificate
* This uses cloudflare, check providers if you want to switch
* This will get wildcard certs
* This is pointed at staging, if you want production be sure comment staging the line (and delete your staging certs)

We will be installing this into the `kube-system` namespace, which already exists. If you are going to use anther namespace you will need change it everywhere.

### (Optional) Make sure that persistent volume claim is available

The dynamic configuration for Traefik is stored in a persistent volume. If you want to persist the certificate, it's better to create one now to claim later.

To create a persistent volume, it's better to check out [Cloud Native Distributed Storage in Kubernetes with Longhorn](https://www.youtube.com/watch?v=eKBBHc0t7bc).

If not, just create one from `Rancher UI > Clusters (Choose your cluster) > Storage > Persistent Volume > Add volume`

### Add `traefik` helm repo and update

```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
```

### Edit & apply ConfigMap

* Create `traefik-config.yaml` with the contents of `/config/traefik-config.yaml` from [/config](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik2-k3s-rancher/config)
* This holds our cloudflare secrets along with a configmap
* Update this file with your values
* Re-check if you have a persistent volume ready to claim
* Apply the config

```bash
kubectl apply -f traefik-config.yaml
```

### Edit & install Traefik helm chart

* Create `traefik-chart-values.yaml` with the contents of `/config/traefik-chart-values.yaml` from [/config](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik2-k3s-rancher/config)
* Update `loadBalancerIP` in `traefik-chart-values.yaml` with your Metal LB IP

Before running this, be sure you only have one default storage class set.

If you are using Rancher it is `Cluster > Storage > Storage Classes`. Make sure only one is default.

* Install Traefik with chart values

```bash
helm install traefik traefik/traefik --namespace=kube-system --values=traefik-chart-values.yaml
```

More configuration value can be add from this [default-value.yaml](https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml) from Traefik github.

If all went well, you should now have traefik 2 installed and configured.

### Check for container logs

To check if the Traefik instance is running correctly, see the logs:

```bash
kubectl -n kube-system logs $(kubectl -n kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name)
```

It should be `level=info msg="Configuration loaded from flags."`

## Traefik Dashboard

To see all router to Traefik, we can install and expose Traefik Dashboard.

First you will need `htpassword` to generate a password for your dashboard.

```bash
sudo apt-get update
sudo apt-get install apache2-utils
```

You can then generate one using this, be sure to swap your username and password.

```bash
htpasswd -nb techno password | openssl base64
```

It should output:

```bash
dGVjaG5vOiRhcHIxJFRnVVJ0N2E1JFpoTFFGeDRLMk8uYVNaVWNueG41eTAKCg==
```

Save this in a secure place, it will be the password you use to access the traefik dashboard.

Copy `traefik-dashboard-secret.yaml` locally and update it with your credentials.

Copy `traefik-dashboard-ingressroute.yaml` and update it with your hostname, then apply:

```bash
kubectl apply -f traefik-dashboard-secret.yaml
kubectl apply -f traefik-dashboard-ingressroute.yaml
```

This should create:

* A secret in Kubernetes cluster name `traefik-dashboard-auth`
* A middleware for Traefik name `traefik-dashboard-basicauth`
* An ingress route for Traefik name `dashboard`

Check out the Traefik Dashboard with the URL you specify earlier.

## Exposing a service with traefik and Rancher Ingress

In Rancher go to Load Balancing

* create ingress
* choose a host name (service.example.com)
* choose a target (your workload)
* set the port to the exposed port within the container
* go to labels and annotations and add `kubernetes.io/ingress.class` = `traefik-external`
* note, `traefik-external` comes from `--providers.kubernetesingress.ingressclass=traefik-external` in `traefik-chart-values.yml`.  If you used something else, you will need to set your label properly.
* when you visit your website (`https://service.example.com`) you should now see a certificate issues.  If it's a staging cert, see the note about switching to production in `traefik-chart-values.yaml`.  After changing, you will need to delete your certs in storage and reapply that file

```bash
kubectl delete -n kube-system persistentvolumeclaims acme-json-certs
kubectl apply -f traefik-config.yaml
```

## Exposing a service with traefik IngressRoute

copy the contents of [config-ingress-route/kubernetes](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik2-k3s-rancher/config-ingress-route/kubernetes) to your local machine

then run

```bash
kubectl apply -f kubernetes
```

This will create the deployment, service, and ingress.

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.