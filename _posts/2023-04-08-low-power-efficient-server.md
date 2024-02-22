---
layout: post
title: "Building a Low Power, All-in-One, Silent Server"
date: 2023-04-08 10:00:00 -0500
categories: homelab
tags: homelab proxmox pfsense ubuntu windows truenas hardware plex portainer docker hardware
image:
  path: /assets/img/headers/terrarium-multiple.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOt/aT8HfHLQPGfiDQ7H9o/xZBb6L4c0Hx7GLTSb6whuh4j8NfE7xbNodylr4tS5+xW9t8Jf7HjlgvIdp8QyalbQWk2nvb6n/MuG4wzOGDlg1HDydTCWVedKDrUp1Ir97SajG04zxVKS5+eHJh3CMIuqp0urEcPYmeJnWp5tUpwdaUFRlQqTilBuGso4yk2pycZTSUdFKKalJTj8/QfDXRVghW/8vUr5Yo1vdRns7dp7+7CAXF7M1wLmdpbqbfPI01zcSl5CZJ5XzI3w3+sM4+68O5uOjnKrS5ptaOUuXCpc0nq7JK70SWh99SwUoUqcPbzfJThG6dVJ8sUrpOtJpabOUmusnuf/2Q==

---

What if I told you that this little machine is the perfect Proxmox Virtualization server?  And what if I told you I crammed an intel core i5, 64 GB of RAM, a 1 TB NVMe SSD, another 1TB SSD all in this tiny little box that’s dead silent without any fans?  And what if I told you it can run Proxmox Virtual Server, host a pfsense router, runTrueNAS with a TB of storage, run Ubuntu server with Portainer running a few docker containers, run Windows 10 or Windows 11, and run ubuntu Desktop and pass though all of the hardware so I can use this server as a desktop, all while running a Plex Server and doing hardware transcoding with 3 - 4k streams?

> No Way!

Yeah, I thought you’d say that.

