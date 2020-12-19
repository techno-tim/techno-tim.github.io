# Rancher on kubernetes

[![Install Rancher on a Kubernetes Cluster](http://img.youtube.com/vi/APsZJbnluXg/0.jpg)](https://www.youtube.com/watch?v=APsZJbnluXg "Install Rancher on a Kubernetes Cluster")


Are you running Kubernetes in your homelab or in the enterprise?  Do you want an easy way to manage and create Kubernetes clusters?  Join me as we walk through stalling Rancher on an existing high availability k3s cluster in this step-by-step tutorial.  We install Rancher, configure a load balancer, install and configure helm, install cert-manager, configure Rancher, walk through the GUI, scale up our cluster, and set up a health check and liveness check!   Join me, it's easy in this straightforward guide.

https://www.youtube.com/watch?v=APsZJbnluXg



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
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
```

create name-space for `cert-manager`

```
kubectl create namespace cert-manager
```


Add the Jetstack Helm repository

 ```
 helm repo add jetstack https://charts.jetstack.io
 ```


upddate helm repo

```
helm repo update
```


install `cert-manager` helm chart


```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4
```


install rancher with helm


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


nginx lb

https://rancher.com/docs/rancher/v2.x/en/installation/resources/k8s-tutorials/infrastructure-tutorials/nginx/
