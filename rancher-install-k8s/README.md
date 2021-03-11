# High Availability Rancher on kubernetes

[![Install Rancher on a Kubernetes Cluster](https://img.youtube.com/vi/APsZJbnluXg/0.jpg)](https://www.youtube.com/watch?v=APsZJbnluXg "Install Rancher on a Kubernetes Cluster")


Are you running Kubernetes in your homelab or in the enterprise?
Do you want an easy way to manage and create Kubernetes clusters?
Join me as we walk through installing Rancher on an existing high availability k3s cluster in this step-by-step tutorial.

We install Rancher, configure a load balancer, install and configure helm, install cert-manager, configure Rancher, walk through the GUI, scale up our cluster, and set up a health check and liveness check! Join me, it's easy in this straightforward guide.

https://www.youtube.com/watch?v=APsZJbnluXg


## install

**Note:** If you plan on installing Rancher in your cluster, the current stable release (v2.5.5) does not support Kubernetes v1.20.
It's advised you consult the [Rancher Support Matrix](https://rancher.com/support-maintenance-terms/all-supported-versions)
to get the recommended version for all Rancher dependencies.

https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-k8s/#1-install-the-required-cli-tools

`kubectl`

install `helm`

```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

add `helm` repo, `stable`

```
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```


create rancher namespace

```
kubectl create namespace cattle-system
```


ssl configuration

user rancher generated (default)


install `cert-manager`


```
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.crds.yaml
```

create name-space for `cert-manager`

```
kubectl create namespace cert-manager
```


Add the Jetstack Helm repository

 ```
 helm repo add jetstack https://charts.jetstack.io
 ```


update helm repo

```
helm repo update
```


install `cert-manager` helm chart


*Note: If you receive an "Error: Kubernetes cluster unreachable" message when installing cert-manager, try copying
the contents of "/etc/rancher/k3s/k3s.yaml" to "~/.kube/config" to resolve the issue.*
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.2.0
```

check rollout of cert-manager



```
kubectl get pods --namespace cert-manager
```

Be sure each pod is fully running before proceeding


Install Rancher with Helm

*Note:If you have ".local" for your private TLD then Rancher will NOT finish the setup within the webUI*
```
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com
```



check rollout


```
kubectl -n cattle-system rollout status deploy/rancher
```


you should see


```
Waiting for deployment "rancher" rollout to finish: 0 of 3 updated replicas are available...
Waiting for deployment "rancher" rollout to finish: 1 of 3 updated replicas are available...
Waiting for deployment "rancher" rollout to finish: 2 of 3 updated replicas are available...
deployment "rancher" successfully rolled out
```

check status

```
kubectl -n cattle-system rollout status deploy/rancher
```

you should see

```
deployment "rancher" successfully rolled out
```


## load balancer

If you are using `k3s` you can use the `traefik` ingress controller that ships with `k3s`

run

```
kubectl get svc --all-namespaces -o wide
```

look for


```
kube-system     traefik                LoadBalancer   10.43.202.72   192.168.100.10   80:32003/TCP,443:32532/TCP   5d23h   app=traefik,release=traefik
```

then create a DNS entry for `rancher.example.com    192.168.100.10`


otherwise you can use `nginx`

nginx lb

https://rancher.com/docs/rancher/v2.x/en/installation/resources/k8s-tutorials/infrastructure-tutorials/nginx/


## other considerations

Separating Rancher Cluster from your User Cluster


https://rancher.com/docs/rancher/v2.x/en/overview/architecture-recommendations/#separation-of-rancher-and-user-clusters
