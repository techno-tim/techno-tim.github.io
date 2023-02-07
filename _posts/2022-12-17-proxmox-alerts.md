---
layout: post
title: "Set up alerts in Proxmox before it's too late!"
date: 2022-12-17 09:00:00 -0500
categories: proxmox
tags: homelab proxmox alerting open-source
---

[![Set up alerts in Proxmox before it's too late!](https://img.youtube.com/vi/85ME8i4Ry6A/0.jpg)](https://www.youtube.com/watch?v=85ME8i4Ry6A "Set up alerts in Proxmox before it's too late!")

## Description

Setting up alerts in Proxmox is important and critical to making sure you are notified if something goes wrong with your servers.  It's so easy, I should have done this years ago!  In this tutorial, we'll set up email notifications using SMTP with Gmail or G Suite that send email alerts when there are disk errors, ZSF Issues, or when backup jobs run.  We'll then test the alerts to make sure they are working by yoinking a drive from my ZFS pool (and hopefully it doesn't fail).

📺 [Watch Video](https://www.youtube.com/watch?v=85ME8i4Ry6A)

## Sponsor

Huge THANK YOU to Micro Center for Sponsoring Today's video!

New Customer Exclusive – Free 256GB SDD: <https://micro.center/24c>

Check out Micro Center’s PC Builder: <https://micro.center/1wk>

Submit your build to Micro Center’s Build Showcase: <https://micro.center/tvv>

Shop Micro Center’s Top Deals: <https://micro.center/jb4>

## Configuring Alerts

install dependencies

```bash
apt update
apt install -y libsasl2-modules mailutils
```

Configure app passwords on your Google account

<https://myaccount.google.com/apppasswords>

Configure postfix

```bash
echo "smtp.gmail.com your-email@gmail.com:YourAppPassword" > /etc/postfix/sasl_passwd
```

update permissions

```bash
chmod 600 /etc/postfix/sasl_passwd
```

hash the file

```bash
postmap hash:/etc/postfix/sasl_passwd
```

check to to be sure the db file was create

```bash
cat /etc/postfix/sasl_passwd.db
```

edit postfix config

```bash
nano /etc/postfix/main.cf
```

```conf
# google mail configuration

relayhost = smtp.gmail.com:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/Entrust_Root_Certification_Authority.pem
smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
smtp_tls_session_cache_timeout = 3600s
```

reload postfix

```bash
postfix reload
```

send a test emails

```bash
echo "This is a test message sent from postfix on my Proxmox Server" | mail -s "Test Email from Proxmox" your-email@gmail.com
```

fix from name in email

install dependency

```bash
apt update
apt install postfix-pcre
```

edit config

```bash
nano /etc/postfix/smtp_header_checks
```

add the following text

```conf
/^From:.*/ REPLACE From: pve1-alert pve1-alert@something.com
```

hash the file

```bash
postmap hash:/etc/postfix/smtp_header_checks
```

check the contents of the file

```bash
cat /etc/postfix/smtp_header_checks.db
```

add the module to our postfix config

```bash
nano /etc/postfix/main.cf
```

add to the end of the file

```conf
smtp_header_checks = pcre:/etc/postfix/smtp_header_checks
```

reload postfix service

```bash
postfix reload
```

## Chapters

00:00 - Why you should set up alerts in Proxmox

01:42 - Micro Center / Free SSD (Sponsor)

02:56 - Where can I find the documentation

03:07 - Installing and configuring dependencies

03:54 - Google Email address configuration

08:43 - Configuring postfix and customizing the email alert

11:47 - Changing the mail sender name with pcre

14:20 - Configure where email alerts are sent

15:01 - Backup Alerts

17:33 - SMART alerts

18:53 - ZFS Alerts

19:52 - Testing in Production

24:03 - How Proxmox alerts could be better

25:30 - Stream Highlight - "Just some flashing lights & music"

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
