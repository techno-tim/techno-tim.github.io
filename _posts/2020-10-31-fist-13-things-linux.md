---
layout: post
title: "Before I do anything on Linux, I do these first..."
date: 2020-10-31 09:00:00 -0500
categories: homelab
tags: homelab linux ubuntu
image:
  path: /assets/img/headers/penguin-looking.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyO1D/gvr+1HrekaWsXwt+Buj3vhy9ltdQuNO0bxS1t4mxp9xpqf2nY33ie7FrAktzHqgt9Lns/+JhaQ/vRZF7NjL8rrVKUK1TMsU4y0VNRpx5WlGTfPZ3TXu2cet23pb0sXmVGE3COAoKUG7yc6jUldxScLq3dtS12VloefS/8Fwv2mZpJJX+Fv7PxeV3kc/8ACK+L+WdizH/kee5JrreWTu/9vxi125qf/wAgcaxsGk/qWG2/6e//ACw//9k=
---

After setting up my Linux servers, there are a few things I do before I use them for their intended purpose.This ranges from security, to tools, to config.Join me as we set up our first Linux server in this tutorial and walk through setting it up proper (and maybe some bonus items sprinkled in).

{% include embed/youtube.html id='ZsjK4VDopiE' %}

📺 [Watch Video](https://www.youtube.com/watch?v=ZsjK4VDopiE)

## Update

```bash
sudo apt-get update

sudo apt-get upgrade
```

Reconfigure unattended-upgrades

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

Verify unattended upgrades configuration file in your text editor of choice

```bash
/etc/apt/apt.conf.d/20auto-upgrades
```

To disable automatic reboots by the automatic upgrades configuration edit the following file:

```bash
/etc/apt/apt.conf.d/50unattended-upgrades
```

and uncomment the following line by removing the leading slashes:

```bash
//Unattended-Upgrade::Automatic-Reboot "false";
```

## Account

add user

```bash
sudo adduser someuser
```

add to sudoers

```bash
sudo usermod -aG sudo someuser
```

## SSH Server

install

```bash
sudo apt-get install openssh-server
```

copy key from client to server

```bash
ssh-copy-id someuser@192.168.0.100
```

switch to key based auth

```bash
sudo nano /etc/ssh/sshd_config
```

Add these attributes

```bash
PasswordAuthentication no
ChallengeResponseAuthentication no
```

## Networking

static IP

`sudo nano /etc/netplan/01-netcfg.yaml`

```yml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
     dhcp4: no
     addresses:
        - 192.168.0.222/24
     gateway4: 192.168.0.1
     nameservers:
       addresses: [192.168.0.4]
```

## Install `oh-my-zsh`

```bash
sudo apt-get update
sudo apt-get install zsh
sudo apt-get install powerline fonts-powerline

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Fix LVM

```bash
sudo lvm
```

```bash
lvscan
```

You should see your logical volumes

```bash
lvm> lvscan
  ACTIVE            '/dev/vgubuntu-server/root' [<168.54 GiB] inherit
  ACTIVE            '/dev/vgubuntu-server/swap_1' [980.00 MiB] inherit
```

resize the logical volume group, usually the first one in the list but check to be sure!

```bash
lvextend -l +100%FREE /dev/vgubuntu-server/root
```

You should see:

```bash
  Size of logical volume vgubuntu-server/root changed from <138.54 GiB (35466 extents) to <168.54 GiB (43146 extents).
  Logical volume vgubuntu-server/root successfully resized
```

```bash
exit
```

resize the file system

```bash
sudo resize2fs /dev/vgubuntu-server/root
```

Check to see file system size

```bash
df -h
```

You should see:

```bash
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              1.6G  3.9M  1.6G   1% /run
/dev/mapper/vgubuntu--server-root  166G   89G   70G  56% /
tmpfs                              7.9G     0  7.9G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda1                          511M  4.0K  511M   1% /boot/efi
tmpfs                              1.6G     0  1.6G   0% /run/user/1000
```

You should see:

```bash
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/vgubuntu-server/root is mounted on /; on-line resizing required
old_desc_blocks = 18, new_desc_blocks = 22
The filesystem on /dev/vgubuntu-server/root is now 44181504 (4k) blocks long.
```


## hostname

```bash
sudo hostnamectl set-hostname
```

```bash
sudo nano /etc/hosts
```

## Time Zone

Check time zone:

```bash
timedatectl
```

Change time zone:

```bash
sudo timedatectl set-timezone
```

You can also use if you want a menu.

```bash
sudo dpkg-reconfigure tzdata 
```

## NTP Time

```bash
sudo nano /etc/systemd/timesyncd.conf
```

```conf
NTP=192.168.0.4
```

```bash
sudo timedatectl set-ntp off
```

```bash
sudo timedatectl set-ntp on
```

## install kvm agent

```bash
sudo apt-get install qemu-guest-agent
```

## firewall

```bash
sudo  ufw default deny incoming
```

```bash
sudo ufw default allow outgoing
```

```bash
sudo ufw allow ssh
```

```bash
sudo ufw enable
```

## fail2ban

```bash
sudo apt-get install fail2ban
```

```bash
sudo cp /etc/fail2ban/fail2ban.{conf,local}
```

```bash
sudo cp /etc/fail2ban/jail.{conf,local}
```

```bash
sudo nano /etc/fail2ban/jail.local
```

```conf
backend = systemd
```

check status

```bash
sudo fail2ban-client status
```

```bash
sudo fail2ban-client status sshd
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
