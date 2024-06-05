---
layout: post
title: "Perfect Proxmox Template with Cloud Image and Cloud Init"
date: 2022-03-19 10:00:00 -0500
categories: proxmox
tags: proxmox ubuntu cloud-image cloud-init cloud clone linux
image:
  path: /assets/img/headers/cloud-moon.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APs3xx/wTI/ZZ8R/tP8A7Pl14e8Eab4L8GReHfFes+MPh3ptkt54d8Zp4A1DRxoltdmeeGS1lv59XdPEt5cJqp1zTbaGykgt7hpdRf8AXMp8VeKcNwhxPTxOJljsdPEYGhl+aVZKnisueZ08R9YnT5abjUVKOHX1SEXRWGqzlUUpRUaS/Ac+8GOEMXx3wfVweHWWZbTwuY4nNMmoQlUwebRyieDlhadRzqxlSlVqYtrHVZLEfW8PTjRlCE5Srv8AUGL9kb9n+GKOK1+EXwltbaKNI7e2i+FPgERW8CKFigjB0PPlxRhY0zztUV+SS4p4icpOWeZxKTk3KTzTHNybd22/b6tvV+Z+2R4R4WhGMI8OZFGMYqMYrKMuSjGKskl9W0SSsl2P/9k=

---

Using Cloud Images and Cloud Init with Proxmox is easy, fast, efficient, and fun!  Cloud Images are small images that are certified cloud ready that have Cloud Init preinstalled and ready to accept a Cloud Config.Cloud Images and Cloud Init also work with Proxmox and if you combine the two you have a perfect, small, efficient, optimized clone template to provision machines with your ssh keys and network settings.So join me as we discuss, set up, and configure Proxmox with Cloud Images and Cloud Init.

{% include embed/youtube.html id='shiIi38cJe4' %}

📺 [Watch Video](https://www.youtube.com/watch?v=shiIi38cJe4)

## Instructions

Choose your [Ubuntu Cloud Image](https://cloud-images.ubuntu.com/)

Download Ubuntu (replace with the url of the one you chose from above)

```bash
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
```

Create a new virtual machine

```bash
qm create 8000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
```

Import the downloaded Ubuntu disk to `local` storage (Change `local` to the storage of your choice)

```bash
qm disk import 8000 noble-server-cloudimg-amd64.img local
```

Attach the new disk to the vm as a scsi drive on the scsi controller (Change `local` to the storage of your choice)

```bash
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local:vm-8000-disk-0
```

Add cloud init drive ((Change `local` to the storage of your choice)

```bash
qm set 8000 --ide2 local:cloudinit
```

Make the cloud init drive bootable and restrict BIOS to boot from disk only

```bash
qm set 8000 --boot c --bootdisk scsi0
```

Add serial console

```bash
qm set 8000 --serial0 socket --vga serial0
```

**DO NOT START YOUR VM**

Now, configure hardware and cloud init, then create a template and clone.If you want to expand your hard drive you can on this base image before creating a template or after you clone a new machine.I prefer to expand the hard drive after I clone a new machine based on need.

Create template.

```bash
qm template 8000
```

Clone template.

```bash
qm clone 8000 135 --name yoshi --full
```

## Troubleshooting

If you need to reset your machine-id

```bash
sudo rm -f /etc/machine-id
sudo rm -f /var/lib/dbus/machine-id
```

Then shut it down and do not boot it up.A new id will be generated the next time it boots.If it does not you can run:

```bash
sudo systemd-machine-id-setup
```

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
