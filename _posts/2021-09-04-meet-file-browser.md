---
layout: post
title: "Meet File Browser, a Small but Mighty Web File Browser"
date: 2021-09-04 10:00:00 -0500
categories: self-hosted
tags: homelab portainer self-hosted docker rancher file-browser
image:
  path: /assets/img/headers/folders-colorful.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APePhx4WvLrxxpfgrxh4k1fxf4X8X6Jb+LW0e6uLqxstKtk8JxeLbzRLK1hvZrNEle/lsdP1GK2t7vSgGuYRK09zFN/H2OwnAUvof8Z+KGV+FvAeRcReHWZ5xQyHM8oyTDZdxF/rdlHG2Q8AZJxXieKcup4LOMVhcH9dp5ljOE8bUxeR5vhYV8qx0ZVJ5fmmVfpssFx/wp9MPxV8MM/8XePvEfhLj3jHE+HOFy/jnOMdnGHyDhnijhfijjLH4aOVV8bPhzG4mNDhnB5TQzPDZHlGb4OdHBZhlmY5dHD47L80on4Sx3v+mWnibUrO0u/9JtbOa0s7yW1t5/3sNtLdqLRbqSCN1ie4W1thOymUW8Iby1/PpftCuGMmbyfM/oycOZrmWVN5bmGaYTxh8XcmwmZY7Av6ri8fhcojneOjlWHxlelUxFHLY43GRwNOpHCrFYhUvbT/AFHBfQa8UeIcHhM/wP0yvFDLMFnmFoZxg8txnAXhzneLy/C5nShjcPgcVnWIy7DV83xOEpV4UK+aV8Nh62Pq05YupQpTqypx/wD/2Q==

---

Meet [File Browser](https://github.com/filebrowser/filebrowser), an open source, self-hosted alternative to services like Dropbox and other web based file browsers.Today we'll configure a containerized version of File Browser and have you up and going in just a few minutes.We'll also walk through creating, editing, moving, copying, and even sharing files and folders so that you get a better understanding about what File Browser is all about.

{% include embed/youtube.html id='W2yZ5_sd9Hc' %}

📺 [Watch Video](https://www.youtube.com/watch?v=W2yZ5_sd9Hc)

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker-compose`

## Running the container

If you're using Docker compose

```bash
mkdir filebrowser
cd filebrowser
touch docker-compose.yml
nano docker-compose.yml # copy the contents from below
touch filebrowser.db
docker-compose up -d --force-recreate
```

`docker-compose.yml`

```yml
---
version: '3'
services:
  file-browser:
    image: filebrowser/filebrowser
    container_name: file-browser
    user: 1000:1000
    ports:
      - 8081:80
    volumes:
      - /home/serveradmin/:/srv
      - /home/serveradmin/filebrowser/filebrowser.db:/database.db
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```

If you're using Rancher, Portainer, Open Media Vault, Unraid, or anything else with a GUI, just copy and paste the environment variables above into the form on the web page.

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
