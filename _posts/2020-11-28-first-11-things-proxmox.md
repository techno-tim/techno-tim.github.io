---
layout: post
title: "Before I do anything on Proxmox, I do this first..."
date: 2020-11-28 09:00:00 -0500
categories: proxmox
tags: homelab proxmox homelab
---

[![Before I do anything on Proxmox, I do this first...](https://img.youtube.com/vi/GoZaMgEgrHw/0.jpg)](https://www.youtube.com/watch?v=GoZaMgEgrHw "Before I do anything on Proxmox, I do this first...")

After setting up my Proxmox servers, there are a few thigns I do before I use them for their intended purpose.  This ranges from updates, to storage, to networking and VLANS, to uploading ISOs, to clustering, and more.  Join me as we pick up where the rest of the proxmox tutorials stop, and that's everything you need to do to make these production ready (and maybe a bonus item too).


[Watch Video](https://www.youtube.com/watch?v=GoZaMgEgrHw)


## Updates
Edit `/etc/apt/sources.list`

```
deb http://ftp.us.debian.org/debian buster main contrib

deb http://ftp.us.debian.org/debian buster-updates main contrib

# security updates
deb http://security.debian.org buster/updates main contrib

# not for production use
deb http://download.proxmox.com/debian buster pve-no-subscription
```


Edit `/etc/apt/sources.list.d/pve-enterprise.list`

```
# deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
```


Run

```bash
apt-get update
```

```bash
apt dist-upgrade
```

```bash
reboot
```

## Storage


BE CAREFUL.  This will wipe your disks.

```bash
fdisk /dev/sda
```

Then P for partition, then D for delete, then W for write.

## Check SMART Monitoring

```bash
smartctl -a /dev/sda
```

## IOMMU (PCI Passthrough)

See [Proxmox PCI Passthrough](https://pve.proxmox.com/wiki/Pci_passthrough)

`nano /etc/default/grub`

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
```

`update-grub`

Edit `/etc/modules`

```
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

`reboot`

## VLAN Aware

If you want to restrict your VLANS

```bash
nano /etc/network/interfaces
```

Set your VLAN here
```
bridge-vlan-aware yes
bridge-vids 20
```

## NIC Team Example

```bash
nano /etc/network/interfaces
```

```
auto eno1
iface eno1 inet manual

auto eno2
iface eno2 inet manual

auto bond0
iface bond0 inet manual
        bond-slaves eno1 eno2
        bond-miimon 100
        bond-mode 802.3ad
        bond-xmit-hash-policy layer2+3

auto vmbr0
iface vmbr0 inet static
        address 192.168.0.11/24
        gateway 192.168.0.1
        bridge-ports bond0
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094
#lacp nic team
```

## Cloning

These are the commands I run after cloning a Linux machine so that it resets all information for the machine it was cloned from.

change hostname

```bash
sudo nano  /etc/hostname
```

* find your hostname and change it

change hosts file

* find your hostname and change it

```bash
sudo nano /etc/hosts
```

reset machine ID

```bash
rm -f /etc/machine-id /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
dbus-uuidgen --ensure
```

regenerate ssh keys

```bash
regen ssh keys
sudo rm /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server

```


reboot