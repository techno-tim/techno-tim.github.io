---
layout: post
title: "Enable Nested Virtualization In Proxmox"
date: 2023-01-21 10:00:00 -0500
categories: proxmox
tags: homelab proxmox virtualization
image:
  path: /assets/img/headers/nested-eggs.jpg
---

## What Is Nested Virtualization?

**Nested Virtualization** is a feature that allows you to run a virtual machine within a virtual machine while still using hardware acceleration from the host machine.  Put simply, it allows you to run a vm inside of a vm.

## Enabling Nested Virtualization In Proxmox

Everything we do will be done on the host system running Proxmox.  Once enabled, the guest can take advantage of it.

First we need to check to see if nested virtualization is enabled in Proxmox.

If you're running an **Intel CPU** run this command:

```bash
cat /sys/module/kvm_intel/parameters/nested
```

If you're running an **AMD CPU** run this command:

```bash
cat /sys/module/kvm_amd/parameters/nested
```

You should see an output of **Y** or **N**.  If **N** this means that nested virtualization is not enabled, so let's enabled it!

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

You should see **Y** this time.  This means that you can now using virtulization inside of a VM, just be sure to set your VM's processor accordingly! (use HOST for CPU type)

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
