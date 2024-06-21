---
layout: post
title: "Track Changes Online with ChangeDetection, a Self-Hosted Docker Container!"
date: 2024-06-21 08:00:00 -0500
categories: homelab hardware
tags: changedetection docker software
image:
 path: /assets/img/headers/change-detection-docker-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyN/Zv+NPwivbX4W/Bvxb8C5vFGr/EHVYfh1rHxCuPE/wAPRrNkPHOt2WnXuvaI+rfA3XvEenX1lp+ryW9lajxjNaWzwQSWS2ShojrToLGKpVTjhqkKnt5zw9OEHWnTv7N1U04zcXaSbTblFN31v41F024xdNXvq9N3Ja/C3daddWrs/pR0f4M+GNE0jS9F0uG0tNM0jTrHS9OtY9PRY7awsLaK0tLdAlwihIbeKONQqqoCgBQMATClyxjF1sRJxiouUqzvJpJcz03e78z0lypJcuytuz//2Q==
---


Tracking things on the web just got a whole lot easier with ChangeDetection, the free and open source Docker container!  Track website changes, price changes of products, and even track out of stock products with notifications all from a container you host yourself!

{% include embed/youtube.html id='o_iG4Wunh98' %}
📺 [Watch Video](https://www.youtube.com/watch?v=o_iG4Wunh98)

## Disclosures

- Thanks to Docker for Sponsoring this Video!  
- Get Actionable insights for software supply chain management with Docker Scout! <https://dockr.ly/45HWDnR>

## Info

⭐ ChangeDetection on GitHub: <https://github.com/dgtlmoon/changedetection.io>

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker compose`

## Prepare Our Server

Create folder for your compose and mounts

```bash
mkdir changedetection
cd changedetection
```

Then we'll create a folder to hold our data and our datastore

```bash
mkdir data
cd data
mkdir datastore
cd datastore
cd ../.. # go back to the root of changedetection/
```

Create docker compose file and add contents

```bash
touch compose.yaml
nano compose.yaml
```

Your folder structure should look like this

```bash
./changedetection
├── data
│   └── datastore
└── docker-compose.yml
```

## Tasks from Our Compose File

### Docker Compose Contents

Simple version of `change detection`

```yaml
---
services:
  changedetection:
    image: ghcr.io/dgtlmoon/changedetection.io:latest
    container_name: changedetection
    hostname: changedetection
    environment:
      # - BASE_URL=https://mysite.com # configure this for your own domain
    volumes:
      - ./data/datastore:/datastore
    ports:
      - 5000:5000
```

Advanced version of `change detection`

If you want to use Selenium + Webdriver, uncomment the `WEBDRIVER_URL` variable and the `browser-chrome` service, and then comment out `PLAYWRIGHT_DRIVER_URL` variable and `playwright-chrome` service.

To see all supported configurations, see the [Docker compose file on github](https://github.com/dgtlmoon/changedetection.io/blob/master/docker-compose.yml)

```yaml
---
services:
  changedetection:
    image: ghcr.io/dgtlmoon/changedetection.io:latest
    container_name: changedetection
    hostname: changedetection
    volumes:
      - ./data/datastore:/datastore
    ports:
      - 5000:5000
    environment:
      # - WEBDRIVER_URL=http://playwright-chrome:4444/wd/hub
      - PLAYWRIGHT_DRIVER_URL=ws://playwright-chrome:3000
      # - BASE_URL=https://mysite.com # configure this for your own domain

    depends_on:
      playwright-chrome:
        condition: service_started
    restart: unless-stopped

  # browser-chrome:
  #   hostname: browser-chrome
  #   image: selenium/standalone-chrome:125.0
  #   shm_size: '2gb'
  #   # volumes:
  #   #     # Workaround to avoid the browser crashing inside a docker container
  #   #     # See https://github.com/SeleniumHQ/docker-selenium#quick-start
  #   #     - /dev/shm:/dev/shm
  #   restart: unless-stopped
   
  playwright-chrome:
    hostname: playwright-chrome
    image: browserless/chrome
    restart: unless-stopped
    environment:
      - SCREEN_WIDTH=1920
      - SCREEN_HEIGHT=1024
      - SCREEN_DEPTH=16
      - ENABLE_DEBUGGER=false
      - PREBOOT_CHROME=true
      - CONNECTION_TIMEOUT=300000
      - MAX_CONCURRENT_SESSIONS=10
      - CHROME_REFRESH_TIME=600000
      - DEFAULT_BLOCK_ADS=true
      - DEFAULT_STEALTH=true
      # Ignore HTTPS errors, like for self-signed certs
      - DEFAULT_IGNORE_HTTPS_ERRORS=true
```

## Chrome Extension

If you want to install the Chrome Extenions, you can but adding it here

- <https://chromewebstore.google.com/detail/changedetectionio-website/kefcfmgmlhmankjmnbijimhofdjekbop?hl=en>

Then all you need to do to configure it is visit your ChangeDetection site and click Settings and it will automatically configure it for you!

Then when visiting a site, all you need to do it click the extension and click add!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">This week I spun up ChangeDetection, a free and open source (and self-hosted) container to help you track things on the web! <br>Check it out!<a href="https://t.co/Kmi5i94GcJ">https://t.co/Kmi5i94GcJ</a> <a href="https://t.co/s1uteYMHtH">pic.twitter.com/s1uteYMHtH</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1804175575117865385?ref_src=twsrc%5Etfw">June 21, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
