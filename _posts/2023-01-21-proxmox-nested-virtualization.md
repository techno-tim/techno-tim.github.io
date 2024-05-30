---
layout: post
title: "Enable Nested Virtualization In Proxmox"
date: 2023-01-21 10:00:00 -0500
categories: proxmox
tags: homelab proxmox virtualization
image:
  path: /assets/img/headers/nested-eggs.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APc/Hvw88KWn7d/xf0680HRdc1T4pReFvFFp4m1u0vbzV/BEniL4ZeDpb6x0CIanFpMkNlfaf52jXVzpv26zs7l9LvLjUrOCzW3+gyjNsry3I8yoS4fwmLx2IxFV0syq15xqYejiKGGhGjGgqcqclQl+8ozUqcouU425XFR+L4i4R4izvjHIs0wfHWZ5LkmXUcL9d4awuAw9XD5pXwGOxOIlWnjnXpV6EcbRqfVMXR9nXp1KdOlJWnF837EaaLbwtp9h4Zi0+xuovDlla6FFc4vLb7RHpECaek/2eO9dIPNW3Enko7pFu2KzBQTw0YwdKk7NXpwdk1ZXinZe7suh9tUTVSav9uW6u93u7q77uyP/2Q==

---

## What Is Nested Virtualization?

**Nested Virtualization** is a feature that allows you to run a virtual machine within a virtual machine while still using hardware acceleration from the host machine.Put simply, it allows you to run a vm inside of a vm.

## Enabling Nested Virtualization In Proxmox

Everything we do will be done on the host system running Proxmox.Once enabled, the guest can take advantage of it.

First we need to check to see if nested virtualization is enabled in Proxmox.

If you're running an **Intel CPU** run this command:

```bash
cat /sys/module/kvm_intel/parameters/nested
```

If you're running an **AMD CPU** run this command:

```bash
cat /sys/module/kvm_amd/parameters/nested
```

You should see an output of **Y** or **N**.If **N** this means that nested virtualization is not enabled, so let's enabled it!

On the Proxmox host, run the following command as **root**:

If you're running an **Intel CPU** run this command:

```bash
echo "options kvm-intel nested=Y" > /etc/modprobe.d/kvm-intel.conf
```

If you're running an **AMD CPU** run this command:

```bash
echo "options kvm-amd nested=1" > /etc/modprobe.d/kvm-amd.conf 
```

Next reboot the system

```bash
reboot
```

Then check to see if nexted virtualization is enabled on the Proxmox host:

If you're running an **Intel CPU** run this command:

```bash
cat /sys/module/kvm_intel/parameters/nested
```

If you're running an **AMD CPU** run this command:

```bash
cat /sys/module/kvm_amd/parameters/nested
```

You should see **Y** this time.This means that you can now using virtualization inside of a VM, just be sure to set your VM's processor accordingly! (use HOST for CPU type)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
