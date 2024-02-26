---
layout: post
title: "Meet Gatus - An Advanced Uptime Health Dashboard"
date: 2024-02-26 08:00:00 -0500
categories: self-hosted
tags: gatus dashboard docker open-source homelab
image:
 path: /assets/img/headers/gatus-uptime-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5B/GesfD34MP8AEL4Y6n8EPh98TddtPEPjLSdI+KPibxF8Z9C8W6LI0CWthqFlpPgr4reHvBV3NpNwjalZW2ueGdXsZLyWZL23urKWW0fTCTp47IMmztUKOGnmVPFKthaMf9nhPBzjh6k6XNdwjiJwnV9kvcoqcaVNctNN9WKpqGJxNG6lGlKkk5xjJyVeLnaWmvLFRhrdy5bvey890n4d6xfaVpl6ni1YFvNPsrpYTo9zJ5K3FtHKIvMXX4Vfyw4TesUStjIjQHaPzzE8U06eIxFN5XCThXqwcvrEFzONSUb2eEk1e17OUn5vc9SGSynCE1jq8FKEZKMU+WKkk+VfvNley8kf/9k=
---

Meet Gatus a self-hosted, open source, health dashboard that lets you monitor all of you services and systems!  This dashboard not only tracks your uptime, but also measure the results plotting the results on a chart over time.  It also hooks into systems like Slack, Team, Discord, Twilio, and more!  Join me as we configure and deploy Gatus into our own environment to measure and monitor all the things!

