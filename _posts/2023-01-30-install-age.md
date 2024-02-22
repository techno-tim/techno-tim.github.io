---
layout: post
title: "Installing Age Encryption Tool"
date: 2023-01-30 10:00:00 -0500
categories: utilities
tags: homelab secops devops age cli linux open-source
image:
  path: /assets/img/headers/age-install.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP2N8X/s5+EkXRfGfh/Vdf0FPAvhS0vbXRhqN3e22q3Wq20N3eXWqTG5tfNuprmd5pZI4I4izOIoIVZFjwxUp18Z7epOXPduKhaMYqMpKMbJapRSTd7y3k3qb0I04YdwjTi4ytz865pSuottvSzd7aKyWySsl8xW1l4ZsbeCyOgGU2cMVqZRql1CJTbosRkESoyxB9m4RqSqZ2gkDNfRUsZD2VO+Gg37OF3zyV3yq7strvp0PLnQ9+f7yqvelonDTV6awb+9s//Z

---

## What is Age?

**age** is a simple, modern and secure file encryption tool, format, and Go library. It features small explicit keys, no config options, and UNIX-style composability.It is commonly used in tandem with Mozilla SOPS.It's open source and you can read more about it on the [GitHub repo](https://github.com/FiloSottile/age). Looking for a tutorial on how use this?  [Checkout this video on how to use SOPS and Age for your Git Repos](/posts/secret-encryption-sops/)!

## Install

We want to get the latest release of `age` so we need to look at their github repo for the latest version.

```bash
AGE_LATEST_VERSION=$(curl -s "https://api.github.com/repos/FiloSottile/age/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

```

Then we'll use `curl` to download the latest `.tar.gz`

```bash
curl -Lo age.tar.gz "https://github.com/FiloSottile/age/releases/latest/download/age-v${AGE_LATEST_VERSION}-linux-amd64.tar.gz"

```

Then we'll want to extract `age.tar.gz`

```bash
tar xf age.tar.gz
```

Then we'll move both binaries (`age` and `age-keygen`) to `/usr/local/bin` so we can use them

```bash
sudo mv age/age /usr/local/bin
sudo mv age/age-keygen /usr/local/bin
```

Then we'll clean up our downloads and extractions

```bash
rm -rf age.tar.gz
rm -rf age
```

Then we can test to make sure `age` and `age-keygen` are working by running

```bash
age -version
```

```bash
age-keygen -version
```

## Uninstall

To uninstall, it's as simple as removing the binaries

```bash
sudo rm -rf /usr/local/bin/age
sudo rm -rf /usr/local/bin/age-keygen
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
