---
layout: post
title: "Remote Gaming! (and Video Encoding using Proxmox and GPU Passthrough)"
date: 2020-03-26 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes
image:
  path: /assets/img/headers/custom-pc.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AE/4Ka/GnWfh7+1V8drDR31+PTbr4uS2t9o9tr2nRaJqcFhoN5ot5Zatpl94Z1SHVNL1LQ/Eem2rabftcQ22oeHbXVY2d7pre3/q3GYmlQ4T4f8ArVGeNp/VMsm4/WKmGnGtVwilOrSq0VelzKnFNcsm1zR5+SbgelwpgcRieJM8eX46eVY2rQq+2xUcNhsbSxNKtUjSqUcRhcVBqcZyr1Jy5KtNXVNxjGpTjVP7Df2WNL8FeKP2Yv2cvE2oeAvCz3/iL4D/AAh129eXTLKeV7vV/h94e1C5aSdrRWmkaa4cvKyqZGJcqCcV+IcQ5xnGGz/PMNQzfM6dHD5xmdCjTjja6jClSxtenThFc+kYwiopdEj84weVZPisHhcVWynL5VsThqFerL6rRXNVrUo1KkrKFtZSbP8A/9k=
---

Are you looking to build a remote gaming machine and passthrough your GPU to a virtual machine?  Do you want to use GPU acceleration for transcoding Plex or Adobe Media Encoder?  Do you dream of setting up Steam Link or Remote Play In Home Streaming and streaming games to any screen in your house?  If so, this complete step-by-step guide of how to passthrough your Nvidia or AMD video card through to a guest VM using Proxmox VE!  If not, well, please watch this anyway.

{% include embed/youtube.html id='fgx3NMk6F54' %}

📺 [Watch Video](https://www.youtube.com/watch?v=fgx3NMk6F54)

edit grub

`/etc/default/grub`

Change this line:

`GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on pcie_acs_override=downstream,multifunction video=efifb:eek:ff"`

run

```bash
update-grub
```

reboot

```bash
reboot
```

Edit
`/etc/modules`

```bash
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

reboot

```bash
reboot
```

`/etc/pve/qemu-server/qm.conf` (will be something like `100.conf`)

```conf
agent: 1
balloon: 4096
bios: ovmf
boot: cdn
bootdisk: virtio0
cores: 8
cpu: host,hidden=1,flags=+pcid
efidisk0: fast1:vm-100-disk-1,size=128K
hostpci0: 02:00,pcie=1,x-vga=1
hostpci1: 04:00.0,rombar=0
ide0: none,media=cdrom
machine: q35
memory: 14336
name: beam
numa: 0
ostype: win10
scsihw: virtio-scsi-pci
smbios1: uuid=d6febb0d-4242-4bdb-8aea-7c03e7b5df0e
sockets: 1
unused0: storage1:vm-100-disk-0
unused1: slow1:vm-100-disk-0
virtio0: fast1:vm-100-disk-0,size=80G
vmgenid: 524a58dd-7e3e-44f4-abf4-9de0f490d936
```

Add your PCI device

edit `/etc/modprobe.d/pve-blacklist.conf`

```conf
blacklist nvidiafb
blacklist nvidia
blacklist radeon
blacklist nouveau
```

## Troubleshooting

If your Windows machine fails to boot, you may want to create a new Windows VM using UEFI rather than BIOS.

If your motherboard has onboard GPU set in BIOS to use the onboard primarily or exclusively to free up PCIE GPU

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
