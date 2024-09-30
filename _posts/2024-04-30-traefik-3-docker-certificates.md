---
layout: post
title: "Traefik 3 and FREE Wildcard Certificates with Docker"
date: 2024-04-30 08:00:00 -0500
categories: homelab
tags: traefik docker cloudflare pihole lets-encrypt
image:
 path: /assets/img/headers/traefik-3-docker-certificates-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP53x+2Cnxy1i40L4pfAv4Y+PvEnj2+T7d418Xaz8U7i+0+B9bfV9NttL0jw34/8K6Tpy6WbhdP+06ZDp+o6tpkS2Ot3uoW7NEf9AMty2hnEMDk2Ex+d5PgJYSniZ4HDYjJquBc8Fh3OSjGpw+sxj9Zu5VXPNKi9raaTpxhRj/NdbEYjDVcRi61HLcXVWIlhqFaphsfHEUadapFJtrNXg5ypNe5JYGm/Zvkbbcpy/Srwv/wSl+At74a8O3l3rni2S6u9C0m5uZEvJYUkuJ7C3lmdIkvNsSvI7Msa/KgIUcAV8piuNJYXE4jDUcroqlhq9WhSTx2OuqdGpKnBO1SKuoxS0SXZJaHswyelOMZ1K9WVScVKcuWkuacknKVuR2u23a7tsf/Z
---