{% include embed/youtube.html id='Aq6eoMjW7V0' %}
📺 [Watch Video](https://www.youtube.com/watch?v=Aq6eoMjW7V0)

You might have heard of Protectli before.They’re known for making really great appliances for many open source software distributions.Most people think of Protectli devices as the perfect device for a router like pfSense. And that makes sense considering that their devices come with anywhere from 2 - 6 network ports.But their devices can be used to run almost any software imaginable, from Linux, to Windows, to a dedicated firewall, to even a virtualization host or a hypervisor.

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

See the whole kit here! - <https://kit.co/TechnoTim/building-a-low-power-all-in-one-silent-server>

## CPU

That’s possible because of the hardware that these devices ship with.Protectli sent me a VP4560 to help with some of my HomeLab projects and this device is a beast. This is the VP4650 and comes with an intel Core i5 quad core CPU with hyper-threading that is rated at 1.6 GHz and can turbo boost up to 4.2 GHz.The nice thing about this CPU is that it supports VTx for virtualization and VT-d for IOMMU so I can pass through devices though to the guest.And because it’s an Intel x86 processor it comes with AES-NI support, which is super nice for encryption / decryption for VPN or TLS.

## Memory

It supports up to 64GB of RAM which is plenty for what I will be using it for, but you can scale back if you need, all the way down to 4 GB.

## Network

It comes with 6 intel 2.5 gigabit NIC ports giving you enough throughput for most of your networking needs.

![Protectli Network ports](/assets/img/posts/protectli-network-ports-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APaP2vP2qfir8Jvix8PvBumPD8R7Pxh4K0nRpdb8d3ej6Drelzan4s12yM8EPgrwVZaLdxWsF7+6iOm2ZnWCOC7M7NJcv5tHFqlBRcZfFze7K2luW2t3dtXd7re1m7rT6o5807wTTts3rHW6WnTSx+kuieN7/QtF0jRHmuL59H0uw0p71tsBu20+0itGujDvn8k3BhMpi86byy+zzZMby3eTck7KTbSstE9bfIlUV1evz/zP/9k=
" }
_Protectli VP4650 has 6 - 2.5 Gb/s network ports!_

## Storage

It also ships with a 16GB eMMC module on board and many options for storage.Also, because this machine has an NVMe slot and a SATA port you can mix and match your storage to fit your needs.I opted for a 1 TB Samsung M.2 NVMe and a 1 TB Samsung EVO drive.

![Protectli Device Internals](/assets/img/posts/protectli-internals-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APnD4x+Ff2iNI+IVx4f8VftP/FTzJfD2h3ml6vovjj4g3d3Y+GdVbxC//CPraDxd4Y0uJJfKtJ3lSxlm06aS6i026W3Li6+aoZlLH1MdUqqUcPDMKc8NTpy9hKnLDx5J0Z/Vfq/tKEqv7795Oo6vNGFWPLSXtPu+IeFqeQyyFRrQqVsdkixmJ5aV6VSOOqurQnau6zhiKVKCoydNQpq8pQXNNtfQfwq/ae+Pfhr4X/Dfw5d/E7x3qt34f8BeD9EutUufFq3VxqVxpXh7TrCa/nudQ8O3d/cTXkkDXEs97dXN3M8jSXNxNMzyN4dfPMbGvWjCVNQjVqRinSTaiptRTbm22lbVtvzP1PLuAeE55fgJ4vLK1TFTweFliZwx1RQniJUIOtOC9lC0ZVHJx9yGjXux2X//2Q==
" }
_Protectli VP4650 Internals_

## Extras

You also get the choice of adding WiFi modules and 4g LTE modems however I decided not to on this device because they also sent a lower powered VP2420 that has 4 network ports  along with WiFI and LTE modules to help me build the ultimate router which you’ll be seeing in a future video.

![Protectli Ultimate Router](/assets/img/posts/protectli-ultimate-router.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APJP2oP2tv22vHfxp+Cfj34a/HS3+BXgLWh4v8P+GfAeg+GtI8bQWlx4S1y10TxLdeJm8SabZ/2w+ualHf20NzY3emSroUWnbYbG8MqQ50p4rA4DMM1qOlXeHVOuqK5qUXSdH2yirxq2k4S969253j7Vw5XH9Cw/DuTZ3nmScNYKNfLpVK1TB4vMKkYYqtWx9WKtU5FPD3w0KlOFOCU6fJSlOrHD+154Vf2b+Fv7TWq6p8MfhzqV/wCI/iBNfaj4E8IX17LDfxQQy3d34f0+4uZIoJ9UvpoYnmkdo4pr28ljQhJLq4cGV8I8ZxUUp5dTnNJKc725pJWlK2tuZ3dru19z6ut4LQVWqoZzKMFUmoxlSVRxjzPli5qNNTaVk5+zhzPXkjey/wD/2Q==
" }
_Protectli Ultimate Router (Coming soon!)_

## Cooling

If you noticed from everything I listed, you didn’t hear anything about fans.That’s not something that’s obvious from the specs on paper, but taking one look at this device you can see this huge heatsink that passively cools the entire device.It definitely looks like a grill but I promise you can’t cook anything on here.

## Connectivity

![Protectli Connectivity](/assets/img/posts/protectli-connectivity-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyy07/goTrX7IHj3WYfhpYa74U8aatovgq+1nW9EGhammsWVtoPifT/AATJe3Gr28Eaazovhnxzqtjf3tnottBd317e3CW3lCyjtvKw8cR9XgqtSDny03U5FJU3Lk5p8ik5Ts3JKPNO8YqzcnZr1czp4SOY4uOAhWhgfrNf6pTxU4VcRTo+1caarVKVOnSnUUIL2kqdOClL3kla0v0R8K+Nf2kL3wv4bvbSf4Wpa3eg6PdWyOdRs2S3uNPt5YVa0sfCq2NqyxuoNtZqtrAQYrdRCqCuWWWYvmlyPLVDmfIpYSrKSjf3VKSrpSkla7srvWyPoaOM4aVGksTheIZ4hUqarzpZpg6dKdZQXtZUqcsBOUKcp8zhCU5yjFpOUmrv/9k=
" }
Protectli devices come with plenty of options to connect all of your other devices devices_

As far as connectivity goes, you have plenty of options for connecting devices, from USB 2.0, 3.0, USB C, to HDMI, to Display power, and even a micro USB port for console access.

## BIOS

![Protectli BIOS](/assets/img/posts/protectli-bios-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APN9X/4KZfsv+Gfgp+zVpE/7La6j8W9Juk+Fyay3h34dReGdc8ReOLfV9E0/WPFF80E2va1a6HaWm4X13ZS6ldTXNzLPaytLkfUcZYPEZnm+aUcLjsTl9StnWLjTVKtN/UYVsXUqQpUMTD2UqqhSn7Gc/q+Hc4LlUIRlpWCzCphpVpTwmEq0K9NVYSqR9tW928JpxlCCp2k7w5K0kmo1WlJcp2UXwa8C28ccFnpWnLaQokVqraNBCy20ahIA0UF2IImEQUGOECJD8sfyAV/ZMPEvw3hCEIeCeROEYRjBz4hzNTcYpKLn7PDQhzNJc3JGML35YpWS9OPGGXqMVLIqkpKKUpPNsS25Jatt0k229btK5//Z
" }
You can choose between AMI BIOS and and open source BIOS called "coreboot"_

One thing that I like about these devices is that you have your choice in firmware to use.You can use a standard AMI BIOS that works great, or your can use coreboot BIOS, which is a bare bones open source BIOS that lets you customize some cool features.For instance, if you flash their devices with core boot, you can boot to the network and download and install many different operating systems from the network.This is a neat feature that I welcome and it saves you the hassle of loading up that Ventoy USB disk with new ISO.I did however opt for AMI BIOS because I did have a few issues with coreboot related to using my Ventoy USB disk.But that’s the nice thing about this BIOS being open source, it will get better and more secure over time with more eyes looking at it and more engineers contributing to it.

## The Build

So what did I do with all of this hardware?  The better question is what didn’t I do?

I knew that I wanted thai build to be a complete silent hypervisor and I knew that it was going to run Proxmox.

The first decision I had to make was where I was going to install proxmox.Remember I have the choice between the NVMe drive, the SATA drive, and the eMMC module.Turns out the eMMC mobile isn’t really an option because Proxmox won’t let you install it there without some hacks and I didn’t want to hack this device so I decided to install it on the NVMe drive and use the rest of the partition for virtual machines.Typically I would have installed the OS on the slower drive and save the NVMe for VMs but I have other plans for that. Installing Proxmox was straightforward, just like any other Proxmox installation.After it was installed I then configured IOMMU so I can pass devices through to guest machines and everything else I have on my [First 11 Things on Proxmox video](/posts/first-11-things-proxmox).After that was all set it was now time to install some VMs.

## Router

I knew that I wanted to install a router on this machine.This will give me the flexibility to run a network firewall for all of these devices and give me the option to protect any device I use when I travel, but more on that later.

So I installed pfsense, and passed through 2 NICs from the host down to the guest. This first NIC is the WAN port, so an upstream provider like an ISP or even some network I don’t trust, and then one port for LAN if I do want to connect all of these devices to the local network. Passing these through and configuring them was pretty simple and if I forget which port is which they even included some stickers for me to label the ports.I also added another network port that’s used as a network bridge in case I want these VMs to use an internal network.

![Protectli Stickers for network ports](/assets/img/posts/protectli-stickers-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APdv2Jv224/2nvh98db/AMXeBbKfW/gV4J+Jnxhgj1mx0HWbQ+CPDN7PaP4d0vUHsbe5/ty+j8Ou0zvp+n6c63EELSA273E/j5RmtCGEk69OtXxHJLEOo1TjpKEZ06acZJ2ipavl0bdj9W454Sy7LsxwFTA4HB4LA47HUMmpUKM8RVqxr81SE8XVqYh1JXdk1+8qSbSb2d/gWz/4KSajq9pa6rp2i2Vlp+p20GoWNnL4GleW0s72Jbm2tpH/AOFsyb5IIZEidvMfcyE72zuOC4nzZaN4K60/3av0/wC51fkvRH1a8J+CpJSVTiO0kmr5jl97PVXtlNr97aXP/9k=
" }
_Protectli Network interface stickers_

## NAS

Now that the router was done, I wanted to configure a NAS on this device.This NAS could be any open source NAS but I chose to go with TrueNAS SCALE.I went with TrueNAS because, well it’s TrueNAS,and I went with SCALE because I wanted a Linux based OS that plays better with Proxmox.After installing TrueNAS I then created a 1 TB drive in Proxmox and assigned it to TrueNAS so that I can have 1 TB of storage on my NAS.I know it’s not ZFS and I don’t have redundant drives, so if you do the same you’ll want to be sure that you have your data backed up to another machine.Once I had TrueNAS up and running I could set up NFS and Samba shares just like I would normally with a physical install.I can also pass through one of the NICs to my NAS so that it can have a dedicated 2.5 Gb/s NIC if I like.

## Ubuntu Server + Portainer

Next up I needed something to run my containers.Yes, I know I can use TrueNAS to do that but I wanted to go with my preferred combination of Ubuntu Server + Docker + Portainer.Having a dedicated Ubuntu server running Portainer gives me a great UI and so many possibilities.After installing and configuring I then created a few containers.This is a perfect host now to run all of my self-hosted services.

## Desktop

After getting my foundation all set up, I then had my choice of desktop OSes.I could choose between Windows and Ubuntu Desktop, then I looked at how much disk space and RAM I had left and I thought to myself, why not both.This is where things got a little bit interesting too.
I first installed Windows 11 and configured it, no problems there, but after installing Windows I wanted to passthrough the GPU on the device to the VM, along with sound card and USB devices so I could use this all in one server as a desktop too.After messing with this for hours I could not get the single Intel GPU to display anything on the screen even though it was definitely passed through to the guest machine and I could see it over Remote Desktop.I thought maybe it was Windows 11 so I created a Windows 10 machine and it did the same thing.

![Protectli Proxmox Desktop](/assets/img/posts/protectli-proxmox-as-desktop-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP49re4+0eD9R0O5Fo2oX91ozt4pOlo+r6DpdoNPF1aaTDHf2tvfteGS4e4F81u0u2KOO5tfMlkH6tWoVamEcKWLarSpR5b4SnCKqaPWrGrOdv7/ALNy1+FH49RxVKljIyq4GLoRqSjP/bKlWThdrmjRqYeNPm/ue1ilsqjPMlfxdbqtvJ4l1LzIFEMnk6rqSQ74hsbylDoFj3KdihEAXACrjA8f6nilpLEXktJPnq6yW73W78l6I9f+0MM9YYZKD1gnTo3Ufsp6PVKyer9Wf//Z
" }
_Ubuntu Virtual machine running on Proxmox with the hardware passed through from host to guest so I can use it as a desktop simultaneously_

So I decided to try it again, but with Ubuntu Desktop and sure enough it worked!  I was able to pass through the integrated GPU front he host down to the guest and use this machine as a desktop.I will be the first to admit that it wasn’t winning any performance awards but I was able to do most tasks that I would expect to do on a laptop.I installed VSCode, customize the desktop, watched some YouTube, and even passed through the thermal subsystem so I could monitor the temperature of the host.

After I had this working I decided to install Plex on this machine so that I could see if I could get QuickSync working.QuickSync is a technology and a dedicated chip on most modern intel processors that lets you off load decoding and encoding video from the processor to this chip.This technology is similar to NVENC from NVIDIA, and AMF from AMD, but the idea is that you give this work to another part of the processor instead of pegging all of your CPU cores.Plex can take advantage of this if you have a plex pass and I do, so I wanted to see if I could get it working.

That’s where I started to run into troubles.I thought that since I had the GPU passed through to this Ubuntu machine that Plex would just see QuickSync and use it. No matter what I tried I could not get Plex do hardware encoding, I even tried using Docker containers which supposedly should work if the hardware is mapped properly however I couldn’t get it to work.

![Protectli Intel GPU over RDP](/assets/img/posts/protectli-intel-rdp-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7Zvhf4V0n/AIVt4Mg1PStJ1APoenX8P2mytrxY47+0huYQouLYeXItvLHHIi7wjKUSV4wmPvs5xeLw+f57OhisRQnPNsyU50a1SlKcVja1lN05Rcrab31Pzvh3C4XEcMcNxrYahWhHI8pcY1aNOpGMnl9C7ipqSje72tpof5y37Y9+1r+13+1Ra28ccNvbftH/ABxgghijSOKKGH4neKI4oo40ASOONFVERQFVQFUAACv96PCviPHR8MPDhOrOTXAXB6cpWlKTXD2XJylKT5pSb1cnq3q9T/OzjLCUlxfxUowjGK4kzxRjFKMYxWZ4q0YxSskloktEtEf/2Q==
" }
_I could see the Intel GPU using Remote Desktop on Windows_

Then I decided to try my Windows VM.I could see the Intel GPU when using Remote Desktop so there was hope.Sure enough that when I installed plex and started streaming a video the hardware enabled transcoding kicked it and the CPU barely budged! I was able to transcode 3-4k streams down to 1080, 720, and even 480, no problem!  

![Protectli Plex Transcoding](/assets/img/posts/protectli-plex-transcoding-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7t7Hwr4QtbSRYNsaSMJUij1i7iWExII0WHybyNwjbPMdXeQu7sCTHsjW/aT095uyUU3q7K1tXdt6JNvVrRtpsSVrtNq7u/el5+ei1dktF02R44/ia1DuAZSAzAEx3eSATgnNqTkjrkk+pNbRjeMW6/K2k2uaLs2tr+11ttcl1ay2Tt09+a06acmnof/9k=
" }
_I could encode 3 - 4k streams on Plex using Intel's Quick Sync!_

This was awesome and puzzling at the same time.The WIndows machine could see the GPU and take advantage of QuickSync but I couldn’t output the display from the HDMI or DisplayPort, and the Ubuntu machine could output to the monitor over HDMI but couldn’t use QuickSync.Judging by the fact that I was able to cover both of these use cases with different operating systems this told me that it’s something with software and not hardware so I chalked it up as software issue and it may be fixed some day.

## Power

![Protectli Device Power Draw](/assets/img/posts/protectli-power-draw-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AF8Q/Cb4s/ti+EfDfxA+CPxu8Ufsw6J4G134h6ZJaaJrnjXWdV8SeBIYfB9r4UjkGm+KvDlt4fvfCsKakdL8LW93q+gW39v6q0Opi/udV1TXOjDxxOFVGniqlOrVcPaSnQhGkr3lKV7Qi6js4pOVpacrfKoqPr8QvLFmlZZRhKuFy9KEcPRxFX2taKS951al5Xc5uUvik4pqPNLlTP1g+E37ZPxT174V/DTXLr4W/DfWbnWvh/4N1a41fXfG3iga3qs+o+HNNvJtS1gaX4StNNGq30kzXWoDTrW2sftcs32S3ht/LjX7GGCwVSEJyr4mMpwjOUY4ai4xlJJuMW8TFuKbsm4q66LY8X2FPrVmn1SoQlr11dZN+rSb3aR//9k=
" }
_Protectli VP4650 power draw with 4 virtual machines running and hardware attached_

You might think that running 4 virtual machines on this device would draw a lot of power and generate a lot of heat.Well, I thought the same thing until I pulled out my kill-a-watt and decided to measure it.This Protectli machine running 4 VMs and the host itself with all of these devices plugged in pulled anywhere from 20-30 watts, which I think is pretty good considering I have all of this functionality in one device.If I wanted to save some more power I could power down any of these virtual machines when not using them.

![Protectli Device Temperatures](/assets/img/posts/protectli-temps-vp4650.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AHftL/Eb9oTV/wBqS18ReFfjN4r8C/D6fXPhh4b8G+EdK8Q+Kbi20FvDfjnwZo/i99b0KTWoNF8T2fjCPxHaWktteTxC3tLvUHG19Oit9c8LMMyxmXVMorU44aeEryxKxkZqv9YVOMYzpVMK6dWlR9tGo1TqRxMa9GeHnV5Y066o1qX2vB3CFLimhn9H2yo4zB0cHPCVp3dKNWtUrcyqRipSdOoqPJKSXPSc1ViqnJKjV/pt8E+O9N17wb4S1y60yOC51nwxoOq3EFppemxWsM+o6VaXksVtGHAjt45JmSFAAEjCrjivseRPVPR6q66dOp+funZtN6p2dl2P/9k=
" }

_Protectli VP4650 temperatures with 4 virtual machines running and hardware attached_

And as far as heat goes?  Well, do you hear that fan?  That’s right, no fan equals no noise but that also means that it’s going to heat up these fins.As you saw earlier that the thermals were around 56 celsius on the die, it’s actually much cooler on the heatsink fins so you definitely can’t cook anything on it.

## Final Thoughts

As you saw I was able to create quite a few virtual machines and spin up an absolutely quiet hypervisor and use it as a desktop, which goes to show just how flexible these devices are.If you go with Protectli you are getting a blank slate where you can create and build anything you want.From a full fledged server with virtual machines to a small dedicated development environment.

Now it wouldn’t be fair if I didn’t mention some of the beefs I have with it too.Remember that eMMC drive I mentioned?  Well, if you’re planning on using it with Proxmox it’s almost useless.Proxmox can’t be installed on that device and even if it could it’s only 16GB.I’d love to see another option other than the eMMC module or even space for another SSD.The other things that some mention is the price.These devices are a little more expensive than some of the other small form factor devices out there, so I wish the price would come down just a bit.However these devices are purpose built, have lots of customization options like WiFi and 4g LTE,  are industrial quality, offer support for all of their devices, and allow you to swap out firmware for coreboot anytime you like and those options might be enough for you to justify the premium cost, because I think these are truly premium devices.

Well, I learned a lot about running Proxmox on Protectli devices and I hope you learned something too.And remember if you found anything in this video helpful, don’t forget to like and subscribe.Thanks for reading and watching!

## Configuration

Here is my configuration for each virtual machine on my Proxmox server.Please note that (as seen in this article and the video) I did have issues getting the Windows machines to output their display to a physical monitor however Quick Sync to encode videos worked just fine and I could output the display using Ubuntu desktop however I could not use Quick Sync.If you have a fix, let me know in the comments!

### pfSense

```conf
boot: order=virtio0;ide2;net0
cores: 4
cpu: host,flags=+aes
hostpci0: 0000:06:00
ide2: none,media=cdrom
memory: 2048
meta: creation-qemu=7.2.0,ctime=1680150221
name: pfsense
net0: virtio=12:70:A1:22:F9:2F,bridge=vmbr1
numa: 0
ostype: other
scsihw: virtio-scsi-single
smbios1: uuid=0388a78d-7950-49e7-8ef9-19a9744e8ee2
sockets: 1
startup: order=1,up=30,down=30
vga: qxl
virtio0: local-lvm:vm-100-disk-0,discard=on,iothread=1,size=20G
vmgenid: 314798d0-820e-40bd-89ad-ac364b03b83c
```
{: file="/etc/pve/qemu-server/100.conf" }

### Windows 11

```conf
agent: 1
balloon: 0
bios: ovmf
boot: order=ide0;ide2;virtio0;net0
cores: 8
cpu: host
efidisk0: local-lvm:vm-101-disk-0,efitype=4m,pre-enrolled-keys=1,size=4M
hostpci0: 0000:00:02,pcie=1
hostpci1: 0000:00:12.0
ide0: local:iso/virtio-win-0.1.229.iso,media=cdrom,size=522284K
ide2: none,media=cdrom
machine: pc-q35-7.2
memory: 32768
meta: creation-qemu=7.2.0,ctime=1680233057
name: windows-11
net0: virtio=DE:AB:E8:6B:9F:B7,bridge=vmbr2,firewall=1,tag=60
numa: 0
ostype: win11
scsihw: virtio-scsi-single
smbios1: uuid=5f7d30a5-b3df-4a29-800c-730c7a43668d
sockets: 1
tpmstate0: local-lvm:vm-101-disk-1,size=4M,version=v2.0
vga: std
virtio0: local-lvm:vm-101-disk-2,cache=unsafe,discard=on,iothread=1,size=10>vmgenid: 9193bc41-1b82-4069-bc42-8cbb0dfca31d
```
{: file="/etc/pve/qemu-server/101.conf" }

### Ubuntu Desktop

```conf
agent: 1
balloon: 0
boot: order=scsi0;ide2;net0
cores: 8
cpu: host
hostpci0: 0000:00:02,pcie=1,rombar=0,x-vga=1
hostpci1: 0000:00:1f
hostpci2: 0000:00:1a
hostpci3: 0000:00:12,pcie=1
ide2: none,media=cdrom
machine: q35
memory: 16384
meta: creation-qemu=7.2.0,ctime=1680232192
name: ubuntu
net0: virtio=1E:05:6A:E7:68:85,bridge=vmbr2,tag=60
numa: 0
ostype: l26
scsi0: local-lvm:vm-102-disk-0,cache=writeback,discard=on,iothread=1,size=8>scsihw: virtio-scsi-single
smbios1: uuid=7b2a286b-197d-4382-9c04-5a0544596b89
sockets: 1
startup: order=4,up=30,down=30
usb0: host=24f0:0142
usb1: host=045e:0724
vga: none
vmgenid: e93460b1-66f7-4694-a528-98ed006eb770
```
{: file="/etc/pve/qemu-server/102.conf" }

### Ubuntu Server

```conf
agent: 1
balloon: 0
boot: order=scsi0;ide2;net0
cores: 4
cpu: host
ide2: none,media=cdrom
memory: 8192
meta: creation-qemu=7.2.0,ctime=1680232488
name: ubuntu-server
net0: virtio=F6:BF:85:17:B6:0F,bridge=vmbr2,firewall=1,tag=60
numa: 0
ostype: l26
scsi0: local-lvm:vm-103-disk-0,cache=unsafe,discard=on,iothread=1,size=32G
scsihw: virtio-scsi-single
smbios1: uuid=7bc4309c-dc9a-4632-bfd5-2e5f8a5e4fcd
sockets: 1
startup: order=3,up=30,down=30
vmgenid: 2500d141-f7be-4c7b-ab9f-0a0f0075ea97
```
{: file="/etc/pve/qemu-server/103.conf" }

### TrueNAS

```conf
agent: 1
balloon: 0
boot: order=scsi0;ide2;net0
cores: 4
cpu: host
ide2: none,media=cdrom
machine: q35
memory: 8192
meta: creation-qemu=7.2.0,ctime=1680314889
name: truenas
net0: virtio=DE:16:B3:D8:6C:C7,bridge=vmbr2,firewall=1,tag=60
numa: 0
ostype: l26
scsi0: local-lvm:vm-104-disk-0,discard=on,iothread=1,size=32G,ssd=1
scsi1: evo:vm-104-disk-0,discard=on,iothread=1,size=1000G,ssd=1
scsihw: virtio-scsi-single
smbios1: uuid=2ab225ac-44d8-4fb0-b5eb-0ada70e05f33
sockets: 1
startup: order=2,up=30,down=30
vmgenid: 79db20a3-ff24-457c-8abb-6dc4df3c6e38
```
{: file="/etc/pve/qemu-server/104.conf" }

### Windows 10

```conf
agent: 1
balloon: 0
bios: ovmf
boot: order=ide0;ide2;scsi0;net0
cores: 8
cpu: host
efidisk0: local-lvm:vm-105-disk-0,efitype=4m,pre-enrolled-keys=1,size=4M
hostpci0: 0000:00:02,pcie=1
hostpci1: 0000:00:12,pcie=1
hostpci2: 0000:00:1f
ide0: none,media=cdrom
ide2: none,media=cdrom
machine: pc-q35-7.2
memory: 32768
meta: creation-qemu=7.2.0,ctime=1680459394
name: windows-10
net0: virtio=72:B4:A4:CD:C6:96,bridge=vmbr2,firewall=1,tag=60
net1: virtio=C6:9F:2F:F2:73:7B,bridge=vmbr1,firewall=1,link_down=1
numa: 0
ostype: win10
scsi0: local-lvm:vm-105-disk-1,cache=unsafe,discard=on,iothread=1,size=150G>scsihw: virtio-scsi-single
smbios1: uuid=74ff8b62-d60d-4d5c-81a0-e3939baa380c
sockets: 1
startup: order=4,up=30,down=30
vga: none
vmgenid: f4593d16-12ab-4483-8962-6c27ee576f05
```
{: file="/etc/pve/qemu-server/105.conf" }

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Over the last few weeks I built a lower power, efficient, and silent Proxmox server! I can run many virtual machine and even pass through the hardware to use it as a desktop simultaneously! <br><br>Check it out! 👉<a href="https://t.co/4u6DW3BS3E">https://t.co/4u6DW3BS3E</a><a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://t.co/32quyBjXH5">pic.twitter.com/32quyBjXH5</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1644736031583875073?ref_src=twsrc%5Etfw">April 8, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
