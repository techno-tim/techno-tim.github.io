---
layout: post
title: "Installing Grafana Loki with Helm on Kubernetes"
date: 2021-11-20 7:00:00 -0500
categories: kubernetes
tags: homelab proxmox grafana logging promtail prometheus kubernetes helm
---

In my previous video ([Meet Grafana LOKI, a log aggregation system for everything](https://www.youtube.com/watch?v=h_GGd7HfKQ8) and [post](https://docs.technotim.live/posts/grafana-loki/), I promised that I would also explain how to install Granfana Loki on Kubernetes using `helm`.  If you're looking to set this up in `docker-compose`, be sure to check out this [video](https://www.youtube.com/watch?v=h_GGd7HfKQ8)

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

Don't want to host it yourself?  Check out Grafana Cloud and sign up for a free account <https://l.technotim.live/grafana-labs>


## Installing helm

Think of `helm` as a package manager for kubernetes. It'a an easy way to bundle and deploy config to kubernetes with versioning.  If you need to install `helm` visit [helm.sh](https://helm.sh/docs/intro/install/)

## Installing Loki Stack

First add Loki's chart repository to `helm`

```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

Then update the chart repository

```bash
helm repo update
```

This command will:

* install grafana
* install prometheus
* install loki
* enable persistence for your stack and create a PVC

```bash
helm upgrade --install loki grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false,loki.persistence.enabled=true,loki.persistence.storageClassName=nfs-client,loki.persistence.size=5Gi
```

You'll want to set `loki.persistence.storageClassName=nfs-client` to your `StorageClass`  
In this example, I am using `nf-client` which is the [Kubernetes NFS Subdir External Provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)

## Accessing the Grafana Dashboard

To access your Grafana dashboard you can run

```bash
kubectl port-forward --namespace <YOUR-NAMESPACE> service/loki-grafana 3000:80
```

To get the password for the `admin` user run

```bash
kubectl get secret --namespace <YOUR-NAMESPACE> loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

This should print out your password

You can now access your dashboard on `http://localhost:3000`

## Ingress with Traefik

If you want to create an `IngressRoute` and you are using traefik can you apply the following

`ingress.yml`

```yml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: loki-grafana-ingress
  annotations: 
    kubernetes.io/ingress.class: traefik-internal # change with your value
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`grafana.example.com`) # change with your value
      kind: Rule
      services:
        - name: loki-grafana
          port: 80
```

```bash
kubectl apply -f ingress.yml
```

You should now be able to access your dashboard on `https://grafana.example.com`

## LogQL sample queries

Query all logs from the `container` label

```sql
{container="uptime-kuma"} 
```

query all logs from the `container` stream and filter on `error`

```sql
{container="uptime-kuma"} |= "error"

```

query all logs from the `pod` label of `uptime-kuma-8d45g32fd-lk8rl`

```sql
{pod="uptime-kuma-8d45g32fd-lk8rl"}

```

Read more about LogQL [here](https://grafana.com/docs/loki/latest/logql/)

## Upgrading Loki Stack

To upgrade, you run the same command you use to install it, with an updated chart

```bash
helm repo update
```

```bash
helm upgrade --install loki grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false,loki.persistence.enabled=true,loki.persistence.storageClassName=nfs-client,loki.persistence.size=5Gi
```


See all the hardware I recommend at <https://l.technotim.live/gear>