In today's Traefik tutorial we'll get FREE Wildcard certificates to use in our HomeLab and with all of our internal self-hosted services.  We're going to set up Traefik 3 in Docker and get Let's Encrypt certificates using Cloudflare as our DNS Provider (we'll cover how to set up others too).  Then we'll configure local DNS using PiHole (or any other local DNS) to route to our services that are now protected with secure certificates!

{% include embed/youtube.html id='n1vOfdz5Nm8' %}
📺 [Watch Video](https://www.youtube.com/watch?v=n1vOfdz5Nm8)

## Disclosures

- Video was sponsored by UptimeRobot
- Save 20% on UptimeRobot <https://l.technotim.live/uptime-robot-technotim>!

> *Looking to do this same thing in Kubernetes? Check out [traefik + cert-manager on Kubernetes](/posts/kube-traefik-cert-manager-le/)*
{: .prompt-info }

> *Looking for the Traefik + Portainer guide? Check out [traefik + portainer on Docker](/posts/traefik-portainer-ssl/)*
{: .prompt-info }

For reference, the following folder structure was used:

```bash
./traefik
├── data
│   ├── acme.json
│   ├── config.yml
│   └── traefik.yml
└── cf_api_token.txt
└── docker-compose.yml
```

You can also do this with [other DNS providers too](https://doc.traefik.io/traefik/https/acme/#providers)!

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Prepare Our Server

Create folder for your compose and mounts

```bash
mkdir docker_volumes
cd docker_volumes
```

then we'll create a folder to hold traefik files

```bash
mkdir traefik
cd traefik
```

create docker compose file and add contents

```bash
touch docker-compose.yaml
nano docker-compose.yaml
```

## Tasks from Our Compose File

### Docker Compose Contents

`docker-compose.yaml`

```yaml
version: "3.8"

services:
  traefik:
    image: traefik:v3.0
    container_name: traefik
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      - proxy
    ports:
      - 80:80
      - 443:443
      # - 443:443/tcp # Uncomment if you want HTTP3
      # - 443:443/udp # Uncomment if you want HTTP3
    environment:
      CF_DNS_API_TOKEN_FILE: /run/secrets/cf_api_token # note using _FILE for docker secrets
      # CF_DNS_API_TOKEN: ${CF_DNS_API_TOKEN} # if using .env
      TRAEFIK_DASHBOARD_CREDENTIALS: ${TRAEFIK_DASHBOARD_CREDENTIALS}
    secrets:
      - cf_api_token
    env_file: .env # use .env
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./data/traefik.yml:/traefik.yml:ro
      - ./data/acme.json:/acme.json
      # - ./data/config.yml:/config.yml:ro
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.entrypoints=http"
      - "traefik.http.routers.traefik.rule=Host(`traefik-dashboard.local.example.com`)"
      - "traefik.http.middlewares.traefik-auth.basicauth.users=${TRAEFIK_DASHBOARD_CREDENTIALS}"
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

secrets:
  cf_api_token:
    file: ./cf_api_token.txt

networks:
  proxy:
    external: true
```

### data folder

```bash
mkdir data
cd data
touch acme.json
chmod 600 acme.json
```

### Traefik Config

```bash
touch traefik.yml
nano traefik.yml
```

`traefik.yml` contents:

```yaml
api:
  dashboard: true
  debug: true
entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"
serversTransport:
  insecureSkipVerify: true
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
  # file:
  #   filename: /config.yml
certificatesResolvers:
  cloudflare:
    acme:
      email: youremail@email.com
      storage: acme.json
      # caServer: https://acme-v02.api.letsencrypt.org/directory # prod (default)
      caServer: https://acme-staging-v02.api.letsencrypt.org/directory # staging
      dnsChallenge:
        provider: cloudflare
        #disablePropagationCheck: true # uncomment this if you have issues pulling certificates through cloudflare, By setting this flag to true disables the need to wait for the propagation of the TXT record to all authoritative name servers.
        #delayBeforeCheck: 60s # uncomment along with disablePropagationCheck if needed to ensure the TXT record is ready before verification is attempted 
        resolvers:
          - "1.1.1.1:53"
          - "1.0.0.1:53"
```

### Create Docker Network

```bash
docker network create proxy
```

### Cloudflare API Token Secret

```bash
touch cf_api_token.txt
nano cf_api_token.txt
```

Paste your token into file from Cloudflare

### Traefik Dashboard Password & .env

make sure you have `htpasswd` installed.

To install on Linux

```bash
sudo apt update
sudo apt install apache2-utils
```

Mac OS (should already be installed)

Windows

`htpasswd.exe` Should already be installed on Windows

Generate credential pair

```bash
echo $(htpasswd -nB user) | sed -e s/\\$/\\$\\$/g
```

```bash
touch .env
nano .env
```

paste your credential pair:

e.g.

```bash
TRAEFIK_DASHBOARD_CREDENTIALS=user:$$2y$$05$$lSaEi.G.aIygyXRdiFpt7OqmUMW9QUG5I1N.j0bXoXxIjxQmoGOWu
```

## Start the stack

```bash
docker compose up -d --force-recreate
```

## Troubleshooting

Common ways to troubleshoot

```bash
docker ps
docker logs traefik
docker exec -it traefik /bin/sh
```

inside of container

```bash
top
ls
cat acme.json
cat traefik.yml
ls /run/secrets
cat /run/secrets/cf_api_token
echo ${CF_DNS_API_TOKEN_FILE}
echo ${TRAEFIK_DASHBOARD_CREDENTIALS}
```

## DNS

```bash
nslookup traefik-dashboard.local.example.com
```

## Switch to Production Acme Endpoints

```yaml
...
      caServer: https://acme-v02.api.letsencrypt.org/directory # prod (default)
      #caServer: https://acme-staging-v02.api.letsencrypt.org/directory # staging
...
```

Clear out the existing staging certificates

```bash
cd data
nano acme.json
```

Clear and save

Restart the stack

```bash
docker compose up -d --force-recreate
```

## Adding Another Workload (NGINX Demo)

```bash
mkdir nginx
cd nginx
touch docker-compose.yaml
nano docker-compose.yaml
```

Contents of `docker-compose.yaml`

```yaml
version: '3.8'
services:
  nginx:
    image: nginxdemos/nginx-hello
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.nginx.rule=Host(`nginx.local.example.com`)"
      - "traefik.http.routers.nginx.entrypoints=https"
      - "traefik.http.routers.nginx.tls=true"
      - "traefik.http.services.nginx.loadbalancer.server.port=8080"
    networks:
      - proxy

networks:
  proxy:
    external: true
```

Check DNS

```bash
nslookup nginx.local.example.com
```

Start the new NGINX Stack

```bash
docker compose up -d --force-recreate
```

### Adding External Routes

Uncomment a few things:

In `docker-compose.yaml`

```yaml
...
      - ./data/config.yml:/config.yml:ro
...
```

in `traefik.yml`

```yaml
...
  file:
    filename: /config.yml
...
```

Create config

```bash
cd data
touch config.yml
nano config.yml
```

Contents of `config.yml`

```yaml
http:
 #region routers 
  routers:
    proxmox:
      entryPoints:
        - "https"
      rule: "Host(`proxmox.local.example.com`)"
      middlewares:
        - default-headers
        - https-redirectscheme
      tls: {}
      service: proxmox
    pihole:
  
#endregion
#region services
  services:
    proxmox:
      loadBalancer:
        servers:
          - url: "https://192.168.0.17:8006"
        passHostHeader: true
#endregion
  middlewares:
    https-redirectscheme:
      redirectScheme:
        scheme: https
        permanent: true
    default-headers:
      headers:
        frameDeny: true
        browserXssFilter: true
        contentTypeNosniff: true
        forceSTSHeader: true
        stsIncludeSubdomains: true
        stsPreload: true
        stsSeconds: 15552000
        customFrameOptionsValue: SAMEORIGIN
        customRequestHeaders:
          X-Forwarded-Proto: https

    default-whitelist:
      ipAllowList:
        sourceRange:
        - "10.0.0.0/8"
        - "192.168.0.0/16"
        - "172.16.0.0/12"

    secured:
      chain:
        middlewares:
        - default-whitelist
        - default-headers
```

Restart the stack

```bash
docker compose up -d --force-recreate
```

To see more examples of commonly used services check out [config.yml in the reference files](https://github.com/techno-tim/techno-tim.github.io/blob/master/reference_files/traefik-portainer-ssl/traefik/config.yml)

## Final Production Files

Traefik `docker-compose.yaml`

```yaml
version: "3.8"

services:
  traefik:
    image: traefik:v3.0
    container_name: traefik
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      - proxy
    ports:
      - 80:80
      - 443:443
      # - 443:443/tcp # Uncomment if you want HTTP3
      # - 443:443/udp # Uncomment if you want HTTP3
    environment:
      CF_DNS_API_TOKEN_FILE: /run/secrets/cf_api_token # note using _FILE for docker secrets
      # CF_DNS_API_TOKEN: ${CF_DNS_API_TOKEN} # if using .env
      TRAEFIK_DASHBOARD_CREDENTIALS: ${TRAEFIK_DASHBOARD_CREDENTIALS}
    secrets:
      - cf_api_token
    env_file: .env # use .env
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./data/traefik.yml:/traefik.yml:ro
      - ./data/acme.json:/acme.json
      - ./data/config.yml:/config.yml:ro
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.entrypoints=http"
      - "traefik.http.routers.traefik.rule=Host(`traefik-dashboard.local.example.com`)"
      - "traefik.http.middlewares.traefik-auth.basicauth.users=${TRAEFIK_DASHBOARD_CREDENTIALS}"
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

secrets:
  cf_api_token:
    file: ./cf_api_token.txt

networks:
  proxy:
    external: true
```

`traefik.yml`

```yaml
api:
  dashboard: true
  debug: true
entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"
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
      email: youremail@email.com
      storage: acme.json
      caServer: https://acme-v02.api.letsencrypt.org/directory # prod (default)
      # caServer: https://acme-staging-v02.api.letsencrypt.org/directory # staging
      dnsChallenge:
        provider: cloudflare
        #disablePropagationCheck: true # uncomment this if you have issues pulling certificates through cloudflare, By setting this flag to true disables the need to wait for the propagation of the TXT record to all authoritative name servers.
        #delayBeforeCheck: 60s # uncomment along with disablePropagationCheck if needed to ensure the TXT record is ready before verification is attempted 
        resolvers:
          - "1.1.1.1:53"
          - "1.0.0.1:53"
```

`config.yml`

```yaml
http:
 #region routers 
  routers:
    proxmox:
      entryPoints:
        - "https"
      rule: "Host(`proxmox.local.example.com`)"
      middlewares:
        - default-headers
        - https-redirectscheme
      tls: {}
      service: proxmox
    pihole:
  
#endregion
#region services
  services:
    proxmox:
      loadBalancer:
        servers:
          - url: "https://192.168.0.17:8006"
        passHostHeader: true
#endregion
  middlewares:
    https-redirectscheme:
      redirectScheme:
        scheme: https
        permanent: true
    default-headers:
      headers:
        frameDeny: true
        browserXssFilter: true
        contentTypeNosniff: true
        forceSTSHeader: true
        stsIncludeSubdomains: true
        stsPreload: true
        stsSeconds: 15552000
        customFrameOptionsValue: SAMEORIGIN
        customRequestHeaders:
          X-Forwarded-Proto: https

    default-whitelist:
      ipAllowList:
        sourceRange:
        - "10.0.0.0/8"
        - "192.168.0.0/16"
        - "172.16.0.0/12"

    secured:
      chain:
        middlewares:
        - default-whitelist
        - default-headers
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Traefik 3 is here! So, today we&#39;ll get trusted certificates with Let&#39;s Encrypt for all of our self-hosted services! No more https warnings and no more weird ports!<a href="https://t.co/MoRKYXvA0M">https://t.co/MoRKYXvA0M</a> <a href="https://t.co/5OR22iRJRJ">pic.twitter.com/5OR22iRJRJ</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1785328960177356804?ref_src=twsrc%5Etfw">April 30, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
