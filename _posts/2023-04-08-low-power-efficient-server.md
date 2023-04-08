---
layout: post
title: "Building a Low Power, All-in-One, Silent Server"
date: 2023-04-08 10:00:00 -0500
categories: homelab
tags: homelab proxmox pfsense ubuntu windows truenas hardware plex portainer docker
image:
  path: /assets/img/headers/terrarium-multiple.jpg
---

What if I told you that this little machine is the perfect Proxmox Virtualization server?  And what if I told you I crammed an intel core i5, 64 GB of RAM, a 1 TB NVMe SSD, another 1TB SSD all in this tiny little box that’s dead silent without any fans?  And what if I told you it can run Proxmox Virtual Server, host a pfsense router, runTrueNAS with a TB of storage, run Ubuntu server with Portainer running a few docker containers, run Windows 10 or Windows 11, and run ubuntu Desktop and pass though all of the hardware so I can use this server as a desktop, all while running a Plex Server and doing hardware transcoding with 3 - 4k streams?

> No Way!

Yeah, I thought you’d say that.

{% include embed/youtube.html id='Aq6eoMjW7V0' %}
📺 [Watch Video](https://www.youtube.com/watch?v=Aq6eoMjW7V0)

You might have heard of Protectli before.  They’re known for making really great appliances for many open source software distributions.  Most people think of Protectli devices as the perfect device for a router like pfSense. And that makes sense considering that their devices come with anywhere from 2 - 6 network ports.  But their devices can be used to run almost any software imaginable, from Linux, to Windows, to a dedicated firewall, to even a virtualization host or a hypervisor.

> How is that possible?

## Where to Buy

A HUGE thanks to [Protectli](https://protectli.com) for sending this device for me to test!

- Protectli Vault FW2B - 2 Port - <https://amzn.to/3nRJfM1>

- Protectli Vault FW4B - 4 Port - <https://amzn.to/3nVVU0u>

- Protectli Vault FW6A - 6 Port - <https://amzn.to/3zHWHop>

- Protectli Vault Pro VP4630-6 Port - <https://amzn.to/3GoYSRy>

- Crucial RAM - <https://amzn.to/41eks31>

- Samsung NVMe - <https://amzn.to/3KIsKuD>

- Samsung SSD - <https://amzn.to/43fYb6Z>

See the entire Kit! - <https://kit.co/TechnoTim/building-a-low-power-all-in-one-silent-server>

## CPU

That’s possible because of the hardware that these devices ship with.  Protectli sent me a VP4560 to help with some of my HomeLab projects and this device is a beast.   This is the VP4650 and comes with an intel Core i5 quad core CPU with hyper-threading that is rated at 1.6 GHz and can turbo boost up to 4.2 GHz.  The nice thing about this CPU is that it supports VTx for virtualization and VT-d for IOMMU so I can pass through devices though to the guest.  And because it’s an Intel x86 processor it comes with AES-NI support, which is super nice for encryption / decryption for VPN or TLS.

## Memory

It supports up to 64GB of RAM which is plenty for what I will be using it for, but you can scale back if you need, all the way down to 4 GB.

## Network

It comes with 6 intel 2.5 gigabit NIC ports giving you enough throughput for most of your networking needs.

![Protectli Network ports](/assets/img/posts/protectli-network-ports-vp4650.jpg)
_Protectli VP4650 has 6 - 2.5 Gb/sec network ports!_

## Storage

It also ships with a 16GB eMMC module on board and many options for storage.  Also, because this machine has an NVMe slot and a SATA port you can mix and match your storage to fit your needs.  I opted for a 1 TB Samsung M.2 NVMe and a 1 TB Samsung EVO drive.

![Protectli Device Internals](/assets/img/posts/protectli-internals-vp4650.jpg)
_Protectli VP4650 Internals_

## Extras

You also get the choice of adding WiFi modules and 4g LTE modems however I decided not to on this device because they also sent a lower powered VP2420 that has 4 network ports  along with WiFI and LTE modules to help me build the ultimate router which you’ll be seeing in a future video.

![Protectli Ultimate Router](/assets/img/posts/protectli-ultimate-router.jpg)
_Protectli Ultimate Router (Coming soon!)_

## Cooling

If you noticed from everything I listed, you didn’t hear anything about fans.  That’s not something that’s obvious from the specs on paper, but taking one look at this device you can see this huge heatsink that passively cools the entire device.  It definitely looks like a grill but I promise you can’t cook anything on here.

## Connectivity

![Protectli Connectivity](/assets/img/posts/protectli-connectivity-vp4650.jpg)
Protectli devices come with plenty of options to connect all of your other devices devices_

As far as connectivity goes, you have plenty of options for connecting devices, from USB 2.0, 3.0, USB C, to HDMI, to Display power, and even a microSD port for console access.

## BIOS

![Protectli BIOS](/assets/img/posts/protectli-bios-vp4650.jpg)
You can choose between AMI BIOS and and open source BIOS called "coreboot"_

One thing that I like about these devices is that you have your choice in firmware to use.  You can use a standard AMI BIOS that works great, or your can use coreboot BIOS, which is a bare bones open source BIOS that lets you customize some cool features.  For instance, if you flash their devices with core boot, you can boot to the network and download and install many different operating systems from the network.  This is a neat feature that I welcome and it saves you the hassle of loading up that Ventoy USB disk with new ISO.  I did however opt for AMI BIOS because I did have a few issues with coreboot related to using my Ventoy USB disk.  But that’s the nice thing about this BIOS being open source, it will get better and more secure over time with more eyes looking at it and more engineers contributing to it.

## The Build

So what did I do with all of this hardware?  The better question is what didn’t I do?

I knew that I wanted thai build to be a complete silent hypervisor and I knew that it was going to run Proxmox.

The first decision I had to make was where I was going to install proxmox.  Remember I have the choice between the NVMe drive, the SATA drive, and the eMMC module.  Turns out the eMMC mobile isn’t really an option because Proxmox won’t let you install it there without some hacks and I didn’t want to hack this device so I decided to install it on the NVMe drive and use the rest of the partition for virtual machines.  Typically I would have installed the OS on the slower drive and save the NVMe for VMs but I have other plans for that. Installing Proxmox was straightforward, just like any other Proxmox installation.  After it was installed I then configured IOMMU so I can pass devices through to guest machines and everything else I have on my [First 11 Things on Proxmox video](/posts/first-11-things-proxmox).  After that was all set it was now time to install some VMs.

## Router

I knew that I wanted to install a router on this machine.  This will give me the flexibility to run a network firewall for all of these devices and give me the option to protect any device I use when I travel, but more on that later.

So I installed pfsense, and passed through 2 NICs from the host down to the guest.   This first NIC is the WAN port, so an upstream provider like an ISP or even some network I don’t trust, and then one port for LAN if I do want to connect all of these devices to the local network. Passing these through and configuring them was pretty simple and if I forget which port is which they even included some stickers for me to label the ports.  I also added another network port that’s used as a network bridge in case I want these VMs to use an internal network.

![Protectli Stickers for network ports](/assets/img/posts/protectli-stickers-vp4650.jpg)
_Protectli Network Interface stickers_

## NAS

Now that the router was done, I wanted to configure a NAS on this device.  This NAS could be any open source NAS but I chose to go with TrueNAS SCALE.  I went with TrueNAS because, well it’s TrueNAS,and I went with SCALE because I wanted a Linux based OS that plays better with Proxmox.  After installing TrueNAS I then created a 1 TB drive in Proxmox and assigned it to TrueNAS so that I can have 1 TB of storage on my NAS.  I know it’s not ZFS and I don’t have redundant drives, so if you do the same you’ll want to be sure that you have your data backed up to another machine.  Once I had TrueNAS up and running I could set up NFS and Samba shares just like I would normally with a physical install.  I can also pass through one of the NICs to my NAS so that it can have a dedicated 2.5 Gb/s NIC if I like.

## Ubuntu Server + Portainer

Next up I needed something to run my containers.  Yes, I know I can use TrueNAS to do that but I wanted to go with my preferred combination of Ubuntu Server + Docker + Portainer.  Having a dedicated Ubuntu server running Portainer gives me a great UI and so many possibilities.  After installing and configuring I then created a few containers.  This is a perfect host now to run all of my self-hosted services.

## Desktop

After getting my foundation all set up, I then had my choice of desktop OSes.  I could choose between Windows and Ubuntu Desktop, then I looked at how much disk space and RAM I had left and I thought to myself, why not both.  This is where things got a little bit interesting too.
I first installed Windows 11 and configured it, no problems there, but after installing Windows I wanted to passthrough the GPU on the device to the VM, along with sound card and USB devices so I could use this all in one server as a desktop too.  After messing with this for hours I could not get the single Intel GPU to display anything on the screen even though it was definitely passed through to the guest machine and I could see it over Remote Desktop.  I thought maybe it was Windows 11 so I created a Windows 10 machine and it did the same thing.

![Protectli Proxmox Desktop](/assets/img/posts/protectli-proxmox-as-desktop-vp4650.jpg)
_Ubuntu Virtual machine running on Proxmox with the hardware passed through from host to guest so I can use it as a desktop simultaneously_

So I decided to try it again, but with Ubuntu Desktop and sure enough it worked!  I was able to pass through the integrated GPU front he host down to the guest and use this machine as a desktop.  I will be the first to admit that it wasn’t winning any performance awards but I was able to do most tasks that I would expect to do on a laptop.  I installed VSCode, customize the desktop, watched some YouTube, and even passed through the thermal subsystem so I could monitor the temperature of the host.

After I had this working I decided to install Plex on this machine so that I could see if I could get QuickSync working.  QuickSync is a technology and a dedicated chip on most modern intel processors that lets you off load decoding and encoding video from the processor to this chip.  This technology is similar to NVENC from NVIDIA, and AMF from AMD, but the idea is that you give this work to another part of the processor instead of pegging all of your CPU cores.  Plex can take advantage of this if you have a plex pass and I do, so I wanted to see if I could get it working.

That’s where I started to run into troubles.  I thought that since I had the GPU passed through to this Ubuntu machine that Plex would just see QuickSync and use it.   No matter what I tried I could not get Plex do hardware encoding, I even tried using Docker containers which supposedly should work if the hardware is mapped properly however I couldn’t get it to work.

![Protectli Intel GPU over RDP](/assets/img/posts/protectli-intel-rdp-vp4650.jpg)
_I could see the Intel GPU using Remote Desktop on Windows_

Then I decided to try my Windows VM.  I could see the Intel GPU when using Remote Desktop so there was hope.  Sure enough that when I installed plex and started streaming a video the hardware enabled transcoding kicked it and the CPU barely budged! I was able to transcode 3-4k streams down to 1080, 720, and even 480, no problem!  

![Protectli Plex Transcoding](/assets/img/posts/protectli-plex-transcoding-vp4650.jpg)
_I could encode 3 - 4k streams on Plex using Intel's Quick Sync!_

This was awesome and puzzling at the same time.  The WIndows machine could see the GPU and take advantage of QuickSync but I couldn’t output the display from the HDMI or DisplayPort, and the Ubuntu machine could output to the monitor over HDMI but couldn’t use QuickSync.  Judging by the fact that I was able to cover both of these use cases with different operating systems this told me that it’s something with software and not hardware so I chalked it up as software issue and it may be fixed some day.

## Power

![Protectli Device Power Draw](/assets/img/posts/protectli-power-draw-vp4650.jpg)
_Protectli VP4650 power draw with 4 virtual machines running and hardware attached_

You might think that running 4 virtual machines on this device would draw a lot of power and generate a lot of heat.  Well, I thought the same thing until I pulled out my kill-a-watt and decided to measure it.  This Protectli machine running 4 VMs and the host itself with all of these devices plugged in pulled anywhere from 20-30 watts, which I think is pretty good considering I have all of this functionality in one device.  If I wanted to save some more power I could power down any of these virtual machines when not using them.  

![Protectli Device Temperatures](/assets/img/posts/protectli-temps-vp4650.jpg)
_Protectli VP4650 temperatures with 4 virtual machines running and hardware attached_

And as far as heat goes?  Well, do you hear that fan?  That’s right, no fan equals no noise but that also means that it’s going to heat up these fins.  As you saw earlier that the thermals were around 56 celsius on the die, it’s actually much cooler on the heatsink fins so you definitely can’t cook anything on it.

## Final Thoughts

As you saw I was able to create quite a few virtual machines and spin up an absolutely quiet hypervisor and use it as a desktop, which goes to show just how flexible these devices are.  If you go with Protectli you are getting a blank slate where you can create and build anything you want.  From a full fledged server with virtual machines to a small dedicated development environment.

Now it wouldn’t be fair if I didn’t mention some of the beefs I have with it too.  Remember that eMMC drive I mentioned?  Well, if you’re planning on using it with Proxmox it’s almost useless.  Proxmox can’t be installed on that device and even if it could it’s only 16GB.  I’d love to see another option other than the eMMC module or even space for another SSD.  The other things that some mention is the price.  These devices are a little more expensive than some of the other small form factor devices out there, so I wish the price would come down just a bit.  However these devices are purpose built, have lots of customization options like WiFi and 4g LTE,  are industrial quality, offer support for all of their devices, and allow you to swap out firmware for coreboot anytime you like and those options might be enough for you to justify the premium cost, because I think these are truly premium devices.

Well, I learned a lot about running Proxmox on Protectli devices and I hope you learned something too.  And remember if you found anything in this video helpful, don’t forget to like and subscribe.  Thanks for reading and watching!

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
