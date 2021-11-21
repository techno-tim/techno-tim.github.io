---
layout: post
title: "Meet Grafana LOKI, a Log Aggregation System for Everything"
date: 2021-11-20 8:00:00 -0500
categories: homelab
tags: homelab proxmox grafana logging promtail prometheus
---

[![Meet Grafana LOKI, a Log Aggregation System for Everything](https://img.youtube.com/vi/h_GGd7HfKQ8/0.jpg)](https://www.youtube.com/watch?v=h_GGd7HfKQ8 "Meet Grafana LOKI, a Log Aggregation System for Everything")

I've been on a quest to find a new logging system.  I've use quite a few in the past, some open source, some proprietary, and some home grown, but recently I've decided to switch.  I've switched to Grafana Loki for all of my logs for all of my systems - this includes machines, devices, docker systems and hosts, and my all of my kubernetes clusters.  If you're thinking of using Grafana and are also looking for a fast way to log all of your systems, join me as we discuss and configure Grafana Loki.

[Watch Video](https://www.youtube.com/watch?v=h_GGd7HfKQ8)

(see video description for links to gear, discord, and other ways to connect.)

## Docker Setup

See [this post](https://techno-tim.github.io/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

If you're using Docker compose

```bash
mkdir grafana
cd ..
mkdir loki
cd ..
mkdir promtail
cd ..
touch docker-compose.yml
nano docker-compose.yml # copy the contents from below
ls
docker-compose up -d --force-recreate # be sure you've created promtail-config.yml and loki-config.yml before running this
```

`docker-compose.yml`

```yml
version: "3"
networks:
  loki:
services:
  loki:
    image: grafana/loki:2.4.0
    volumes:
      - /home/serveradmin/docker_volumes/loki:/etc/loki
    ports:
      - "3100:3100"
    restart: unless-stopped
    command: -config.file=/etc/loki/loki-config.yml
    networks:
      - loki
  promtail:
    image: grafana/promtail:2.4.0
    volumes:
      - /var/log:/var/log
      - /home/serveradmin/docker_volumes/promtail:/etc/promtail
    restart: unless-stopped
    command: -config.file=/etc/promtail/promtail-config.yml
    networks:
      - loki
  grafana:
    image: grafana/grafana:latest
    user: "1000"
    volumes:
    - /home/serveradmin/docker_volumes/grafana:/var/lib/grafana
    ports:
      - "3000:3000"
    restart: unless-stopped
    networks:
      - loki
```

## Loki Config

```bash
nano loki/loki-config.yml
```

`loki-config.yml`

```yml
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

ruler:
  alertmanager_url: http://localhost:9093
```

## Promtail Config

```bash
nano promtail/promtail-config.yml
```

`promtail-config.yml`

```yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

# local machine logs

scrape_configs:
- job_name: local
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
  
## docker logs

# scrape_configs:
#   - job_name: docker 
#     pipeline_stages:
#       - docker: {}
#     static_configs:
#       - labels:
#           job: docker
#           __path__: /var/lib/docker/containers/*/*-json.log

## syslog target

# scrape_configs:
#   - job_name: syslog
#     syslog:
#       listen_address: 0.0.0.0:1514
#       idle_timeout: 60s
#       label_structured_data: yes
#       labels:
#         job: "syslog"
#     relabel_configs:
#       - source_labels: ['__syslog_message_hostname']
#         target_label: 'host'
```

## Loki Docker Driver

Install docker plugin

```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

edit docker daemon config

```bash
sudo nano /etc/daemon.json
```

`daemon.json`

```json
{
    "log-driver": "loki",
    "log-opts": {
        "loki-url": "http://localhost:3100/loki/api/v1/push",
        "loki-batch-size": "400"
    }
}
```

```bash
 sudo systemctl restart docker
```

## LogQL sample queries

Query all logs from the `varlogs` stream

```sql
{job="varlogs"} 
```

query all logs from the `varlogs` stream and filter on  `docker`

```sql
{job="varlogs"}  |= "docker"

```

query all logs from the `container_name` label of `uptime-kuma` and filter on `host` of `juno`

```sql
{container_name="uptime-kuma", host="juno"}

```

Read more about LogQL [here](https://grafana.com/docs/loki/latest/logql/)

## Kubernetes Setup

If you're looking to set this up in kubernetes, see [this post](https://techno-tim.github.io/posts/grafana-loki-kubernetes/)