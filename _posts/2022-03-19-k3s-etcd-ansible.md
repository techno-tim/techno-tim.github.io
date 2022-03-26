---
layout: post
title: "Fully Automated K3S etcd High Availability Install"
date: 2022-03-26 10:00:00 -0500
categories: kubernetes k3s
tags: k3s rancher etcd ansible cloud-image metallb kube-vip
---

[![Fully Automated K3S etcd High Availability Install](https://img.youtube.com/vi/CbkEWcUZ7zM/0.jpg)](https://www.youtube.com/watch?v=CbkEWcUZ7zM "Fully Automated K3S etcd High Availability Install")

Setting up k3s is hard.  That's why we made it easy.  Today we'll set up a High Availability K3s cluster using etcd, MetalLB, kube-vip, and Ansible.  We'll automated the entire process giving you an easy, repeatable way to create a k3s cluster that you can run in a few minutes.

A HUGE THANKS to our sponsor, Micro Center! 

New Customers Exclusive – Get a Free 240gb SSD at Micro Center: https://micro.center/1043bc

📺 [Watch Video](https://www.youtube.com/watch?v=CbkEWcUZ7zM)

## Prep

First, you'll need Ansible installed.  Here's an easy way to [install Ansible](https://docs.technotim.live/posts/ansible-automation/) and a video if you need.

Next, you'll need to fork and clone [the repo](https://github.com/techno-tim/k3s-ansible).  While you're at it, give it a ⭐ too :).

## Installing k3s

Next, you'll want to copy the `sample` directory within the `inventory` directory.

```bash
cp -R inventory/sample inventory/my-cluster
```

Next, edit the `inventory/hosts.ini` to match your systems.  DNS works here too.

```ini
[master]
192.168.30.38
192.168.30.39
192.168.30.40

[node]
192.168.30.41
192.168.30.42

[k3s_cluster:children]
master
node
```

Edit `inventory/group_vars/all.yml`  to your liking.  See comments inline.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/hosts.ini
```

After deployment control plane will be accessible via virtual ip address which is defined in `inventory/group_vars/all.yml` as `apiserver_endpoint`

## Removing

To remove k3s from the nodes

```bash
ansible-playbook reset.yml -i inventory/hosts.ini
```

## kube config
To get access to your Kubernetes cluster and copy your kube config locally run:

```
scp debian@master_ip:~/.kube/config ~/.kube/config
```

## Testing your cluster

Be sure you can ping your VIP defined in `inventory/group_vars/all.yml` as `apiserver_endpoint`

```bash
ping 192.168.30.222
```

Getting nodes

```bash
kubectl get nodes
```

Deploying a sample `nginx` workload

```bash
kubectl apply -f example/deployment.yml
```

Check to be sure it was deployed

```bash
kubectl describe deployment nginx
```


Deploying a sample `nginx` service with a `LoadBalancer`

```bash
kubectl apply -f example/service.yml
```


Check service and be sure it has an IP from metal lb as defined in `inventory/group_vars/all.yml`

```bash
kubectl describe service nginx
```

Visit that url or curl 

```bash
curl http://192.168.30.80
```

You should see the `nginx` welcome page.


You can clean this up by running

```bash
kubectl delete -f example/deployment.yml
kubectl delete -f example/service.yml
```


## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
