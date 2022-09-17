---
layout: post
title: "Fully Automated K3S etcd High Availability Install"
date: 2022-03-26 10:00:00 -0500
categories: kubernetes k3s
tags: k3s rancher etcd ansible cloud-image metallb kube-vip
---

[![Fully Automated K3S etcd High Availability Install](https://img.youtube.com/vi/CbkEWcUZ7zM/0.jpg)](https://www.youtube.com/watch?v=CbkEWcUZ7zM "Fully Automated K3S etcd High Availability Install")

Setting up k3s is hard.  That's why we made it easy.  Today we'll set up a High Availability K3s cluster using etcd, MetalLB, kube-vip, and Ansible.  We'll automate the entire process giving you an easy, repeatable way to create a k3s cluster that you can run in a few minutes.

A HUGE THANKS to our sponsor, Micro Center!

New Customers Exclusive – Get a Free 240gb SSD at Micro Center: <https://micro.center/1043bc>

📺 [Watch Video](https://www.youtube.com/watch?v=CbkEWcUZ7zM)

## Prep

First, you'll need Ansible installed.  Here's an easy way to [install Ansible](https://docs.technotim.live/posts/ansible-automation/) and a video if you need.

Second, you'll need to provision the VMs. Here's an easy way to create [perfect Proxmox templates with cloud image and cloud init](https://docs.technotim.live/posts/cloud-init-cloud-image/) and a video if you need.

Next, you'll need to fork and clone [the repo](https://github.com/techno-tim/k3s-ansible).  While you're at it, give it a ⭐ too :).

```bash
git clone https://github.com/techno-tim/k3s-ansible
```

Next you'll need to install some requirements for `ansible`

```bash
ansible-galaxy install -r ./collections/requirements.yml
```

Next, you'll want to `cd` into the repo and copy the `sample` directory within the `inventory` directory.

(Be sure you're using the [latest template](https://github.com/techno-tim/k3s-ansible/blob/master/inventory/sample/group_vars/all.yml))

```bash
cp -R inventory/sample inventory/my-cluster
```

## Installing k3s

Next, edit the `inventory/my-cluster/hosts.ini` to match your systems.  DNS works here too.

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

Edit `inventory/my-cluster/group_vars/all.yml`  to your liking.  See comments inline.

It's best to start using these args, and optionally include `traefik` if you want it installed with `k3s` however I would recommend installing it later with `helm`

It's best to start ith the default values in the repo.

```yaml
extra_server_args: {{ extra_args }} --disable servicelb --disable traefik
extra_agent_args: {{ extra_args }}
```

I would not change these values unless you know what you are doing.  It will most likely not work for you but listing for posterity.

> *Note: These are for an advanced use case. There isn't a one size fits all setting for everyone and their needs, I would try using k3s with the above values before changing them.  This could have undesired effects like nodes going offline, pods jumping or being removed, etc... Using these args might come at the cost of stability Also, these will not work anymore without some modifications*  
{: .prompt-danger }

```yaml
extra_server_args: "--disable servicelb --disable traefik --write-kubeconfig-mode 644 --kube-apiserver-arg default-not-ready-toleration-seconds=30 --kube-apiserver-arg default-unreachable-toleration-seconds=30 --kube-controller-arg node-monitor-period=20s --kube-controller-arg node-monitor-grace-period=20s --kubelet-arg node-status-update-frequency=5s"
extra_agent_args: "--kubelet-arg node-status-update-frequency=5s"
```

Start provisioning of the cluster using the following command:

```bash
ansible-playbook ./site.yml -i ./inventory/my-cluster/hosts.ini
```

> *Note: note: add --ask-pass --ask-become-pass if you are using password SSH login.*
{: .prompt-info }

After deployment control plane will be accessible via virtual ip address which is defined in `inventory/my-cluster/group_vars/all.yml` as `apiserver_endpoint`

## kube config

To get access to your Kubernetes cluster and copy your kube config locally run:

```bash
scp ansibleuser@192.168.30.38:~/.kube/config ~/.kube/config
```

## Testing your cluster

Be sure you can ping your VIP defined in `inventory/my-cluster/group_vars/all.yml` as `apiserver_endpoint`

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

Check service and be sure it has an IP from metal lb as defined in `inventory/my-cluster/group_vars/all.yml`

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

## Resetting your cluster

This will remove k3s from all nodes.  These nodes should be rebooted afterwards.

```bash
ansible-playbook ./reset.yml -i ./inventory/my-cluster/hosts.ini
```

## What's next?

See here to get the steps for installing [traefik + let's encrypt](https://docs.technotim.live/posts/kube-traefik-cert-manager-le/)

See here for steps to deploy [rancher](https://docs.technotim.live/posts/rancher-ha-install/#install)

## Troubleshooting

Be sure to see [this post on](https://github.com/techno-tim/k3s-ansible/discussions/20) how to troubleshoot common problems

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
