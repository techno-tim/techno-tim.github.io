---
layout: post
title: "Installing Mozilla SOPS Encryption Tool"
date: 2023-01-30 10:00:00 -0500
categories: utilities
tags: homelab secops mozilla sops cli linux open-source
image:
  path: /assets/img/headers/sops-install.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5lP2Ffg9P8cPiJq3h2+8e+KfClrpngnxV4tsZ/D8kJnh1a0hWIyhb3z4Fa5S2AubiGGG8kK22LlRaoG5fEni7FcLYLCYnB4SjiJ1s1w2HqKvWxEIypS5ZST+r1KU27TtHmm6as+anNSsvrvCDgvB8U0c7nmGLr04YTI8VVoQoUMJLkrNVIwqL63QxVNcvsZtyjSjWftIunWpSpqUvCpvjD8aYppY4/jd8ZVjjlkRFHxN8XYVEYqqj/AImfQKABX2UMfSlCEpYGhdxi3ZtK7SbsuV2V9ld27nwv1DFLSObZhGK0jH2rdorZXTS0WmiS8lsf/9k=

---

## What is Mozilla SOPS?

**SOPS** is an editor of encrypted files that supports YAML, JSON, ENV, INI and BINARY formats and encrypts with AWS KMS, GCP KMS, Azure Key Vault, age, and PGP.It's open source and you can read more about it on the [GitHub repo](https://github.com/mozilla/sops).Looking for a tutorial on how use this?  [Check out this video on how to use SOPS and Age for your Git Repos](/posts/secret-encryption-sops/)!

## Install

We want to get the latest release of `SOPS` so we need to look at their github repo for the latest version.

```bash
SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/getsops/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
```

Then we'll use `curl` to download the latest `.deb`

```bash
curl -Lo sops.deb "https://github.com/getsops/sops/releases/download/v${SOPS_LATEST_VERSION}/sops_${SOPS_LATEST_VERSION}_amd64.deb"

```

Then we'll want to install `sops.deb` along with any missing dependencies

```bash
sudo apt --fix-broken install ./sops.deb
```

Then we'll clean up our download

```bash
rm -rf sops.deb
```

Then we can test to make sure `sops` is working by running:

```bash
sops -version
```

## Uninstall

To uninstall, it's as simple as using apt to remove it

```bash
sudo apt remove sops
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
