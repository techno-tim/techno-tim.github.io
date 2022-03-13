---
layout: post
title: "Meet keepalived - High Availability and Load Balancing in One"
date: 2021-12-11 8:00:00 -0500
categories: homelab
tags: homelab keepalived self-hosted linux ubuntu
---

[![Meet keepalived - High Availability and Load Balancing in One](https://img.youtube.com/vi/hPfk0qd4xEY/0.jpg)](https://www.youtube.com/watch?v=hPfk0qd4xEY "Meet keepalived - High Availability and Load Balancing in One")

In my quest to make my services highly available I decided to use keepalived.  keepalived is a framework for both load balancing and high availability that implements VRRP.  This is a protocol that you see on some routers and has been implemented in keepalived. It creates a Virtual IP (or VIP, or floating IP) that acts as a gateway to route traffic to all participating hosts.  This VIP that can provide a high availability setup and fail over to another host in the event that one is down. In this video, we'll set up and configure keepalived, we'll test our configuration to make sure it's working, and we'll also talk about some advanced use cases like load balancing.

[Watch Video](https://www.youtube.com/watch?v=hPfk0qd4xEY)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## Installation

```bash
sudo apt update
sudo apt install keepalived
sudo apt install libipset13
```

## Configuration

Find your IP

```bash
ip a 
```

edit your config

```bash
sudo nano /etc/keepalived/keepalived.conf
```

First node

```apacheconf
vrrp_instance VI_1 {
  state MASTER
  interface ens18
  virtual_router_id 55
  priority 150
  advert_int 1
  unicast_src_ip 192.168.30.31
  unicast_peer {
    192.168.30.32
  }

  authentication {
    auth_type PASS
    auth_pass C3P9K9gc
  }

  virtual_ipaddress {
    192.168.30.100/24
  }
}
```

Second node

```apacheconf
vrrp_instance VI_1 {
  state BACKUP
  interface ens18
  virtual_router_id 55
  priority 100
  advert_int 1
  unicast_src_ip 192.168.30.32
  unicast_peer {
    192.168.30.31
  }

  authentication {
    auth_type PASS
    auth_pass C3P9K9gc
  }

  virtual_ipaddress {
    192.168.30.100/24
  }
}
```

Start and enable the service

```bash
sudo systemctl enable --now keepalived.service
```

stopping the service

```bash
sudo systemctl stop keepalived.service
```

get the status

```bash
sudo systemctl status keepalived.service
```

## nginx example

create `index.html` to mount

```bash
nano /home/user/docker_volumes/nginx/index.html
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Hello From Primary Node</title>
    <style>
        h1{
            font-weight:lighter;
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</head>
<body>

    <h1>
        Hello World 1
    </h1>

</body>
</html>
```

install nginx via docker

```bash
docker run --name some-nginx -v /home/user/docker_volumes/nginx:/usr/share/nginx/html:ro -d -p 8080:80 nginx
```

visit your VIP on port `8080`

## PiHole

In this video we covered the PiHole use case.  After setting this up, be sure to check out the tutorial on Gravity Sync

[https://docs.technotim.live/posts/ha-pi-hold-gravity-sync/](https://docs.technotim.live/posts/ha-pi-hold-gravity-sync/)
