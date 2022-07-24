---
layout: post
title: "HIGH AVAILABILITY k3s (Kubernetes) in minutes!"
date: 2020-12-19 09:00:00 -0500
categories: kubernetes k3s
tags: homelab rancher kubernetes k3s mysql nginx

---

[![HIGH AVAILABILITY k3s (Kubernetes) in minutes!](https://img.youtube.com/vi/UoOcLXfa8EU/0.jpg)](https://www.youtube.com/watch?v=UoOcLXfa8EU "HIGH AVAILABILITY k3s (Kubernetes) in minutes!")

Are you running Kubernetes in your homelab or in the enterprise?  Do you want an easy way to manage and create Kubernetes clusters? Do you want high availability Rancher? Join me as we walk through stalling Rancher on an existing high availability k3s cluster in this step-by-step tutorial.  We install Rancher, configure a load balancer, install and configure helm, install cert-manager, configure Rancher, walk through the GUI, scale up our cluster, and set up a health check and liveness check!  Join me, it's easy in this straightforward guide.

[Watch Video](https://www.youtube.com/watch?v=UoOcLXfa8EU)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## Load Balancer

Create a load balancer using `nginx`

`nginx.conf`

```conf
#uncomment this next line if you are NOT running nginx in docker
#load_module /usr/lib/nginx/modules/ngx_stream_module.so;

events {}

stream {
  upstream k3s_servers {
    server 192.168.60.20:6443;
    server 192.168.60.21:6443;
  }

  server {
    listen 6443;
    proxy_pass k3s_servers;
  }
}
```

## k3s servers

On your k3s servers

```bash
export K3S_DATASTORE_ENDPOINT='mysql://username:password@tcp(database_ip_or_hostname:port)/database'
```

*Note: It's advised you consult the [Rancher Support Matrix](https://rancher.com/support-maintenance-terms/all-supported-versions)
to get the recommended version for all Rancher dependencies.*

then

```bash
curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san load_balancer_ip_or_hostname
```

test with

```bash
sudo k3s kubectl get nodes
```

to add additional servers, get token from first server

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

then run the same command but add the token (replace SECRET with token from previous command)

```bash
curl -sfL https://get.k3s.io | sh -s - server --token=SECRET --node-taint CriticalAddonsOnly=true:NoExecute --tls-san load_balancer_ip_or_hostname
```

on agents / workers

to run without `sudo`

```bash
sudo chmod 644 /etc/rancher/k3s/k3s.yaml` on the servers
```

get token

```bash
sudo cat /var/lib/rancher/k3s/server/node-token
```

## k3s agents / workers

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://load_balancer_ip_or_hostname:6443 K3S_TOKEN=mynodetoken sh -
```

## other

To install `kubectl` [see this link](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

`kubeconfig` location on server

`/etc/rancher/k3s/k3s.yaml`

```bash
sudo cat /etc/rancher/k3s/k3s.yaml
```

copy contents to your dev machine

`~/.kube/config`

Be sure to update the `server:` to your load balancer ip or hostname

## kubernetes dashboard

check [releases](https://github.com/kubernetes/dashboard/releases) for the command to use. At time or filming it's:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml
```

### Dashboard RBAC Configuration

`dashboard.admin-user.yml`

```yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
```

`dashboard.admin-user-role.yml`

```yml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```

Deploy the `admin-user` configuration:

(if you're doing this from your dev machine, remove `sudo k3s` and just use `kubectl`)

```bash
sudo k3s kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml
```

get bearer token

```bash
sudo k3s kubectl -n kubernetes-dashboard create token admin-user
```

start dashboard locally

```bash
sudo k3s kubectl proxy
```

Then you can sign in at this URL using your token we got in the previous step:

`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/`

here's `testdeploy.yml` you can use

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysite
  labels: 
    app: mysite
spec:
  replicas: 1
  selector: 
    matchLabels:
      app: mysite
  template:
    metadata:
      labels: 
        app : mysite
    spec:
      containers:
        - name : mysite
          image: nginx
          ports:
            - containerPort: 80
```
