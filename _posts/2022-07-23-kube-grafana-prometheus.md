---
layout: post
title: "Beautiful Dashboards with Grafana and Prometheus - Monitoring Kubernetes Tutorial"
date: 2022-07-23 10:00:00 -0500
categories: kubernetes
tags: kubernetes grafana prometheus alert-manager k3s
---

[![Beautiful Dashboards & Monitoring - Grafana and Prometheus Kubernetes Tutorial](https://img.youtube.com/vi/fzny5uUaAeY/0.jpg)](https://www.youtube.com/watch?v=fzny5uUaAeY "Beautiful Dashboards & Monitoring - Grafana and Prometheus Kubernetes Tutorial")

Grafana and Prometheus are a powerful monitoring solution.  It allows you to visualize, query, and alert metrics no matter where they are stored.  Today, we'll install and configure Prometheus and Grafana in Kubernetes using kube-prometheus-stack. By the end of this tutorial you be able to observe and visualize your entire Kubernetes cluster with Grafana and Prometheus.

📺 [Watch Video](https://www.youtube.com/watch?v=fzny5uUaAeY)

A HUGE thanks to Datree for sponsoring this video!

Combat misconfigurations. Empower engineers.

<https://www.datree.io>

## Getting Started

If you need to install a new kubernetes cluster you can use my [Ansible Playbook](https://docs.technotim.live/posts/k3s-etcd-ansible/) to install one.

### k3s

If you want to get metrics from your k3s servers, you will need to provide some additional flags to k3s.  

Additional k3s flags used in the video:

```yml
extra_server_args: "--no-deploy servicelb --no-deploy traefik --kube-controller-manager-arg bind-address=0.0.0.0 --kube-proxy-arg metrics-bind-address=0.0.0.0 --kube-scheduler-arg bind-address=0.0.0.0 --etcd-expose-metrics true --kubelet-arg containerd=/run/k3s/containerd/containerd.sock"
```

### helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

Install helm

The helm chart we will be using to install Grafana, Preometheus, and Alert Manager is [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)

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

Add helm repo

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

Update repo

```bash
helm repo update

```

Create a Kubernetes Namespace

```bash
kubectl create namespace monitoring
```

Echo username and password to a file

```bash
echo -n 'adminuser' > ./admin-user # change your username
echo -n 'p@ssword!' > ./admin-password # change your password
```

Create a Kubernetes Secret

```bash
 kubectl create secret generic grafana-admin-credentials --from-file=./admin-user --from-file=admin-password -n monitoring
```

You should see

```console
secret/grafana-admin-credentials created
```

Verify your secret

```bash
kubectl describe secret -n monitoring grafana-admin-credentials
```

You should see

```console
Name:         grafana-admin-credentials
Namespace:    monitoring
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
admin-password:  9 bytes
admin-user:      9 bytes
```

Verify the username

```bash
kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath="{.data.admin-user}" | base64 --decode
```

You should see

```console
adminuser%
```

Verify password

```bash
kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath="{.data.admin-password}" | base64 --decode
```

```console
p@ssword!%
```

Remove username and password file from filesystem

```bash
rm admin-user && rm admin-password
```

Create a values file to hold our helm values

```bash
nano values.yaml
```

paste in values from [here](https://github.com/techno-tim/launchpad/tree/master/kubernetes/kube-prometheus-stack)

Create our kube-prometheus-stack

```bash
helm install -n monitoring prometheus prometheus-community/kube-prometheus-stack -f values.yaml
```

Port Forwarding Grafana UI

(be sure to change the pod name to one that matches yours)

```bash
kubectl port-forward -n monitoring grafana-fcc55c57f-fhjfr 52222:3000
```

Visit Grafana

<http://localhost:52222>

If you make changes to your `values.yaml` you can deploy these changes by running

```bash
helm upgrade -n monitoring prometheus prometheus-community/kube-prometheus-stack -f values.yaml
```

Examples:

[Traefik Ingress example](https://github.com/techno-tim/launchpad/tree/master/kubernetes/kube-prometheus-stack)

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
