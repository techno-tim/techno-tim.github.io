---
layout: post
title: "Test Your Internet Speed from the Linux Terminal with fast"
date: 2023-02-05 10:00:00 -0500
categories: utilities
tags: fast cli linux open-source
---

## What is Fux?

**FAST.com** is speed test gives you an estimate of your current Internet speed. It was created by Netflix to bring transparency to your  upload / download speeds and to see if your ISP may be prioritizing traffic.  I've run this quite a bit in a browser to do a quick spot check or my speeds, but I've never had a great tool to check this from some of my Linux machines. Let me clarify, some of my Linux servers that do not have a browser - that's until I found this utility, `fast`.  `fast` is an open source utility to run internet speed checks from machines that don't have a browser, from the terminal, all in a small, zero dependency binary.  You can read more about it on the [GitHub repo](https://github.com/ddo/fast/). 

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


If you want to use `wget` instead of `curl`, you can run the rollowing

```bash
wget https://github.com/ddo/fast/releases/download/v0.0.4/fast_linux_amd64 -O fast
```

Then we'll want to download the latest `fast` binary by running

```bash
curl -L https://github.com/ddo/fast/releases/download/v0.0.4/fast_linux_amd64 -o fast
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