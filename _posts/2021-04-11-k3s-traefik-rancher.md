---
layout: post
title: "Traefik 2, k3s, Rancher"
date: 2021-04-08 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes k3s traefik
---

# Traefik 2, k3s, Rancher

## About
No video currently exists for this (yet)

This guide is for installing `traefik 2` on `k3s`

It assumes you have followed:

* [HIGH AVAILABILITY k3s (Kubernetes) in minutes!](https://www.youtube.com/watch?v=UoOcLXfa8EU)

* [High Availability Rancher on a Kubernetes Cluster](https://www.youtube.com/watch?v=APsZJbnluXg)



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

example
```bash
export INSTALL_K3S_VERSION=v1.20.5+k3s1
```
```bash
curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san your.load.balancer.ip --write-kubeconfig-mode 644 --disable traefik --disable servicelb
```

This should reconfigure your servers.  I ran it on all servers in my cluster.

## Install Metal LB

[Metal LB installation](https://metallb.universe.tf/installation/)


## Exposing Rancher directly to your Metal LB 

It's a good idea to do this until traefik is configured otherwise you won't have access to the Rancher Ui

```bash
kubectl expose deployment rancher -n cattle-system --type=LoadBalancer --name=rancher-lb --port=443
```

## Install Traefik 2

You can can choose between creating `Ingress` in Rancher or `IngresRoute` with `traefik` 

If you choose `IngressRoute` see [IngressRoute](#exposing-a-service-with-traefik-ingressroute) otherwise continue on.

* You must have a persistent volume set up already for `acme.json` certificate
* This uses cloudflare, check providers if you want to switch
* This will get wildcard certs
* This is pointed at staging, if you want production be sure comment staging the line (and delete your staging certs)

We will be installing this into the `kube-system` namespace, which already exists.  If you are going to use anther namespace you will need change it everywhere.

add `traefik` helm repo and update

```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
```

create `traefik-config.yaml` with the contents of `/config/traefik-config.yaml` from [/config](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik2-k3s-rancher/config)

this holds our cloudflare secrets along with a configmap

update this file with your values

apply the config

```bash
kubectl apply -f traefik-config.yaml
```

create `traefik-chart-values.yaml` with the contents of `/config/traefik-chart-values.yaml` from [/config](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik2-k3s-rancher/config)

Update `loadBalancerIP` in `traefik-chart-values.yaml` with your Metal LB IP


Before running this, be sure you only have one default storage class set.  If you are using Rancher it is Cluster>Storage>Storage Classes.  Make sure only one is default.


create config then update the values

```bash
kubectl apply -f traefik-config.yaml
```

```bash
helm install traefik traefik/traefik --namespace=kube-system --values=traefik-chart-values.yaml
```

If all went well, you should now have traefik 2 installed and configured.


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

copy the contents of [config-ingress-route/kubernetes](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik2-k3s-rancher/config-ingress-route) to your local machine

then run

```bash
kubectl apply -f kubernetes
```

This will create the deployment, service, and ingress.


## Dashboard

First you will need `htpassword` to generate a password for your dashboard

```bash
sudo apt-get update
sudo apt-get install apache2-utils
```

You can then generate one using this, be sure to swap your username and password

```bash
htpasswd -nb techno password | openssl base64
```

it should output

```bash
dGVjaG5vOiRhcHIxJFRnVVJ0N2E1JFpoTFFGeDRLMk8uYVNaVWNueG41eTAKCg==
```

copy `traefik-dashboard-secret.yaml` locally and update it with your credentials


then apply

```bash
kubectl apply -f traefik-config.yaml
```

copy `traefik-dashboard-ingressroute.yaml` and update it with your hostname


Save this in a secure place, it will be the password you use to access the traefik dashboard


## files

## Putting Rancher behind Traefik 2

TBD
