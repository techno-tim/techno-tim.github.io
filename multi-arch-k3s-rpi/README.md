# Multi-CPU Architecture Kubernetes Cluster with a Raspberry Pi

[![Multi-CPU Architecture Kubernetes Cluster with a Raspberry Pi](https://img.youtube.com/vi/_xykXkNia-Y/0.jpg)](https://www.youtube.com/watch?v=_xykXkNia-Y "Multi-CPU Architecture Kubernetes Cluster with a Raspberry Pi")

https://www.youtube.com/watch?v=_xykXkNia-Y


Building a Multi-architecture CPU Kubernetes cluster is easier than you think with `k3s`.  In this video we'll build a Raspberry Pi 4 with an ARM CPU and add it to our existing x86 x64 amd64 CPU Kubernetes cluster.  Our foundation will be Ubuntu for ARM, then we'll add `k3s`, and then join it to our cluster.  We'll also discuss how this works with Docker images built for specific CPU types.  We'll also talk about some build configurations and requirements for your Pi.

Happy Pi Day!


## Examples

check `k3s` version

```
k3s --version
```


get `k3s` token from a server

```
sudo cat /var/lib/rancher/k3s/server/node-token
```

set `k3s` version (the value you got from `k3s --version`)

```
 export INSTALL_K3S_VERSION=v1.19.5+k3s2
```


install `k3s` as an agent using your token from above


```
curl -sfL https://get.k3s.io | K3S_URL=https://example.local.com:6443 K3S_TOKEN=hksadhahdklahkadjhasjdhasdhasjk::server:asljkdklasjdaskdljaskjdlasj sh -
```


check all `k3s` nodes from your workstation

```
kubectl get nodes
```


get all pods running on a specific node (`elio`)

```
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=elio
```


set a label on a node (`elio`)

```
kubectl label nodes elio cputype=arm
```

describe a node (`elio`)

```
kubectl describe node elio
```

Example pod spec

`nginx-pod.yml`

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    cputype: arm64
```