{% include embed/youtube.html id='LeZQjWlDUHs' %}
📺 [Watch Video](https://www.youtube.com/watch?v=LeZQjWlDUHs)

Disclosures:

- Nothing in this video was sponsored

Don't forget to ⭐ [Gatus on GitHub](https://github.com/TwiN/gatus)!

## Create Docker Compose

ssh into server

Make a directory and cd into it

```bash
mkdir gatus_uptime
cd gatus_uptime
```

In here we're going to create a docker compose file

```bash
touch docker-compose.yaml
nano docker-compose.yaml
```

Basic Docker Compose

```yaml
version: "3.9"
services:
  gatus:
    image: twinproduction/gatus:latest
    restart: always
    ports:
      - "8080:8080"
    environment:
      - POSTGRES_USER=gatus_uptime_user # postgres user with access to the database
      - POSTGRES_PASSWORD=gatuspassword # postgres user password
      - POSTGRES_DB=gatus_uptime # this should be the name of your postgres database
    volumes:
      - ./config:/config
```

## Postgres Database

I am going use postgres to hold out data. [Postgres](https://www.postgresql.org/) is an open source object-relational database system that uses and extends the SQL language combined with many features that safely store and scale the most complicated data workloads.

> If you need to create a Postgres database, [here's the official Docker image](https://hub.docker.com/_/postgres).  If you want to include Postgres in the same stack, [you can see an example here](https://github.com/TwiN/gatus/tree/master/.examples/docker-compose-postgres-storage).  It also [supports SQLite](https://github.com/TwiN/gatus/tree/master/.examples/docker-compose-sqlite-storage) if you don't want to use postgres
{: .prompt-info }

Using [pgadmin](https://www.pgadmin.org/) (Windows/macOS/Linux support) or similar tools:

- Create database: `gatus_uptime`
- Create user: `gatus_uptime_user`
- Give user access to db

Once you have that you should test your connection before proceeding.

## Gatus Config

Make a config folder to house our config and create a config file.

```bash
mkdir config
cd config
touch config.yaml
```

Now we need to create a config file for the sites we want to monitor.

Place the following contents inside of the `config.yaml`

```yaml
storage:
  type: postgres
  path: "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}?sslmode=disable"

endpoints:
  - name: back-end
    group: core
    url: "https://example.org/"
    interval: 5m
    conditions:
      - "[STATUS] == 200"
      - "[CERTIFICATE_EXPIRATION] > 48h"

  - name: monitoring
    group: internal
    url: "https://example.org/"
    interval: 5m
    conditions:
      - "[STATUS] == 200"

  - name: nas
    group: internal
    url: "https://example.org/"
    interval: 5m
    conditions:
      - "[STATUS] == 200"

  - name: example-dns-query
    url: "8.8.8.8" # Address of the DNS server to use
    interval: 5m
    dns:
      query-name: "example.com"
      query-type: "A"
    conditions:
      - "[BODY] == 93.184.216.34"
      - "[DNS_RCODE] == NOERROR"

  - name: icmp-ping
    url: "icmp://example.org"
    interval: 1m
    conditions:
      - "[CONNECTED] == true"
```

Be sure to update the DB hostname with your IP if you're using an external database.

`path: "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@192.168.30.240:5432/${POSTGRES_DB}?sslmode=disable"`

You can use DNS here too if you like e.g. `@database.example.com:5432`

## Starting Gatus

Now we can start our container

```bash
gatus docker compose up -d
```

Check to be sure the container is running with out errors

```bash
docker logs gatus-gatus-1
```

Before we check out the UI, let's look at postgres and verify that tables were created in our database.  You should see them listed here: `gatus_uptime>Schemas>public>Tables`

Once we can seethat tables were created, now lets check out the UI.

Gatus is hosted on the default port of `8080`.

Visit the IP with port in your browser:

`http://192.168.10.125:8080/`

## Real World Example

Here's how I monitor my sites:

```yaml
storage:
  type: postgres
  path: "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@192.168.30.240:5432/${POSTGRES_DB}?sslmode=disable"

endpoint-defaults: &defaults
  group: External
  interval: 30s
  client:
    timeout: 10s
  conditions:
    - "[STATUS] == 200"
    - "[CERTIFICATE_EXPIRATION] > 48h"

endpoints:
  - name: shop.technotim.live - HTTP
    <<: *defaults
    url: "https://shop.technotim.live"
  
  - name: technotim.live - HTTP
    <<: *defaults
    url: "https://technotim.live"

  - name: links.technotim.live - HTTP
    <<: *defaults
    url: "https://links.technotim.live"

  - name: l.technotim.live - HTTP
    <<: *defaults
    url: "https://l.technotim.live"

  - name: shop.technotim.live - DNS
    group: External
    url: "8.8.8.8" # Address of the DNS server to use
    interval: 5m
    dns:
      query-name: "shop.technotim.live"
      query-type: "A"
    conditions:
      - "[BODY] == 23.227.38.74"
      - "[DNS_RCODE] == NOERROR"

  - name: shop.technotim.live - Ping
    group: External
    url: "icmp://shop.technotim.live"
    interval: 1m
    conditions:
      - "[CONNECTED] == true"

  - name: Postgres
    group: Internal
    url: "tcp://192.168.30.240:5432"
    interval: 30s
    conditions:
      - "[CONNECTED] == true"
```

## Alerts

Gatus supports [many systems for alerts](https://github.com/TwiN/gatus?tab=readme-ov-file#alerting)

To keep it simple, we're going to create a discord alert.

- First create a webhook in your discord server
- Then use that hook url in your config

We'll configure some defaults too so we can keep our endpoints tidy like so:

```yaml
alerting:
  discord:
    webhook-url: "https://discord.com/api/webhooks/**********/**********"
    default-alert:
      description: "Health Check Failed"
      send-on-resolved: true
      failure-threshold: 2
      success-threshold: 2
```

Then you'll need to update each endpoint with the alert:

```yaml
    alerts:
      - type: discord
```

Or, you can just add it to your anchor which will add it to all

```yaml
endpoint-defaults: &defaults
  group: External
  interval: 30s
  client:
    timeout: 10s
  conditions:
    - "[STATUS] == 200"
    - "[CERTIFICATE_EXPIRATION] > 48h"
  alerts:
    - type: discord
```

Now let's create some chaos.

- Take your site down
- After 2 time outs we get the alerts

Now let's test recovery

- Bring Site back up
- After 2 checks we can see the recovery alert

Full config example:

```yaml
storage:
  type: postgres
  path: "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@192.168.30.240:5432/${POSTGRES_DB}?sslmode=disable"

alerting:
  discord:
    webhook-url: "https://discord.com/api/webhooks/**********/**********"
    default-alert:
      description: "Health Check Failed"
      send-on-resolved: true
      failure-threshold: 2
      success-threshold: 2

endpoint-defaults: &defaults
  group: External
  interval: 15s
  client:
    timeout: 10s
  conditions:
    - "[STATUS] == 200"
    - "[CERTIFICATE_EXPIRATION] > 48h"
  alerts:
    - type: discord

endpoints:
  - name: shop.technotim.live - HTTP
    <<: *defaults
    url: "https://shop.technotim.live"

  - name: technotim.live - HTTP
    <<: *defaults
    url: "https://technotim.live"

  - name: links.technotim.live - HTTP
    <<: *defaults
    url: "https://links.technotim.live"

  - name: l.technotim.live - HTTP
    <<: *defaults
    url: "https://l.technotim.live"

  - name: shop.technotim.live - DNS
    group: External
    url: "8.8.8.8" # Address of the DNS server to use
    interval: 5m
    dns:
      query-name: "shop.technotim.live"
      query-type: "A"
    conditions:
      - "[BODY] == 23.227.38.74"
      - "[DNS_RCODE] == NOERROR"

  - name: shop.technotim.live - Ping
    group: External
    url: "icmp://shop.technotim.live"
    interval: 1m
    conditions:
      - "[CONNECTED] == true"

  - name: Postgres
    group: Internal
    url: "tcp://192.168.30.240:5432"
    interval: 30s
    conditions:
      - "[CONNECTED] == true"
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Over the last few weeks I have been looking for a more advanced self-hosted monitoring system. One that gives me more than just a simple up and down status and one that is config based. I think I found it!<br><br>Check it out!<br><br>👉<a href="https://t.co/7Z2xGA0w65">https://t.co/7Z2xGA0w65</a> <a href="https://t.co/LkDOo3hPzo">pic.twitter.com/LkDOo3hPzo</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1762168640625885552?ref_src=twsrc%5Etfw">February 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
