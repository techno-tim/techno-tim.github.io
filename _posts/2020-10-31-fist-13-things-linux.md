---
layout: post
title: "Before I do anything on Linux, I do these first..."
date: 2020-10-31 09:00:00 -0500
categories: homelab
tags: homelab linux ubuntu
---

[![Before I do anything on Linux, I do these first...](https://img.youtube.com/vi/ZsjK4VDopiE/0.jpg)](https://www.youtube.com/watch?v=ZsjK4VDopiE "Before I do anything on Linux, I do these first...")

After setting up my Linux servers, there are a few things I do before I use them for their intended purpose.  This ranges from security, to tools, to config.  Join me as we set up our first Linux server in this tutorial and walk through setting it up proper (and maybe some bonus items sprinkled in).

[Watch Video](https://www.youtube.com/watch?v=ZsjK4VDopiE)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

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
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
```

```bash
exit
```

```bash
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
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
