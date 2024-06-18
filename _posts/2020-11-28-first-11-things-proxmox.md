---
layout: post
title: "Before I do anything on Proxmox, I do this first..."
date: 2020-11-28 09:00:00 -0500
categories: proxmox
tags: homelab proxmox homelab
image:
  path: /assets/img/headers/engine-start.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4M9KvNPs9C12C60xr24vo0js7kXS24sZYyg82SI2k73IHnbkjhnsSGX99JPGRGuFSlOdWjUjXnTjSbc6cVeNVO2ktV57qVt4cktX72BzLA4PLc1wFfJsHjsTmMaMcLmNeUliMsdNycpYdKLbcnJP3KlBS5eXEfWafLThydbngn/9k=

---

After setting up my Proxmox servers, there are a few things I do before I use them for their intended purpose.This ranges from updates, to storage, to networking and VLANS, to uploading ISOs, to clustering, and more.Join me as we pick up where the rest of the proxmox tutorials stop, and that's everything you need to do to make these production ready (and maybe a bonus item too).

{% include embed/youtube.html id='GoZaMgEgrHw' %}

📺 [Watch Video](https://www.youtube.com/watch?v=GoZaMgEgrHw)

## Updates

Edit `/etc/apt/sources.list`

### Proxmox Version 6.X

```bash
deb http://ftp.us.debian.org/debian buster main contrib

deb http://ftp.us.debian.org/debian buster-updates main contrib

# security updates
deb http://security.debian.org buster/updates main contrib

# not for production use
deb http://download.proxmox.com/debian buster pve-no-subscription
```

### Proxmox Version 7.X

(for a full guide on Proxmox 7, please [see this link](/posts/proxmox-7/))

```bash
deb http://ftp.debian.org/debian bullseye main contrib

deb http://ftp.debian.org/debian bullseye-updates main contrib

# security updates
deb http://security.debian.org/debian-security bullseye-security main contrib

# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
```

Edit `/etc/apt/sources.list.d/pve-enterprise.list`

```bash
# deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
```

### Proxmox Version 8.X

Create a file at `/etc/apt/sources.list.d/pve-no-enterprise.list` with the following contents:

```bash
# not for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
```

If you are using ceph

Create a file at `/etc/apt/sources.list.d/ceph.list` with the following contents:

```bash
# not for production use
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
```

_If you're looking to upgrade to Proxmox 8, [see this post](/posts/upgrade-proxmox-to-8/)_

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

BE CAREFUL.This will wipe your disks.

```bash
fdisk /dev/sda
```

Then P for partition, then D for delete, then W for write.

## Check SMART Monitoring

```bash
smartctl -a /dev/sda
```

## IOMMU (PCI Passthrough)

You'll first want to be sure that Vt-d / IOMMU is enabled in your BIOS before continuing.

> If see *"No IOMMU detected, please activate it.See Documentation for further information."* It means that IOMMU is not enabled in your BIOS or that it has not been enabled in Proxmox yet.  If you're seeing this and you've enabled it in your BIOS, you can enable it in Proxmox below.
{: .prompt-warning }

### Checking your boot manager

Enabling PCI passthrough depends on your boot manager.  You can check to see which one you are using by running

`efibootmgr -v`

If it returns an errors, it's running in Legacy/BIOS with GRUB, skip to GRUB section

if it returns something like this, it's running `system-boot`, skip to `system-d` section section

```bash
Boot0002* proxmox	HD(2,GPT,b0f10348-020c-4bd6-b002-dc80edcf1899,0x800,0x100000)/File(\EFI\proxmox\shimx64.efi)
```

if it returns something like this.

```bash
Boot0006 * Linux Boot Manager [...] File(EFI\systemd\systemd-bootx64.efi)
```

### GRUB

If you're using GRUB, use the following commands:

`nano /etc/default/grub`

add `iommu=pt` to `GRUB_CMDLINE_LINUX_DEFAULT` like so:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"
```

If you aren't using an intel processor, remove `intel_iommu=on`

### system-boot

If you're using `system-boot` use the following commands.

`nano /etc/kernel/cmdline`

add `intel_iommu=on iommu=pt` to the end of this line without line breaks

```bash
root=ZFS=rpool/ROOT/pve-1 boot=zfs intel_iommu=on iommu=pt
```

If you aren't using an intel processor, remove `intel_iommu=on`

run

```bash
pve-efiboot-tool refresh
```

then reboot

```bash
reboot
```

### VFIO modules

Edit `/etc/modules`

```bash
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

run

```bash
update-initramfs -u -k all
```

then reboot

```bash
reboot
```

### NVIDIA

If you're planning on using an NVIDIA card, I've found this helps prevent some apps like GPUz from crashing on the VM.

```bash
echo "options kvm ignore_msrs=1 report_ignored_msrs=0" > /etc/modprobe.d/kvm.conf
```

### Still having trouble?

See [Proxmox PCI Passthrough](https://pve.proxmox.com/wiki/Pci_passthrough)

## VLAN Aware

If you want to restrict your VLANS

```bash
nano /etc/network/interfaces
```

Set your VLAN here

```bash
bridge-vlan-aware yes
bridge-vids 20
```

## NIC Team Example

```bash
nano /etc/network/interfaces
```

```conf
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

**If you're running Proxmox 7, see the modified [config here](/posts/proxmox-7/) for LAGG / LACP**

## Cloning

These are the commands I run after cloning a Linux machine so that it resets all information for the machine it was cloned from.

(Note: If you use cloud-init-aware OS images as described under *Cloud-Init Support* on <https://pve.proxmox.com/pve-docs/chapter-qm.html>, these steps won't be necessary!)

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

## Alerts

I've added yet another item to my list when setting up a new Proxmox server, and [that's setting up alerts!](/posts/proxmox-alerts/)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
