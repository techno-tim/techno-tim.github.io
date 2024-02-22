---
layout: post
title: "Deploying Machines with MaaS and Packer - Metal as a Service + Hashicorp Packer Tutorial"
date: 2023-01-28 09:00:00 -0500
categories: maas
tags: homelab packer maas hashicorp canonical ubuntu proxmox open-source
image:
  path: /assets/img/headers/metal-packer.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5YtN+KHh7w18KD4esPhzo7+Kpjolnpvjea7g+0aZozaI8epac2jRaNHbalLqd29tftf3128tlcQTyWUcM2p6jPcf17wh4hY3gbh3GYbJspyiVfMacMJPG4zD+3rUKUsLh2vYU17Ohz+7WcpVadVylXnNOM1zP8O4n4FwnGGc4LEZpmma06GAk8TDBYLEfV6NaosTVl++qNVK3InyKMKM6UeSmoVFUioqHxhcSTSTzSM6bnmkdv3KdWdmPQAdT2AHtX4zXzvMqtetVnVpudSrUqSfsKespzcpPbu2fqFLLMJSpU6cIzUKdOEIr2k3aMIqMVe+tkkf/Z
---

MaaS or Metal as a service from Canonical is a great way to provision bare metal machines as well as virtual machines.MaaS allows you to deploy Windows, Linux, ESXi, and many other operating systems to your systems helping you to build a bare metal cloud.You can even use Packer from Hashicorp to configure custom images too!  We'll cover all of this and more in this tutorial on how to install and configure MaaS from start to finish with Packer!

{% include embed/youtube.html id='lEqD3mRcqSo' %}
📺 [Watch Video](https://www.youtube.com/watch?v=lEqD3mRcqSo)

## Sponsor

New Customer Exclusive - $25 Off ALL Processors: <https://micro.center/3si>

Check out Micro Center's Custom PC Builder: <https://micro.center/wcx>

Submit your build to Micro Center's Build Showcase: <https://micro.center/dcm>

Visit Micro Center's Community Page: <https://micro.center/2vr>

## Installing MaaS

MaaS can be installed via `apt` or `snap`.I had some issues with the `apt` version so I used `snap` for this install.

### snap install

Be sure `snap` is installed

```bash
sudo apt install snapd
```

```bash
sudo snap install --channel=3.2 maas
```

### apt install

```bash
sudo apt-add-repository ppa:maas/3.2
sudo apt update
sudo apt install maas
```

### Installing a Test Database

(skip this step if you already have postgres in your environment)

This should be used if you want to use MaaS test database

```bash
sudo snap install maas-test-db
```

testing the database

```bash
sudo maas-test-db.psql
```

then list databases you should see `maasdb` there

```bash
postgres=# \l
```

### Initializing MaaS

If you are using the test database above, initialize MaaS

```bash
sudo maas init region+rack --database-uri maas-test-db:///

```

If you already have postgres in your environment you can initialize MaaS using your existing postgres service.Be sure to create the database, user, and assign that user permissions before running the init command.

```bash
sudo maas init region+rack --database-uri "postgres://username:password@192.168.0.100/maas" # replace username /password / ip /db name
```

> if you don't wand to store your secrets in your terminal's history, consider using ENV variables:
{: .prompt-info }

```bash
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```

### Create admin account

```bash
sudo maas createadmin
```

Here you can choose to import your LaunchPad or GitHub public key using `gh:githubusername`

### Checking MaaS

```bash
sudo maas status
```

The output should like something similar to this:

```bash
bind9                            RUNNING   pid 1014, uptime 2 days, 10:52:40
dhcpd                            STOPPED   Not started
dhcpd6                           STOPPED   Not started
http                             RUNNING   pid 1477, uptime 2 days, 10:52:23
ntp                              RUNNING   pid 1143, uptime 2 days, 10:52:37
proxy                            RUNNING   pid 1454, uptime 2 days, 10:52:25
rackd                            RUNNING   pid 1017, uptime 2 days, 10:52:40
regiond                          RUNNING   pid 1018, uptime 2 days, 10:52:40
syslog                           RUNNING   pid 1144, uptime 2 days, 10:52:37
```

If you ever need to reinitialize MaaS

```bash
sudo maas init region
```

### Configuring Packer Images

#### Install Packer

Get key ring

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

Add keyring

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release --codename --short) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

add Hashicorp Repo

```bash
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
```

Install Packer

```bash
sudo apt update
sudo apt install packer
```

Update and install dependencies needed to build images

```bash
sudo apt update
sudo apt install qemu-utils qemu-system ovmf cloud-image-utils make curtain git
```

#### Building a custom image from `canonical/packer-maas`

Clone the `canonical/packer-maas` repo

```bash
git clone https://github.com/canonical/packer-maas.git

```

```bash
cd packer-maas
cd ubuntu
sudo packer init ubuntu-cloudimg.pkr.hcl
sudo make custom-cloudimg.tar.gz
```

check and change permissions of archive (change `root` to your username)

```bash
ls -l
sudo chown root:root ./custom-cloudimg.tar.gz
```

#### Uploading Packer image to MaaS

echo your MaaS api key to your home directory

```bash
sudo maas apikey --username=massadmin > ~/api-key-file
```

You can check with with

```bash
cat ~/api-key-file
```

Authenticate to MaaS with your api key

```bash
maas login massadmin http://localhost:5240/MAAS/api/2.0/ $(head -1  ~/api-key-file)
```

Upload the custom image we made to MaaS

```bash
maas massadmin boot-resources create name='custom/cloudimg-tgz' title='Ubuntu Custom TGZ' architecture='amd64/generic' filetype='tgz' content@=custom-cloudimg.tar.gz
```

## Chapters

00:00 - What is MaaS (Metal as a Service) from Canonical?

02:00 - Micro Center / $25 Off CPUs! (Sponsor)

03:00 - Installing MaaS

06:56 - Initial MaaS Configuration

09:41 - Importing your SSH Key

10:23 - Networking Configuration & Discovery

14:05 - PXE & Network Boot with DHCP

15:33 - Commissioning a Machine (Initial Discovery)

18:45 - Power Types & Wake on LAN (WOL)

20:50 - Commissioning a Machine Part 2 (For real this time)

24:00 - Deploying Ubuntu

26:15 - SSH in to machine

26:54 - Creating Custom Images with Hashicorp Packer

33:40 - Uploading a Custom Image to MaaS

38:05 - What do I think of MaaS from Canonical?

39:57 - Stream Highlight - "100 + 50 subs dropped 🫳🎤"

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">This past week I learned how to solve the challenge of imaging bare metal machines. I settled on MaaS (Metal as a Service) and custom images with Hashicorp Packer. This is the missing link for automation in my <a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <br><br>Check out the video here 👇<a href="https://t.co/5rhHtwaLi4">https://t.co/5rhHtwaLi4</a> <a href="https://t.co/KgeYCgYzgt">pic.twitter.com/KgeYCgYzgt</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1619379651494940674?ref_src=twsrc%5Etfw">January 28, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
