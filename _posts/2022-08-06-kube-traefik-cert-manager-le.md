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

> You can find all of the resources for this tutorial [here](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik-cert-manager)
{: .prompt-info }

### Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

For other ways to install Helm see the installation docs [here](https://helm.sh/docs/intro/install)

## Installing

Verify you can communicate with your cluster

```bash
kubectl get nodes
```

You should see

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

You should see

```console
version.BuildInfo{Version:"v3.8.0", GitCommit:"d14138609b01886f544b2025f5000351c9eb092e", GitTreeState:"clean", GoVersion:"go1.17.5"}
```

## Traefik

> These [resources](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik-cert-manager) are in the `launchpad/kubernetes/traefik-cert-manager/traefik/` folder
{: .prompt-info }

Add repo

```bash
helm repo add traefik https://helm.traefik.io/traefik
```

Update repo

```bash
helm repo update
```

Create our namespace

```bash
kubectl create namespace traefik
```

Get all namespaces

```bash
kubectl get namespaces
```

We should see

```console
NAME              STATUS   AGE
default           Active   21h
kube-node-lease   Active   21h
kube-public       Active   21h
kube-system       Active   21h
metallb-system    Active   21h
traefik           Active   12s
```

Install traefik

```bash
helm install --namespace=traefik traefik traefik/traefik --values=values.yaml
```

Check the status of the traefik ingress controller service

```bash
kubectl get svc --all-namespaces -o wide
```

We should see traefik with the specified IP

```console
NAMESPACE        NAME              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
default          kubernetes        ClusterIP      10.43.0.1       <none>          443/TCP                      16h   <none>
kube-system      kube-dns          ClusterIP      10.43.0.10      <none>          53/UDP,53/TCP,9153/TCP       16h   k8s-app=kube-dns
kube-system      metrics-server    ClusterIP      10.43.182.24    <none>          443/TCP                      16h   k8s-app=metrics-server
metallb-system   webhook-service   ClusterIP      10.43.205.142   <none>          443/TCP                      16h   component=controller
traefik          traefik           LoadBalancer   10.43.156.161   192.168.30.80   80:30358/TCP,443:31265/TCP   22s   app.kubernetes.io/instance=traefik,app.kubernetes.io/name=traefik
```

Ger all pods in `traefik` namespace

```bash
kubectl get pods --namespace traefik
```

We should see pods in the `traefik` namespace

```console
NAME                       READY   STATUS    RESTARTS   AGE
traefik-76474c4d47-l5z74   1/1     Running   0          11m
traefik-76474c4d47-xb282   1/1     Running   0          11m
traefik-76474c4d47-xx5lw   1/1     Running   0          11m
```

### middleware

Apply middleware

```bash
kubectl apply -f default-headers.yaml
```

Get middleware

```bash
kubectl get middleware
```

We should see our headers

```console
NAME              AGE
default-headers   25s
```

### dashboard

Install `htpassword`

```bash
sudo apt-get update
sudo apt-get install apache2-utils
```

Generate a credential / password that's base64 encoded

```bash
htpasswd -nb techno password | openssl base64
```

Apply secret

```bash
kubectl apply -f secret-dashboard.yaml
```

Get secret

```bash
kubectl get secrets --namespace traefik
```

Apply middleware

```bash
kubectl apply -f middleware.yaml
```

Apply dashboard

```bash
kubectl apply -f ingress.yaml
```

Visit `https://traefik.local.example.com`

## Sample Workload

> These [resources](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik-cert-manager) are in the `launchpad/kubernetes/traefik-cert-manager/nginx/` folder
{: .prompt-info }

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

Or you can apply an entire folder at once!

```bash
kubectl apply -f nginx
```

## cert-manager

> These [resources](https://github.com/techno-tim/launchpad/tree/master/kubernetes/traefik-cert-manager) are in the `launchpad/kubernetes/traefik-cert-manager/cert-manager/` folder
{: .prompt-info }

Add repo

```bash
helm repo add jetstack https://charts.jetstack.io
```

Update it

```bash
helm repo update
```

Create our namespace

```bash
kubectl create namespace cert-manager
```

Get all namespaces

```bash
kubectl get namespaces
```

We should see

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

Apply crds

> *Note: Be sure to change this to the [latest version](https://cert-manager.io/docs/installation/supported-releases/) of `cert-manager`*
{: .prompt-info }

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml
```

Install with helm

```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --values=values.yaml --version v1.9.1
```

Apply secrets

> Be sure to generate the correct token if using Cloudflare.  This is using an [API Token](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/#api-tokens) and not a global key.
{: .prompt-info }

From `issuers` folder

```bash
kubectl apply -f secret-cf-token.yaml
```

Apply staging `ClusterIssuer`

From `issuers` folder

```bash
kubectl apply -f letsencrypt-staging.yaml
```

Create certs

### staging

From `certificates/staging` folder

```bash
kubectl apply -f local-example-com.yaml
```

Check the logs

```bash
kubectl logs -n cert-manager -f cert-manager-877fd747c-fjwhp
```

Get `challenges`

```bash
kubectl get challenges
```

Get more details

```bash
kubectl describe order local-technotim-live-frm2z-1836084675
```

### production

Apply production `ClusterIssuer`

From `issuers` folder

```bash
kubectl apply -f letsencrypt-production.yaml
```

From `certificates/production` folder

```bash
kubectl apply -f local-example-com.yaml
```

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
