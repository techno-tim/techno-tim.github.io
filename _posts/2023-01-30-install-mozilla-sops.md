---
layout: post
title: "Installing Mozilla SOPS Encryption Tool"
date: 2023-01-30 10:00:00 -0500
categories: utilities
tags: homelab secops mozilla sops cli linux open-source
---

## What is Mozilla SOPS?

**SOPS** is an editor of encrypted files that supports YAML, JSON, ENV, INI and BINARY formats and encrypts with AWS KMS, GCP KMS, Azure Key Vault, age, and PGP.  It's open source and you can read more about it on the [GitHub repo](https://github.com/mozilla/sops).  Looking for a tutorial on how use this?  [Check out this video on how to use SOPS and Age for your Git Repos](/posts/secret-encryption-sops/)!

## Install

We want to get the latest release of `SOPS` so we need to look at their github repo for the latest version.

```bash
SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
```

Then we'll use `curl` to download the latest `.deb`

```bash
curl -Lo sops.deb "https://github.com/mozilla/sops/releases/latest/download/sops_${SOPS_LATEST_VERSION}_amd64.deb"

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
