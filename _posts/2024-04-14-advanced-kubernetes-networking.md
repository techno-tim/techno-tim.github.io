---
layout: post
title: "Advanced Kubernetes Networking with Multus (It's easier than you think)"
date: 2024-04-14 08:00:00 -0500
categories: homelab
tags: multus kubernetes networking rke2 k3s cni cilium
image:
 path: /assets/img/headers/advanced-kubernetes-networking-hero.webp
 lqip: ddata:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP1/uPh1dah4cXzLy38+e8iuDcw3OpWtzHvjbakDxvLbRKheMp5llcBQJQwkd4poPDjQ/du8nU55SnLnk7cs425Yxs1Hl6Je69eZcz51hzwVF1JKdT2tOLjFuKjzSSteLjJqDho4KT97VOzaPG3/AGXtevXa8Xx9rUC3bNcrCviLWysKzkyiJT5IysYfYD6Cslgo2X7mjsvtf/cTnhS54QmsNg7TjGSvGztJJq69k7PXa7t3e5//2Q==
---

I just discovered Multus and it fixed Kubernetes networking!  In this video we cover a lot of Kubernetes networking topics from beginner topics like CNIs, to advanced topics like adding Multus for more traditional networking within Kubernetes - which fixes a lot of problems you see with Kubernetes networking.  Also, I had to turn the nerd up to 11 on this one.

