---
layout: post
title: "Open Source & Collaborative Security with CrowdSec and Traefik - CrowdSec & Traefik Tutorial"
date: 2022-02-12 8:00:00 -0500
categories: homelab
tags: homelab hardware security self-hosted crowdsec traefik fail2ban
---

[![Open Source & Collaborative Security with CrowdSec and Traefik - CrowdSec & Traefik Tutorial](https://img.youtube.com/vi/-GxUP6bNxF0/0.jpg)](https://www.youtube.com/watch?v=-GxUP6bNxF0 "Open Source & Collaborative Security with CrowdSec and Traefik - CrowdSec & Traefik Tutorial")

A HUGE THANK YOU to Micro Center for sponsoring this video!

New Customers Exclusive – Get a Free 240gb SSD at Micro Center: <https://micro.center/1fbb85>

[Watch Video](https://www.youtube.com/watch?v=-GxUP6bNxF0)

See all the hardware I recommend at <https://l.technotim.live/gear>

## Intro

[CrowdSec](https://crowdsec.net/) is a free, open-source and collaborative IPS. Analyze behaviors, respond to attacks & share signals across the community.  With CrowdSec, you can set up your own intrusion detection system that parses logs, detects and blocks threats, and shares bad actors with the larger CrowdSec community.  It works great with a reverse proxy like [traefik](https://traefik.io/) to help keep hackers at bay.  Could this be a viable alternative to fail2ban?

A HUGE THANK YOU to Micro Center for sponsoring this video!

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

If you need to set up traefik, you can follow this post here on [configuring traefik](https://docs.technotim.live/posts/traefik-portainer-ssl/)

If you need a high level overview of HomeLab and Self-Hosting Security, check out [this video](https://www.youtube.com/watch?v=Cs8yOmTJNYQ) that will help you keep your network safe.

## Configure CrowdSec

traefik bouncer repo
<https://github.com/fbonalair/traefik-crowdsec-bouncer>

```bash
mkdir crowdsec
cd crowdsec
touch docker-compose.yml
nano docker-compose.yml
```

```yml
version: '3.8'
services:
  crowdsec:
    image: crowdsecurity/crowdsec:latest
    container_name: crowdsec
    environment:
      GID: "${GID-1000}"
      COLLECTIONS: "crowdsecurity/linux crowdsecurity/traefik"
    # depends_on:  #uncomment if running traefik in the same compose file
    #   - 'traefik'
    volumes:
      - ./config/acquis.yaml:/etc/crowdsec/acquis.yaml
      - crowdsec-db:/var/lib/crowdsec/data/
      - crowdsec-config:/etc/crowdsec/
      - traefik_traefik-logs:/var/log/traefik/:ro
    networks:
      - proxy
    restart: unless-stopped

  bouncer-traefik:
    image: docker.io/fbonalair/traefik-crowdsec-bouncer:latest
    container_name: bouncer-traefik
    environment:
      CROWDSEC_BOUNCER_API_KEY: some-api-key
      CROWDSEC_AGENT_HOST: crowdsec:8080
    networks:
      - proxy # same network as traefik + crowdsec
    depends_on:
      - crowdsec
    restart: unless-stopped
networks:
  proxy:
    external: true
volumes:
  crowdsec-db:
  crowdsec-config:
  traefik_traefik-logs: # this will be the name of the volume from trarfic logs
    external: true # remove if traefik is running on same stack
```

```bash
cd config
touch acquis.yaml
nano acquis.yaml
docker-compose up -d --force-recreate
```

```yml
filenames:
  - /var/log/traefik/*
labels:
  type: traefik
```

## Configure Traefik

```bash
cd traefik
cd data
nano traefik.yml
```

```yml
api:
  dashboard: true
  debug: true
entryPoints:
  http:
    address: ":80"
    http:
      middlewares:
        - crowdsec-bouncer@file
  https:
    address: ":443"
    http:
      middlewares:
        - crowdsec-bouncer@file
serversTransport:
  insecureSkipVerify: true
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
  file:
    filename: /config.yml
certificatesResolvers:
  cloudflare:
    acme:
      email: someone@example.com
      storage: acme.json
      dnsChallenge:
        provider: cloudflare
        resolvers:
          - "1.1.1.1:53"
log:
  level: "INFO"
  filePath: "/var/log/traefik/traefik.log"
accessLog:
  filePath: "/var/log/traefik/access.log"
```

```bash
nano docker-compose.yml
```

```yml
version: '3'

services:
  traefik:
    image: traefik:latest
    container_name: traefik
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      - proxy
    ports:
      - 80:80
      - 443:443
    environment:
      - CF_API_EMAIL=user@example.com
      - CF_DNS_API_TOKEN=YOUR_API_TOKEN
      # - CF_API_KEY=YOUR_API_KEY
      # be sure to use the correct one depending on if you are using a token or key
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /home/username/traefik/data/traefik.yml:/traefik.yml:ro
      - /home/username/traefik/data/acme.json:/acme.json
      - /home/username/traefik/data/config.yml:/config.yml:ro
      - traefik-logs:/var/log/traefik
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.entrypoints=http"
      - "traefik.http.routers.traefik.rule=Host(`traefik-dashboard.local.example.com`)"
      - "traefik.http.middlewares.traefik-auth.basicauth.users=USER:BASIC_AUTH_PASSWORD"
      - "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto=https"
      - "traefik.http.routers.traefik.middlewares=traefik-https-redirect"
      - "traefik.http.routers.traefik-secure.entrypoints=https"
      - "traefik.http.routers.traefik-secure.rule=Host(`traefik-dashboard.local.example.com`)"
      - "traefik.http.routers.traefik-secure.middlewares=traefik-auth"
      - "traefik.http.routers.traefik-secure.tls=true"
      - "traefik.http.routers.traefik-secure.tls.certresolver=cloudflare"
      - "traefik.http.routers.traefik-secure.tls.domains[0].main=local.example.com"
      - "traefik.http.routers.traefik-secure.tls.domains[0].sans=*.local.example.com"
      - "traefik.http.routers.traefik-secure.service=api@internal"

networks:
  proxy:
    external: true
volumes:
  traefik-logs:
```

```bash
docker-compose up -d --force-recreate
```

```bash
cd config/data
nano config.yml
```

add

```yml
    crowdsec-bouncer:
      forwardauth:
        address: http://bouncer-traefik:8080/api/v1/forwardAuth
        trustForwardHeader: true

```

```bash
nano traefik.yml
```

```yml
# check to be sure you have your middleware set for both
entryPoints:
  http:
    address: ":80"
    http:
      middlewares:
        - crowdsec-bouncer@file
  https:
    address: ":443"
    http:
      middlewares:
        - crowdsec-bouncer@file
```

## Dashboard

To add a self-hosted dashboard update your `docker-compose.yml`

```bash
cd crowdsec
touch Dockerfile
```

```dockerfile
FROM metabase/metabase
RUN mkdir /data/ && wget https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip && unzip metabase_sqlite.zip -d /data/
```

```bash
nano docker-compose.yml
```

```yaml
  dashboard:
    #we're using a custom Dockerfile so that metabase pops with pre-configured dashboards
    build: ./dashboard
    restart: always
    ports:
      - 3000:3000
    environment:
      MB_DB_FILE: /data/metabase.db
      MGID: "${GID-1000}"
    depends_on:
      - 'crowdsec'
    volumes:
      - crowdsec-db:/metabase-data/
    networks:
      crowdsec_test:
        ipv4_address: 172.20.0.5
```

restart container

```bash
docker-compose up -d --force-recreate
```

Default's credentials for metabase are `crowdsec@crowdsec.net` and `!!Cr0wdS3c_M3t4b4s3??`  Be sure to change this.

## CrowdSec Commands

see metrics

```bash
docker exec crowdsec cscli metrics
```

see bans

```bash
docker exec crowdsec cscli decisions list
```

manually install collections

```bash
docker exec crowdsec cscli collections install crowdsecurity/traefik
```

update hubs

```bash
docker exec crowdsec cscli hub update
```

upgrade hubs

```bash
docker exec crowdsec cscli hub upgrade
```

add bouncer

(save api key somewhere)

```bash
docker exec crowdsec cscli bouncers add bouncer-traefik
```

ban ip

```bash
docker exec crowdsec cscli decisions add --ip 192.168.0.101
```

unban ip

```bash
docker exec crowdsec cscli decisions delete --ip 192.168.0.101
```
