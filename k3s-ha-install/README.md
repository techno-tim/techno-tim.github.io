# k3s HA Install


[![k3s HA Install](https://img.youtube.com/vi/UoOcLXfa8EU/0.jpg)](https://www.youtube.com/watch?v=UoOcLXfa8EU "k3s HA Install")

https://www.youtube.com/watch?v=UoOcLXfa8EU



## Load Balancer

Create a load balancer using `nginx`

`nginx.conf`

```
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

`export K3S_DATASTORE_ENDPOINT='mysql://username:password@tcp(database_ip_or_hostname:port)/database'`

If you plan on installing rancher in this cluser, the current stabe release (v2.5.5) does not support K3S v1.20. To prevent
issues when installing rancher, be sure to include the following:

`export INSTALL_K3S_VERSION=v1.19.7+k3s1`

then 

```
curl -sfL https://get.k3s.io | sh -s - server --node-taint CriticalAddonsOnly=true:NoExecute --tls-san load_balancer_ip_or_hostname
```

test with 

`sudo k3s kubectl get nodes`


on agents / workers

to run without `sudo`

`sudo chmod 644 /etc/rancher/k3s/k3s.yaml` on the servers

get tokens

`sudo cat /var/lib/rancher/k3s/server/node-token`



## k3s agents / workers

`curl -sfL https://get.k3s.io | K3S_URL=https://load_balancer_ip_or_hostname:6443 K3S_TOKEN=mynodetoken sh -`



## other

To install `kubectl` [see this link](https://kubernetes.io/docs/tasks/tools/install-kubectl/)


`kubeconfig` location on server

`/etc/rancher/k3s/k3s.yaml`

`sudo cat /etc/rancher/k3s/k3s.yaml`


copy contents to your dev machine

`~/.kube/config`


Be sure to update the `server:` to your load balancer ip or hostname


## kubernetes dashboard

check [releases](https://github.com/kubernetes/dashboard/releases) for the command to use. At time or filming it's: 

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml`


### Dashboard RBAC Configuration

`dashboard.admin-user.yml`

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
```


`dashboard.admin-user-role.yml`

```
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

`sudo k3s kubectl create -f dashboard.admin-user.yml -f dashboard.admin-user-role.yml`

get bearer token

`sudo k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token`

start dashboard locally

`sudo k3s kubectl proxy`

Then you can sign in at this URL using your token we got in the previous step:

`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/`

