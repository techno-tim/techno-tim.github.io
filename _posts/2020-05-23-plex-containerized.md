---
layout: post
title: "4 Ways to Install Plex (one is unexpected)"
date: 2020-05-23 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes portainer docker plex self-hosted
image:
  path: /assets/img/headers/movie-theater.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4adPj8BX+k6pqi+CriFPD0Vo91bv4nvZpNUOozG1j23C2UCWH2V1abi1uhPuEbCMLubz1RxqhV5scnOSpuk1hacY0vebnePPJ1OZWivejy76n29fNOEXisrdDg6rTwtFYtZlQq8R42tWzHnoxjhnTxMcJRjgXhqvNVfLh8RGvzKnKMFG8uPbUPBpZivhG/VSSVX/hJ920E8LuOiZOBxk8nqaFHG/8AQXTfn9VWv/lYmWN4Pcm1wrmEU22o/wCs03ypvRXeT3dlpd6vqf/Z

---

I'm a huge fan of virtualization and containerization (if you couldn't tell already)!  Today, we'll walk though the various ways to install Plex step-by-step.We also see how easy it is to get Plex running on Docker and Kubernetes using Rancher.

{% include embed/youtube.html id='MG_1XQxWns0' %}

📺 [Watch Video](https://www.youtube.com/watch?v=MG_1XQxWns0)

## Id for Container

Get Id and Group Id

```bash
id yourusername
```

Should see something like this:

```bash
uid=1001(technotim) gid=1001(technotim) groups=1001(technotim),27(sudo),999(docker)
```

## Mount Shares During Boot

Install `cifs-utils`

```bash
sudo apt-get install cifs-utils
```

Create credentials files for share

```bash
sudo nano /home/technotim/.smbcredentials
```

Set permissions

```bash
chmod 600 ~/.smbcredentials
```

```bash
username=yourUsyourusernameername  
password=yourPassword
```

Edit `/etc/fstab`

```bash
//192.168.0.22/plex_media/movies /mnt/movies cifs credentials=/home/technotim/.smbcredentials 0 0
//192.168.0.22/plex_media/music /mnt/music cifs credentials=/home/technotim/.smbcredentials 0 0
```

Then reboot or

```bash
sudo mount -a
```

to mount

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
