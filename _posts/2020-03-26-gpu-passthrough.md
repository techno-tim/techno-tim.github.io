---
layout: post
title: "Remote Gaming! (and Video Encoding using Proxmox and GPU Passthrough)"
date: 2020-03-26 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes
---

[![Remote Gaming! (and Video Encoding using Proxmox and GPU Passthrough)](https://img.youtube.com/vi/fgx3NMk6F54/0.jpg)](https://www.youtube.com/watch?v=fgx3NMk6F54 "Remote Gaming! (and Video Encoding using Proxmox and GPU Passthrough)")


Are you looking to build a remote gaming machine and passthrough your GPU to a virtual machine?  Do you want to use GPU acceleration for transcoding Plex or Adobe Media Encoder?  Do you dream of setting up Steam Link or Remote Play In Home Streaming and streaming games to any screen in your house?  If so, this complete step-by-step guide of how to passthrough your Nvidia or AMD video card through to a guest VM using Proxmox VE!  If not, well, please watch this anyway.  

[Watch Video](https://www.youtube.com/watch?v=fgx3NMk6F54)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

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

```
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

