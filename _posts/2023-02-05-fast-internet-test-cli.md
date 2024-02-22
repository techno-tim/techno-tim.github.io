---
layout: post
title: "Test Your Internet Speed from the Linux Terminal with fast"
date: 2023-02-05 10:00:00 -0500
categories: utilities
tags: fast cli linux open-source
image:
  path: /assets/img/headers/fast-lights.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APCtd/YF+E/xA+Knhaz0e5m8KWMsMDyWkmlWOtRXOmy+K4fDlzZ3yxPoiXV6y6na3ttq4jintpNNjieG5E7SR/PeEf0l/ELDY7K8Xn1TD57KtVwXDmIp05VcupVadaGPxrxPJUeYqMnNtSpvnbcabp1aUYOE/wDUH6SngRwP/qZmnE2WZdgskzzLMNmGZTnluCdPLMXVwWUwx8Iyy6WKcqLlTgsM6sMW5uV8TVdWpKUZeOS/sA/CDzZfOttOeXzH8149HvYY3k3He0cP/CRP5SM2Sse99ikLvbGT/cVXifOXUqOOJjCLnNxgqNN8seZ2jdq75Vpd6u1z+HMJwLw9UwmFqV8FCpWnh6M61SM8RTU6sqcZVJqmsQ1BSm3JQTainZN2uf/Z
---

## What is FAST.com?

**FAST.com** is speed test gives you an estimate of your current Internet speed. It was created by Netflix to bring transparency to your  upload / download speeds and to see if your ISP may be prioritizing traffic.I've run this quite a bit in a browser to do a quick spot check or my speeds, but I've never had a great tool to check this from some of my Linux machines. Let me clarify, some of my Linux servers that do not have a browser - that's until I found this utility, `fast`.`fast` is an open source utility to run internet speed checks from machines that don't have a browser, from the terminal, all in a small, zero dependency binary.You can read more about it on the [GitHub repo](https://github.com/ddo/fast/).

## Installing fast

We're going to use `curl` so you'll want to be sure you have it installed

```bash
curl -V
```

This should return something similar to the following

```console
curl 7.68.0 (x86_64-pc-linux-gnu) libcurl/7.68.0 OpenSSL/1.1.1f zlib/1.2.11 brotli/1.0.7 libidn2/2.2.0 libpsl/0.21.0 (+libidn2/2.2.0) libssh/0.9.3/openssl/zlib nghttp2/1.40.0 librtmp/2.3
Release-Date: 2020-01-08
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: AsynchDNS brotli GSS-API HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz NTLM NTLM_WB PSL SPNEGO SSL TLS-SRP UnixSockets
```

Then we'll want to download the latest `fast` binary by running

```bash
LATEST_VERSION=$(curl -s "https://api.github.com/repos/ddo/fast/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

curl -L https://github.com/ddo/fast/releases/download/v${LATEST_VERSION}/fast_linux_$(dpkg --print-architecture) -o fast
```

If you want to use `wget` instead of `curl`, you can run the following

```bash
LATEST_VERSION=$(curl -s "https://api.github.com/repos/ddo/fast/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

wget https://github.com/ddo/fast/releases/download/v${LATEST_VERSION}/fast_linux_$(dpkg --print-architecture) -O fast
```

Then we'll want to make it executable by running

```bash
chmod +x fast
```

Then we can run a speed test by running

```bash
./fast
```

This should return something similar to the following

```console
➜  ~ ./fast
 -> 477.72 Mbps
```

That's it!  You can now run an internet speed test from the Linux cli without a browser!  What's your download speed?

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
