# Portainer 2.0 -- Now with more Kubernetes!

[![Portainer 2.0 -- Now with more Kubernetes!](http://img.youtube.com/vi/jzhd6tcjvw0/0.jpg)](http://www.youtube.com/watch?v=jzhd6tcjvw0 "Portainer 2.0 -- Now with more Kubernetes!")


What's new in Portainer 2.0?  Well, a ton.  With the release of Portainer 2 you now have the option to install Kubernetes.  This makes installing, managing, and deploying Kubenetes really easy.  In this step by step tutorial, we'll start with nothing and end up with a fully working Portainer 2 server running Kubernetes.  We'll set up k3s using k3d, install kubectl, and then spin up Portainer.  As an added bonus, we'll also run a Minecraft server in Kubernetes as a proof of work.  Double bonus, we'll cover how to pronounce kubectl...



## Let's get started

Here are the commands used in the video.  Be sure to use them appropriately.


### Install ubuntu

https://ubuntu.com/


### Install Docker 

https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

```
$ sudo apt-get update

$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```


```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```
$ sudo apt-key fingerprint 0EBFCD88

pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

```
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

```
 $ sudo apt-get update
 $ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

```
sudo usermode -aG docker $USER
```

```
logout
```


### Install kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/

```
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
```

```
chmod +x ./kubectl
```

```
sudo mv ./kubectl /usr/local/bin/kubectl
```

```
kubectl version --client
```

### Install k3d

https://github.com/rancher/k3d

```
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
```


### Install k3s

`bash` 
```
k3d cluster create portainer --api-port 6443 --servers 1 --agents 1 -p 30000-32767:30000-32767@server[0]
```

`zsh`
```
k3d cluster create portainer --api-port 6443 --servers 1 --agents 1 -p "30000-32767:30000-32767@server[0]"
```


### Install Portainer

https://github.com/portainer/portainer-k8s

```
curl -LO https://raw.githubusercontent.com/portainer/portainer-k8s/master/portainer.yaml
kubectl apply -f portainer.yaml
```

```
curl -LO https://raw.githubusercontent.com/portainer/portainer-k8s/master/portainer-nodeport.yaml
kubectl apply -f portainer-nodeport.yaml
```