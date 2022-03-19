---
layout: post
title: "Perfect Proxmox Template with Cloud Image and Cloud Init"
date: 2022-03-19 10:00:00 -0500
categories: proxmox
tags: proxmox ubuntu cloud-image cloud-init cloud clone linux
---

[![Perfect Proxmox Template with Cloud Image and Cloud Init](https://img.youtube.com/vi/shiIi38cJe4/0.jpg)](https://www.youtube.com/watch?v=shiIi38cJe4 "Perfect Proxmox Template with Cloud Image and Cloud Init")

Using Cloud Images and Cloud Init with Proxmox is easy, fast, efficient, and fun!  Cloud Images are small images that are certified cloud ready that have Cloud Init preinstalled and ready to accept a Cloud Config.  Cloud Images and Cloud Init also work with Proxmox and if you combine the two you have a perfect, small, efficient, optimized clone template to provision machines with your ssh keys and network settings.  So join me as we discuss, set up, and configure Proxmox with Cloud Images and Cloud Init.

📺 [Watch Video](https://www.youtube.com/watch?v=shiIi38cJe4)

## Intructions

Choose your [Ubuntu Cloud Image](https://cloud-images.ubuntu.com/)

Download Ubuntu (replace with the url of the one you chose from above)

```bash
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img
```

Create a new virtual machine

```bash
qm create 8000 –-name ubuntu-cloud --memory 2048 --net0 virtio,bridge=vmbr0
```

Import the downloaded Ubuntut disk to local-lvm storage

```bash
qm importdisk 8000 focal-server-cloudimg-amd64.img local-lvm
```

Attach the new disk to the vm as a scsi drive on the scsi controller

```bash
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
```

Add cloud init drive

```bash
qm set 8000 --ide2 local-lvm:cloudinit
```

Make the clud init drive bootable and restrict BIOS to boot from disk only

```bash
qm set 8000 --boot c --bootdisk scsi0
```

Add serial console

```bash
qm set 8000 --serial0 socket --vga serial0
```

**DO NOT START YOUR VM**

Now, configure hardware and cloud init, then create a template and clone.  If you want to expand your hard drive you can on this base image before creating a template or after you clone a new machine.  I pefere to expand the hard drive after I clone a new machine based on need.

## Troubleshooting

If you need to reset your machine-id

```bash
sudo rm -f /etc/machine-id
sduo rm -f /var/lib/dbus/machine-id
```

Then shut it down and do not boot it up

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
