---
layout: post
title: "Wildcard Certificates with Traefik + cert-manager + Let's Encrypt in Kubernetes Tutorial"
date: 2022-08-06 09:00:00 -0500
categories: kubernetes
tags: kubernetes traefik cert-manager k3s cloudflare letsencrypt
---

[![Wildcard Certificates with Traefik + cert-manager + Let's Encrypt in Kubernetes Tutorial](https://img.youtube.com/vi/G4CmbYL9UPg/0.jpg)](https://www.youtube.com/watch?v=G4CmbYL9UPg "Wildcard Certificates with Traefik + cert-manager + Let's Encrypt in Kubernetes Tutorial")

Traefik, cert-manager, Cloudflare, and Let's Encrypt are a winning combination when it comes to securing your services with certificates in Kubernetes.  Today, we'll install and configure Traefik, the cloud native proxy and load balancer, as our Kubernetes Ingress Controller.  We'll then install and configure cert-manager  to manage certificates for our cluster.  We'll set up Let's Encrypt as our Cluster Issuer so that cert-manager can automatically provision TLS certificates and even wildcard certificates using Cloudflare DNS challenge absolutely free.  We'll walk through all of this, step by step, so you can help secure your cluster today.

📺 [Watch Video](https://www.youtube.com/watch?v=G4CmbYL9UPg)

A HUGE thanks to Datree for sponsoring this video!

Combat misconfigurations. Empower engineers.

<https://www.datree.io>

## Getting Started

If you need to install a new kubernetes cluster you can use my [Ansible Playbook](https://docs.technotim.live/posts/k3s-etcd-ansible/) to install one.

## Resources

You can find all of the resources from this tutorial [here](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik-cert-manager)

### helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Installing

Verify you can communicate with your cluster

```bash
kubectl get nodes
```

```console
NAME     STATUS   ROLES                       AGE   VERSION
k3s-01   Ready    control-plane,etcd,master   10h   v1.23.4+k3s1
k3s-02   Ready    control-plane,etcd,master   10h   v1.23.4+k3s1
k3s-03   Ready    control-plane,etcd,master   10h   v1.23.4+k3s1
k3s-04   Ready    <none>                      10h   v1.23.4+k3s1
k3s-05   Ready    <none>                      10h   v1.23.4+k3s1
```

Verify helm is installed

```bash
helm version
```

```console
version.BuildInfo{Version:"v3.8.0", GitCommit:"d14138609b01886f544b2025f5000351c9eb092e", GitTreeState:"clean", GoVersion:"go1.17.5"}
```

## Traefik

```bash
helm repo add traefik https://helm.traefik.io/traefik
```

```bash
helm repo update
```

```bash
helm install --namespace=traefik traefik traefik/traefik --values=values.yaml
```

Check the status of the Traefik ingress controller service

```bash
kubectl get svc --all-namespaces -o wide
```

should see traefik with the specified IP

```console
NAMESPACE        NAME              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
default          kubernetes        ClusterIP      10.43.0.1       <none>          443/TCP                      16h   <none>
kube-system      kube-dns          ClusterIP      10.43.0.10      <none>          53/UDP,53/TCP,9153/TCP       16h   k8s-app=kube-dns
kube-system      metrics-server    ClusterIP      10.43.182.24    <none>          443/TCP                      16h   k8s-app=metrics-server
metallb-system   webhook-service   ClusterIP      10.43.205.142   <none>          443/TCP                      16h   component=controller
traefik          traefik           LoadBalancer   10.43.156.161   192.168.30.80   80:30358/TCP,443:31265/TCP   22s   app.kubernetes.io/instance=traefik,app.kubernetes.io/name=traefik
```

```bash
kubectl get pods --namespace traefik
```

should see

```console
NAME                       READY   STATUS    RESTARTS   AGE
traefik-76474c4d47-l5z74   1/1     Running   0          11m
traefik-76474c4d47-xb282   1/1     Running   0          11m
traefik-76474c4d47-xx5lw   1/1     Running   0          11m
```

### middleware

```bash
kubectl apply -f default-headers.yaml
```

```bash
kubectl get middleware
```

should see

```console
NAME              AGE
default-headers   25s
```

### dashboard

install `htpassword`

```bash
sudo apt-get update
sudo apt-get install apache2-utils
```

generate password

```bash
htpasswd -nb techno password | openssl base64
```

apply secret

```bash
kubectl apply -f secret-dashboard.yaml
```

get secret

```bash
kubectl get secrets --namespace traefik
```

apply dashboard

```bash
kubectl apply -f ingress.yaml
```

visit

<https://traefik.local.technotim.live/>


## sample workload

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

or folder

```bash
kubectl apply -f nginx
```

## cert-manager

add repo

```bash
helm repo add jetstack https://charts.jetstack.io
```

```bash
update
```

```bash
kubectl create namespace cert-manager
```

```bash
kubectl get namespaces
```

should see

```console
NAME              STATUS   AGE
cert-manager      Active   12s
default           Active   21h
kube-node-lease   Active   21h
kube-public       Active   21h
kube-system       Active   21h
metallb-system    Active   21h
traefik           Active   4h35m
```

apply crds (1.9.1)

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml
```

```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --values=values.yaml --version v1.9.1
```

secrets

```bash
kubectl apply -f secret-cf-token.yaml
kubectl apply -f secret-cf-email.yaml
```

issuers


```bash
kubectl apply -f letsencrypt-staging.yaml
```

create certs

staging

from staging folder

```bash
kubectl apply -f technotim-live-cert.yaml
```

looks at logs

can tail with

```bash
kubectl logs -n cert-manager -f cert-manager-877fd747c-fjwhp
```

get challenges

```bash
kubectl get challenges
```

or more details with

```bash
kubectl describe order local-technotim-live-frm2z-1836084675
```


## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
