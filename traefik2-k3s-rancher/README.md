# Traefik 2, k3s, Rancher

## About
No video currently exists for this (yet)

This guide is for installing `traefik 2` on `k3s`

It assumes you have followed:

* [HIGH AVAILABILITY k3s (Kubernetes) in minutes!](https://www.youtube.com/watch?v=UoOcLXfa8EU)

* [High Availability Rancher on a Kubernetes Cluster](https://www.youtube.com/watch?v=APsZJbnluXg)



There is a little bit of "undoing" we'll have to do since k3s ships with `traefik` and Rancher doesn't play well with service load balancer. So, we'll pick up after instaling these two.


## Reconfigure Rancher

Make note of your version of Rancher

Remove Rancher

```
helm uninstall rancher
```

Install Rancher

(replace with version above)

```
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com \
  --version 2.5.6
```


## Reconfiguring k3s

Get the version of `k3s` that's currently running

```
k3s --version
k3s version v1.19.5+k3s2 (746cf403)
```

Run the same command you ran initially to install `k3s` on your servers but add `--disable traefik --disable servicelb` and be sure to set your version.

example

```
export INSTALL_K3S_VERSION=v1.19.5+k3s2
```
```
curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san your.load.balancer.ip --write-kubeconfig-mode 644 --disable traefik --disable servicelb
```

This should reconfigure your servers.  I ran it on all servers in my cluster.

## Install Metal LB

[Metal LB installation](https://metallb.universe.tf/installation/)


## Exposing Rancher directly to your Metal LB 

It's a good idea to do this until traefik is configured otherwise you won't have access to the Rancher Ui

```
kubectl expose deployment rancher -n cattle-system --type=LoadBalancer --name=rancher-lb --port=443
```

## Install Traefik 2

* You must have a persistent volume set up already for `acme.json` certificate
* This uses cloudflare, check providers if you want to switch
* This will get wildcard certs
* This is pointed at staging, if you want production be sure comment staging the line (and delete your staging certs)


We will be installing this into the `kube-system` namespace, which already exists.  If you are going to use anther namespace you will need change it everywhere.

add `traefik` helm repo and update

```
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
```

create `traefik-config.yaml` with the contents from `/config/traefik-config.yaml`

this holds our cloudflare secrets along with a configmap

update this file with your values

apply the config

```
kubectl apply -f traefik-config.yaml
```

create `traefik-chart-values.yaml` with the contents from `/config/traefik-config.yaml`

Update `loadBalancerIP` in `traefik-chart-values.yaml` with your Metal LB IP


Before running this, be sure you only have one default storage class set.  If you are using Rancher it is Cluster>Storage>Storage Classes.  Make sure only one is default.


create config then update the values

```
kubectl apply -f traefik-config.yaml
```

```
helm install traefik traefik/traefik --namespace=kube-system --values=traefik-chart-values.yaml
```

If all went well, you should now have traefik 2 installed and configured.


## Exposing a service with traefik

In Rancher go to Load Balancing

* create ingress
* choose a host name (service.example.com)
* choose a target (your workload)
* set the port to the exposed port within the container
* go to labels and annotations and add `kubernetes.io/ingress.class` = `traefik-external`
* note, `traefik-external` comes from `--providers.kubernetesingress.ingressclass=traefik-external` in `traefik-chart-values.yml`.  If you used something else, you will need to set your label properly.
* when you visit your website (`https://service.example.com`) you should now see a certificate issues.  If it's a staging cert, see the note about switching to production in `traefik-chart-values.yaml`.  After changing, you will need to delete your certs in storage and reapply that file

```
kubectl delete -n kube-system persistentvolumeclaims acme-json-certs
kubectl apply -f traefik-config.yaml
```

## Putting Rancher behind Traefik 2

TBD