{% include embed/youtube.html id='atfLTiW5yvM' %}
📺 [Watch Video](https://www.youtube.com/watch?v=atfLTiW5yvM)

- Be sure to check out and ⭐ the [Multus repo on GitHub](https://github.com/k8snetworkplumbingwg/multus-cni)!
- Network diagram created with Excalidraw <https://github.com/excalidraw/excalidraw>
- Much of the documentation and diagrams we walked through can be found on [DevOpsTales](https://devopstales.github.io/kubernetes/multus/)
- Huge thanks to the folks over in the [Home Operations Discord](https://discord.com/servers/home-operations-673534664354430999) too!
- Huge thanks to [Andy (@clemenko)](https://twitter.com/clemenko) for helping me troubleshoot and diagnose issues with Multus/RKE2/Cilium

Disclosures:

- Nothing in this video was sponsored

## Installing Multus

Multus can be installed a few different ways.  The best thing to do is check with your Kubernetes distribution if they support enabling this with configuration. If they do, this is much easier than installing it yourself

- [Installing Multus with K3s](https://docs.k3s.io/networking/multus-ipams)
- [Installing Multus on RKE2](https://docs.rke2.io/install/network_options)
- [Installing Multus without your distribution's help](https://github.com/k8snetworkplumbingwg/multus-cni/blob/master/docs/quickstart.md#installation)

Be sure to apply any additional config mentioned in the above links. This will most likely include configuration for your CNI to allow multus to plug into it.

Since I was using RKE2, I needed to apply this `HelmChartConfig` to configure Cilium to work with Multus

Do not apply this unless you are also using Cilium and RKE2/

```yaml
# /var/lib/rancher/rke2/server/manifests/rke2-cilium-config.yaml
---
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-cilium
  namespace: kube-system
spec:
  valuesContent: |-
    cni:
      exclusive: false
```

## Configuring Multus

First check to see that it's installed

```bash
kubectl get pods --all-namespaces | grep -i multus
```

You should see something similar to the output below.  This will vary depending on how you installed multus.

```bash
kube-system           rke2-multus-4kbbv                                       1/1     Running     0              30h
kube-system           rke2-multus-qbhrb                                       1/1     Running     0              30h
kube-system           rke2-multus-rmh9l                                       1/1     Running     0              30h
kube-system           rke2-multus-vbpr5                                       1/1     Running     0              30h
kube-system           rke2-multus-x4bpg                                       1/1     Running     0              30h
kube-system           rke2-multus-z22sq                                       1/1     Running     0              30h
```

We will need to create a `NetworkAttachmentDefinition`

```yaml
# network-attachment-definition.yaml
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: multus-iot
  namespace: default
spec:
  config: |-
    {
      "cniVersion": "0.3.1",
      "type": "ipvlan",
      "master": "eth1",
      "ipam": {
        "type": "static",
        "routes": [
          { "dst": "192.168.0.0/16", "gw": "192.168.20.1" }
        ]
      }
    }
```

Then apply this `NetworkAttachmentDefinition`

```bash
kubectl apply -f network-attachment-definition.yaml
```

Then check to see if it was created

```bash
kubectl get network-attachment-definitions.k8s.cni.cncf.io multus-iot
```

Should see something like:

```bash
NAME         AGE
multus-iot   30h
```

You can also describe it to see it contents

```bash
kubectl describe network-attachment-definitions.k8s.cni.cncf.io multus-iot
```

You should see something like:

```bash
Name:         multus-iot
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  k8s.cni.cncf.io/v1
Kind:         NetworkAttachmentDefinition
Metadata:
  Creation Timestamp:  2024-04-14T04:56:02Z
  Generation:          1
  Resource Version:    3215172
  UID:                 89b7f3d0-c094-4831-9b94-5ecdf6b38232
Spec:
  Config:  {
  "cniVersion": "0.3.1",
  "type": "ipvlan",
  "master": "eth1",
  "ipam": {
    "type": "static",
    "routes": [
      { "dst": "192.168.0.0/16", "gw": "192.168.20.1" }
    ]
  }
}
Events:  <none>
```

## Creating a Sample Workload

Let's create a sample pod and see if it gets our IP

```yaml
# sample-pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: sample-pod
  namespace: default
  annotations:
    k8s.v1.cni.cncf.io/networks: |
      [{
        "name": "multus-iot",
        "namespace": "default",
        "mac": "c6:5e:a4:8e:7a:59",
        "ips": ["192.168.20.202/24"]
      }]
spec:
  containers:
  - name: sample-pod
    command: ["/bin/ash", "-c", "trap : TERM INT; sleep infinity & wait"]
    image: alpine
```

Check to see if it's running

```yaml
kubectl get pod sample-pod
```

You should see something like:

```bash
NAME         READY   STATUS    RESTARTS   AGE
sample-pod   1/1     Running   0          30h
```

Now let's describe the pod to see if it got our IP

```bash
kubectl describe pod sample-pod
```

You should see something like:

```bash
➜  home-ops git:(master) k describe pod sample-pod
Name:             sample-pod
Namespace:        default
Priority:         0
Service Account:  default
Node:             k8s-home-worker-01/192.168.20.70
Start Time:       Sun, 14 Apr 2024 00:01:28 -0500
Labels:           <none>
Annotations:      k8s.v1.cni.cncf.io/network-status:
                    [{
                        "name": "portmap",
                        "interface": "eth0",
                        "ips": [
                            "10.42.4.89"
                        ],
                        "mac": "1a:af:f2:3f:32:f8",
                        "default": true,
                        "dns": {},
                        "gateway": [
                            "10.42.4.163"
                        ]
                    },{
                        "name": "default/multus-iot",
                        "interface": "net1",
                        "ips": [
                            "192.168.20.202"
                        ],
                        "mac": "bc:24:11:a0:4b:35",
                        "dns": {}
                    }]
                  k8s.v1.cni.cncf.io/networks:
                    [{
                      "name": "multus-iot",
                      "namespace": "default",
                      "mac": "c6:5e:a4:8e:7a:59",
                      "ips": ["192.168.20.202/24"]
                    }]
Status:           Running
IP:               10.42.4.89
IPs:
  IP:  10.42.4.89
Containers:
  sample-pod:
    Container ID:  containerd://fdd56e2fcdb3d587d792878285ef0fe50d076167d2b283dbf42aeb1b210d36cf
    Image:         alpine
    Image ID:      docker.io/library/alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/ash
      -c
      trap : TERM INT; sleep infinity & wait
    State:          Running
      Started:      Sun, 14 Apr 2024 00:01:29 -0500
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lggfv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-lggfv:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason          Age   From               Message
  ----    ------          ----  ----               -------
  Normal  Scheduled       8s    default-scheduler  Successfully assigned default/sample-pod to k8s-home-worker-01
  Normal  AddedInterface  7s    multus             Add eth0 [10.42.4.89/32] from portmap
  Normal  AddedInterface  7s    multus             Add net1 [192.168.20.202/24] from default/multus-iot
  Normal  Pulling         7s    kubelet            Pulling image "alpine"
  Normal  Pulled          7s    kubelet            Successfully pulled image "alpine" in 388.090289ms (388.099785ms including waiting)
  Normal  Created         7s    kubelet            Created container sample-pod
  Normal  Started         7s    kubelet            Started container sample-pod
```

You should see an adapter added to the pod as well as an IP:

```bash
...
Normal  AddedInterface  7s    multus             Add net1 [192.168.20.202/24] from default/multus-iot
...
```

### Testing the Workload

Be sure you can ping that new IP

```bash
➜  home-ops git:(master) ping 192.168.20.202
PING 192.168.20.202 (192.168.20.202): 56 data bytes
64 bytes from 192.168.20.202: icmp_seq=0 ttl=63 time=0.839 ms
64 bytes from 192.168.20.202: icmp_seq=1 ttl=63 time=0.876 ms
64 bytes from 192.168.20.202: icmp_seq=2 ttl=63 time=0.991 ms
64 bytes from 192.168.20.202: icmp_seq=3 ttl=63 time=0.812 ms
```

`exec` into the pod and test connectivity and DNS

```bash
kubectl exec -it pods/sample-pod -- /bin/sh
```

Once in ping your gateway, ping another device on the network, and ping something on the internet

```bash
/ # ping 192.168.20.1
PING 192.168.20.1 (192.168.20.1): 56 data bytes
64 bytes from 192.168.20.1: seq=0 ttl=64 time=0.318 ms
64 bytes from 192.168.20.1: seq=1 ttl=64 time=0.230 ms
64 bytes from 192.168.20.1: seq=2 ttl=64 time=0.531 ms
^C
--- 192.168.20.1 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.230/0.359/0.531 ms
/ # ping 192.168.20.52
PING 192.168.20.52 (192.168.20.52): 56 data bytes
64 bytes from 192.168.20.52: seq=0 ttl=255 time=88.498 ms
64 bytes from 192.168.20.52: seq=1 ttl=255 time=3.375 ms
64 bytes from 192.168.20.52: seq=2 ttl=255 time=25.688 ms
^C
--- 192.168.20.52 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 3.375/39.187/88.498 ms
/ # ping google.com
PING google.com (142.250.191.238): 56 data bytes
64 bytes from 142.250.191.238: seq=0 ttl=111 time=8.229 ms
64 bytes from 142.250.191.238: seq=1 ttl=111 time=8.578 ms
64 bytes from 142.250.191.238: seq=2 ttl=111 time=8.579 ms
^C
--- google.com ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 8.229/8.462/8.579 ms
/ #
```

Now test DNS by looking up something on the internet, something on your local network, and something inside of your cluster

```bash
/ # nslookup google.com
Server:  10.43.0.10
Address: 10.43.0.10:53

Non-authoritative answer:
Name: google.com
Address: 142.250.191.238

Non-authoritative answer:
Name: google.com
Address: 2607:f8b0:4009:81b::200e

/ # nslookup k8s-home-worker-01.local.techtronic.us
Server:  10.43.0.10
Address: 10.43.0.10:53

Name: k8s-home-worker-01.local.techtronic.us
Address: 192.168.60.53

Non-authoritative answer:

/ # nslookup homepage
Server:  10.43.0.10
Address: 10.43.0.10:53

** server can't find homepage.cluster.local: NXDOMAIN

** server can't find homepage.svc.cluster.local: NXDOMAIN

** server can't find homepage.cluster.local: NXDOMAIN

** server can't find homepage.svc.cluster.local: NXDOMAIN


Name: homepage.default.svc.cluster.local
Address: 10.43.143.7
```

If all of the tests passed, you should be good!

You can now do the same thing for your other workloads that need to use Multus!

## Gotchas

### RKE2

If you're using RKE2 and you notice that your worker nodes are using the wrong IP address after adding an additional NIC, you can override the Node IP with config:

```yaml
# /etc/rancher/rke2/config.yaml
node-ip: 192.168.60.53 # the node's primary IP used for kubernetes
node-external-ip: 192.168.60.53 # the node's primary IP used for kubernetes
```

You will need to restart the rke service or reboot.

Check with

```bash
kubectl get nodes -o wide
```

You should then see the IP on the node (note my `k8s-home-worker-01` has the fix, but `k8s-home-worker-02` and `k8s-home-worker-03` don't)

```bash
NAME                 STATUS   ROLES                       AGE   VERSION          INTERNAL-IP     EXTERNAL-IP     OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
k8s-home-01          Ready    control-plane,etcd,master   5d    v1.28.8+rke2r1   192.168.60.50   <none>          Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
k8s-home-02          Ready    control-plane,etcd,master   5d    v1.28.8+rke2r1   192.168.60.51   <none>          Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
k8s-home-03          Ready    control-plane,etcd,master   5d    v1.28.8+rke2r1   192.168.60.52   <none>          Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
k8s-home-worker-01   Ready    worker                      5d    v1.28.8+rke2r1   192.168.60.53   192.168.60.53   Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
k8s-home-worker-02   Ready    worker                      5d    v1.28.8+rke2r1   192.168.20.71   <none>          Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
k8s-home-worker-03   Ready    worker                      5d    v1.28.8+rke2r1   192.168.20.72   <none>          Ubuntu 22.04.4 LTS   5.15.0-102-generic   containerd://1.7.11-k3s2
```

You can see more flags on the [RKE2 documentation page](https://docs.rke2.io/reference/linux_agent_config)

### cloud-init and routing

I have also seen odd issues when with routing and using cloud init.  I've had to override some settings using `netplan`

You can see there is a misplaced route in your tables

```bash
➜  ~ ip route
192.168.20.0/24 dev eth1 proto kernel scope link src 192.168.20.72 metric 100
192.168.20.1 dev eth1 proto dhcp scope link src 192.168.20.72 metric 100
192.168.60.0/24 dev eth0 proto kernel scope link src 192.168.60.55 metric 100
192.168.60.1 dev eth0 proto dhcp scope link src 192.168.60.55 metric 100
192.168.60.10 via 192.168.20.1 dev eth1 proto dhcp src 192.168.20.72 metric 100 # wrong
192.168.60.10 dev eth0 proto dhcp scope link src 192.168.60.55 metric 100
192.168.60.22 via 192.168.20.1 dev eth1 proto dhcp src 192.168.20.72 metric 100 #wrong
192.168.60.22 dev eth0 proto dhcp scope link src 192.168.60.55 metric 100
```

To fix this, we need to override the routes with `netplan`

```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```

 ```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    version: 2
    ethernets:
        eth0:
            addresses:
            - 192.168.60.55/24
            match:
                macaddress: bc:24:11:f1:2a:e7
            nameservers:
                addresses:
                - 192.168.60.10
                - 192.168.60.22
            routes:
            -   to: default
                via: 192.168.60.1
            set-name: eth0
        eth1:
            addresses:
            - 192.168.20.65/24
            match:
                macaddress: bc:29:71:9a:01:29
            nameservers:
                addresses:
                - 192.168.60.10
                - 192.168.60.22
            routes:
            -   to: 192.168.20.0/24
                via: 192.168.20.1
            set-name: eth1
        eth2:
            addresses:
            - 192.168.40.52/24
            match:
                macaddress: bc:24:11:3d:c9:f7
            nameservers:
                addresses:
                - 192.168.60.10
                - 192.168.60.22
            routes:
            -   to: 192.168.40.0/24
                via: 192.168.40.1
            set-name: eth2
 ```

 If you know of a better way to do this, please let me know in the comments.

### k3s

You will have to make some changes for this to work with `k3s`. Thanks [ThePCGeek](https://github.com/ChrisThePCGeek)!

 ```yaml
 # k3s multus install
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: multus
  namespace: kube-system
spec:
  repo: https://rke2-charts.rancher.io
  chart: rke2-multus
  targetNamespace: kube-system
  # createNamespace: true
  valuesContent: |-
    config:
      cni_conf:
        confDir: /var/lib/rancher/k3s/agent/etc/cni/net.d
        clusterNetwork: /var/lib/rancher/k3s/agent/etc/cni/net.d/10-flannel.conflist
        binDir: /var/lib/rancher/k3s/data/current/bin/
        kubeconfig: /var/lib/rancher/k3s/agent/etc/cni/net.d/multus.d/multus.kubeconfig
 ```

### mac-vlan

I have also used this `mac-vlan` config below successfully

```yaml
---
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: multus-iot
  namespace: default
spec:
  config: |-
    {
      "cniVersion": "0.3.1",
      "name": "multus-iot",
      "plugins": [
        {
          "type": "macvlan",
          "master": "eth1",
          "mode": "bridge",
          "capabilities": {
            "ips": true
          },
          "ipam": {
            "type": "static",
            "routes": [{
              "dst": "192.168.0.0/16",
              "gw": "192.168.20.1"
            }]
          }
        }
      ]
    }
```

Sample Pods

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sample-pod
  namespace: default
  annotations:
    k8s.v1.cni.cncf.io/networks: |
      [{
        "name": "multus-iot",
        "namespace": "default",
        "mac": "c6:5e:a4:8e:7a:59",
        "ips": ["192.168.20.210/24"],
        "gateway": [ "192.168.20.1" ]
      }]
spec:
  containers:
  - name: sample-pod
    command: ["/bin/ash", "-c", "trap : TERM INT; sleep infinity & wait"]
    image: alpine
```

## Join the conversation

<blockquote class="twitter-tweet"  data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Today I released 40 minute, super niche technical video on advanced Kubernetes networking with Multus. <br><br>I didn&#39;t do it for the algorithm, I did it because I loved every minute of it. (Well, after I got it working)<a href="https://t.co/O7sLjDIMXt">https://t.co/O7sLjDIMXt</a> <a href="https://t.co/bBnBbmlsDx">pic.twitter.com/bBnBbmlsDx</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1779516238533627905?ref_src=twsrc%5Etfw">April 14, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
