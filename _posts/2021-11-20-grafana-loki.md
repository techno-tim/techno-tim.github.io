---
layout: post
title: "Meet Grafana LOKI, a Log Aggregation System for Everything"
date: 2021-11-20 8:00:00 -0500
categories: homelab
tags: homelab proxmox grafana logging promtail prometheus
image:
  path: /assets/img/headers/log-stack.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APnbS/GUd34l/s7RtIj8NeIdB1H4R2Ol+KdJmtoLmGX4m+AF+JH2+5tINNtv7TvtKs9aHg691DU7y71TXdIgmuf7R0q6vCIP51lgYYXBSqValTF0qkMdWdCs1KKjhcSqCpwnNVJ04uVONaEabhTpySj7Kooxt/QrzCWJxMKVGjRws6UsFRjWpRam3icK67nNQdOFSSjUlSqSqRlUqJuaq05SnzeO6N8SvBnibR9K8SS+A9Ygl8QabY63JDL4w0i7khk1W1iv3ikuj4AgNy8bXBR7gwwmZgZDFHu2DCvlmKpV61JY6FqdWpTVsNUStCbirL647Ky2u7dzShmWEqUKNR5e71KVObviIN3lBSd39U1d3v1P/9k=

---

I've been on a quest to find a new logging system.I've use quite a few in the past, some open source, some proprietary, and some home grown, but recently I've decided to switch.I've switched to Grafana Loki for all of my logs for all of my systems - this includes machines, devices, docker systems and hosts, and my all of my kubernetes clusters.If you're thinking of using Grafana and are also looking for a fast way to log all of your systems, join me as we discuss and configure Grafana Loki.

{% include embed/youtube.html id='h_GGd7HfKQ8' %}

📺 [Watch Video](https://www.youtube.com/watch?v=h_GGd7HfKQ8)

Don't want to host it yourself?  Check out Grafana Cloud and sign up for a free account <https://l.technotim.live/grafana-labs>


## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

If you're using Docker compose

```bash
mkdir grafana
mkdir loki
mkdir promtail
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
    # ports:
    #   - "1514:1514" # this is only needed if you are going to send syslogs
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

scrape_configs:

# local machine logs

- job_name: local
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
  
## docker logs

#- job_name: docker 
#  pipeline_stages:
#    - docker: {}
#  static_configs:
#    - labels:
#        job: docker
#        __path__: /var/lib/docker/containers/*/*-json.log

# syslog target

#- job_name: syslog
#  syslog:
#    listen_address: 0.0.0.0:1514 # make sure you also expose this port on the container
#    idle_timeout: 60s
#    label_structured_data: yes
#    labels:
#      job: "syslog"
#  relabel_configs:
#    - source_labels: ['__syslog_message_hostname']
#      target_label: 'host'
```

## Loki Docker Driver

Install docker plugin

```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Edit docker daemon config

```bash
sudo nano /etc/docker/daemon.json
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

Restart docker daemon.

```bash
 sudo systemctl restart docker
```

You will also need to recreate your containers after applying this setting *

## LogQL sample queries

Query all logs from the `varlogs` stream

```sql
{job="varlogs"} 
```

Query all logs from the `varlogs` stream and filter on  `docker`

```sql
{job="varlogs"}  |= "docker"

```

Query all logs from the `container_name` label of `uptime-kuma` and filter on `host` of `juno`

```sql
{container_name="uptime-kuma", host="juno"}

```

Read more about LogQL [here](https://grafana.com/docs/loki/latest/logql/)

## ARM CPU (Raspberry Pi)

There is a workaround for using this with ARM CPUs. Credit to [AndreiTelteu](https://github.com/AndreiTelteu) for finding this [in this discussion](https://github.com/techno-tim/techno-tim.github.io/discussions/97)

delete `/etc/docker/daemon.json`

Add the vector service to the docker-compose.yml file

```yml

    vector:
        image: timberio/vector:0.18.1-debian
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock
            - /home/serveradmin/docker_volumes/vector/vector-config.toml:/etc/vector/vector.toml:ro
        ports:
            - "8383:8383"
        restart: unless-stopped
        networks:
            - loki
```

Run this command

```bash
mkdir vector
cd vector
nano vector-config.toml
```

paste this config in the file:

```toml
[sources.docker-local]
  type = "docker_logs"
  docker_host = "/var/run/docker.sock"
  exclude_containers = []
 
  # Identify zero-width space as first line of a multiline block.
  multiline.condition_pattern = '^\x{200B}' # required
  multiline.mode = "halt_before" # required
  multiline.start_pattern = '^\x{200B}' # required
  multiline.timeout_ms = 1000 # required, milliseconds
 
[sinks.loki]
  # General
  type = "loki" # required
  inputs = ["docker*"] # required
  endpoint = "http://loki:3100" # required
  
  # Auth
  auth.strategy = "bearer" # required
  auth.token = "none" # required
  
  # Encoding
  encoding.codec = "json" # required
  
  # Healthcheck
  healthcheck.enabled = false # optional, default
  
  # Loki Labels
  labels.forwarder = 'vector'
  labels.host = '{{ host }}'
  labels.container_name = '{{ container_name }}'
  labels.compose_service = '{{ label.com\.docker\.compose\.service }}'
  labels.compose_project = '{{ label.com\.docker\.compose\.project }}'
  labels.source = '{{ stream }}'
  labels.category = 'dockerlogs'
```

Credits to this post for the config file: [grafana/loki#2361 (comment)](https://github.com/grafana/loki/issues/2361#issuecomment-826732810)

## Kubernetes Setup

If you're looking to set this up in kubernetes, see [this post](/posts/grafana-loki-kubernetes/)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
