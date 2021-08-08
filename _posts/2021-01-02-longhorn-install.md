---
layout: post
title: "Cloud Native Distributed Storage in Kubernetes with Longhorn"
date: 2021-01-02 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes longhorn k3s

---

[![Cloud Native Distributed Storage in Kubernetes with Longhorn](https://img.youtube.com/vi/eKBBHc0t7bc/0.jpg)](https://www.youtube.com/watch?v=eKBBHc0t7bc "Cloud Native Distributed Storage in Kubernetes with Longhorn")

Storage in Kubernetes is hard, complicated, and messy.  Configuring volumes, mounts, and persistent volumes claims and getting it right can be a challenge.  It's also challenging to manage that storage and replicate it across all your Kubernetes clusters.  It's also been very challenging to do this on bare metal, outside of a cloud provider.  That's where Longhorn comes.  Longhorn is an open source, a CNCF distributed block storage system for Kubernetes.  It comes with a UI, backups, snapshots, cluster disaster recovery, and it does all this with or without Rancher.  Rancher is NOT a requirement.

[Watch Video](https://www.youtube.com/watch?v=eKBBHc0t7bc)


## install

### Rancher app catalog

See the app catalog within Rancher

### additional dependencies

There are some additional dependencies you might want to install prior to configuring

```bash
sudo apt update
sudo apt install nfs-common open-iscsi
```

### kubectl


```bash
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml
```


```bash
kubectl get pods \
--namespace longhorn-system \
--watch
```

See more at [https://longhorn.io/docs/1.0.0/deploy/install/install-with-kubectl](https://longhorn.io/docs/1.0.0/deploy/install/install-with-kubectl)


### helm

helm3

```bash
kubectl create namespace longhorn-system
helm install longhorn ./longhorn/chart/ --namespace longhorn-system
```

```bash
kubectl -n longhorn-system get pod
```


## taints

I ended up tainting my storage nodes using this command

```bash
kubectl taint nodes luna-01 luna-02 luna-03 luna-04 CriticalAddonsOnly=true:NoExecute
kubectl taint nodes luna-01 luna-02 luna-03 luna-04 StorageOnly=true:NoExecute
```


Then applying that toleration to Lonhorn in settings

`StorageOnly=true:NoExecute;CriticalAddonsOnly=true:NoExecute`

This ensures that the storage nodes won't take on any general workloads and still allow Lonhorn to use these as storage.

