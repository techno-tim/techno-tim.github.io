---
layout: post
title: "Pi-hole Syncing… But Smarter..."
date: 2025-03-20 08:00:00 -0500
categories: homelab
tags: homelab pihole self-hosted
image:
 path: /assets/img/headers/pihole-sync-nebula-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyC/YF+PPwx8KfsJ/FjWrr9lH4JavqPgbwpZy67qYufH9trnxGuYdCHhSwk8Sa5feLdZ1HSLT+0Wi8WarongyXw1oN9rRvG0/S9FF1HJa/nWYZnh8DnzymrlOAx2IzydLC4PMMVGdWeUypYinXniKVCq6qnWrRqVKdSphKuW1akfYxrVa1ChDDn9OcPZBmWL4X4T4py/inO8mp5NDG4jGZRg50YYXMo0KMoxop0IYalGmqcIQpwzbC57SoydarSpRq4irN/z0+INWj1fXtb1aHStO0eHU9X1LUYtI00XkunaVHe3k1ymm2Eur3eqarJZWKyi1tZNT1PUdQeCKNr2+u7ky3En39KlTjSpxUdI04RXvVNlFJbzb+9v1PyHFYqpVxOIq1Hz1KlerUnOUKHNKc6kpSk+WhGN5Sbb5Yxjd6RS0P/2Q==
---

Running multiple Pi-hole servers has always been a challenge, until now. In this video, I’ll show you a tool called Nebula Sync that helps keep them in sync, making DNS and blocklist management much easier. I'll walk through how it works, how to set it up, how to choose the right settings, and why it might be useful for your network.

{% include embed/youtube.html id='OcSBggDyeJ4' %}
📺 [Watch Video](https://www.youtube.com/watch?v=OcSBggDyeJ4)

## Info

Don't forget to give these repos a star!

- <https://github.com/pi-hole/pi-hole>
- <https://github.com/lovelaze/nebula-sync>

What you'll need to get started

- 2 fully working [Pi-hole servers](https://pi-hole.net/)
- [Docker running](/posts/docker-compose-install/) somewhere in your environment

Also, I mentioned that I would show you how to reset your Pi-hole password in the video, but never showed how 😅.

Here's how:

ssh into your Pi-hole server.

```bash
sudo pihole setpassword
```

Your password will instantly be updated.

## Upgrading from Pi-Hole 5 + Gravity Sync

> *Note: Pi-Hole 6 is not compatible with `gravity-sync` so if you're using Pi-Hole 5 or `gravity-sync` please follow this first*
{: .prompt-warning }

DO NOT UPGRADE TO PI-HOLE 6 YET

Uninstall `gravity-sync` by running:

```bash
gravity-sync purge
```

This should remove `gravity-sync`

Personally I would reboot the server afterwards and run `gravity-sync` command afterwards to be sure it's fully remove.  You should get an error like `command not found: gravity-sync`, which means it's fully removed.

Next I take a backup of your Pi-Hole instance and even export your config with Teleporter just to be sure.

Upgrade to Pi-Hole 6.  Test it, reboot it, make sure it works.

Do this for each Pi-Hole 5 instance you have.

Then continue on with this tutorial.

## Install Docker

To install docker, see [this post](/posts/docker-compose-install/)

## Instructions

ssh into server.

I usually put my stacks into `/opt/stacks`.

Make a new directory for Nebula Sync and `cd` into it.

```bash
mkdir nebula-sync
cd nebula-sync
```

Create our compose file.

```bash
nano compose.yaml
```

Inside of our `compose.yaml` paste:

```yaml
---
services:
  nebula-sync:
    image: ghcr.io/lovelaze/nebula-sync:latest
    container_name: nebula-sync
    restart: unless-stopped
    env_file: .env
```

Create our `.env` with our variables.

Replace with your server IPs, passwords, timezone, and how frequently you want so run this sync job.

```bash
PRIMARY="https://192.168.60.10|abc123"  # Be sure to add quotes if you have special characters
REPLICAS="https://192.168.60.26|abc123,https://10.0.200.5|abc123,https://10.0.200.6|abc123" # Be sure to add quotes if you have special characters
FULL_SYNC=false
RUN_GRAVITY=false
CRON=*/15 * * * *

CLIENT_SKIP_TLS_VERIFICATION=true

TZ=America/Chicago

SYNC_CONFIG_DNS=true
SYNC_CONFIG_DHCP=false
SYNC_CONFIG_NTP=false
SYNC_CONFIG_RESOLVER=false
SYNC_CONFIG_DATABASE=false
SYNC_CONFIG_MISC=false
SYNC_CONFIG_DEBUG=false

SYNC_GRAVITY_DHCP_LEASES=false
SYNC_GRAVITY_GROUP=false
SYNC_GRAVITY_AD_LIST=true
SYNC_GRAVITY_AD_LIST_BY_GROUP=true
SYNC_GRAVITY_DOMAIN_LIST=true
SYNC_GRAVITY_DOMAIN_LIST_BY_GROUP=true
SYNC_GRAVITY_CLIENT=false
SYNC_GRAVITY_CLIENT_BY_GROUP=false
```

Start our compose stack interactively to monitor logs.

```bash
docker compose up
```

Start our compose stack as a daemon.

```bash
docker compose up -d
```

Checking for the running container

```bash
docker ps | grep nebula
```

Check container logs

```bash
docker logs nebula-sync
```

If you don't want to use Docker Compose and want to use the Docker CLI you can run this command:

```bash
docker run \
  --restart unless-stopped \
  --name=nebula-sync \  
  --env-file .env \
  ghcr.io/lovelaze/nebula-sync:latest
```

### Blocklists

Here is the list of blocklists that I use.  Use these with caution and prepare to add exceptions for sites you may need.

Most of these were collected from <https://firebog.net/>

```bash
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://mirror1.malwaredomains.com/files/justdomains
https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts_without_controversies.txt
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
https://v.firebog.net/hosts/static/w3kbl.txt
https://adaway.org/hosts.txt
https://v.firebog.net/hosts/Prigent-Ads.txt
https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt
https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt
https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser
https://phishing.army/download/phishing_army_blocklist_extended.txt
https://v.firebog.net/hosts/AdguardDNS.txt
https://v.firebog.net/hosts/Admiral.txt
https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
https://v.firebog.net/hosts/Easylist.txt
https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts
https://v.firebog.net/hosts/Easyprivacy.txt
https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
https://urlhaus.abuse.ch/downloads/hostfile/
https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt
https://v.firebog.net/hosts/Prigent-Malware.txt
https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt
https://someonewhocares.org/hosts/zero/hosts
https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt
https://v.firebog.net/hosts/Prigent-Crypto.txt
https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt
https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt
https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt
https://v.firebog.net/hosts/Shalla-mal.txt
https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt
https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts
https://winhelp2002.mvps.org/hosts.txt
https://v.firebog.net/hosts/neohostsbasic.txt
https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt
https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
https://phishing.army/download/phishing_army_blocklist.txt
https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt
https://malware-filter.gitlab.io/malware-filter/phishing-filter-hosts.txt
https://v.firebog.net/hosts/RPiList-Malware.txt
https://v.firebog.net/hosts/RPiList-Phishing.txt
https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Tired of the Internet going down when you reboot your Pi-Hole server?<a href="https://t.co/sKfXYhK8qf">https://t.co/sKfXYhK8qf</a> <a href="https://t.co/skFjb1sVMd">pic.twitter.com/skFjb1sVMd</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1903141385735188712?ref_src=twsrc%5Etfw">March 21, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
