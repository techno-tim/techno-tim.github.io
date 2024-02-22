---
layout: post
title: "Low Power Cluster - Small, Efficient, BUT Powerful!"
date: 2023-04-22 10:00:00 -0500
categories: homelab
tags: homelab k3s kubernetes hardware server-rack home-assistant
image:
  path: /assets/img/headers/galaxy-cluster.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5LvAvjzw98KPgx/wAJxo/w90LVvGXjWzbQ7XWtdnfUE8L/AGK302K6vtK0+S1+zXVxfyRXDhNT+1xWMd1stVW4t4bsehiadSm8JiaGIqUYylN1aUFC1Vtcq56ji5qEZr2kYx5XzW5pySfN1UK9NQqQlh6c5yhT9nVlKadHlmpScIxai5TUVCTmpLlcrJNpx+GbjWJZp5ppILdnlmkkcmOMku7szEloySSSTkkk9yTWXOusU31b6vvqm/vMnWf8sPu/4J//2Q==
---

I’ve been running a few clusters in my HomeLab over the past few years but they have always been virtualized inside of Proxmox.That all changed today when I decided to run my Kubernetes cluster on these 3 low power, small, and efficient, Intel NUCs.

{% include embed/youtube.html id='8DeG3qO-HIA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=8DeG3qO-HIA)

I built a lower power, efficient, and near silent server cluster!  Although this cluster is small and efficient, it's still powerful enough to run a high availability Kubernetes cluster with many services running in High Availability mode!  There are so many options with running a small cluster like this, the possibilities are endless!

## Where to Buy

A HUGE thanks to Datree for sponsoring this video!  

Combat misconfigurations. Empower engineers.
<https://www.datree.io>

- Intel NUC 11 - <https://amzn.to/43TK8nS>
- Intel NUC 12 - <https://amzn.to/3MZjC6C>
- SAMSUNG 980 PRO SSD 2TB PCIe NVMe - <https://amzn.to/41vUOrk>
- SAMSUNG 870 EVO SATA - <https://amzn.to/3KQMriU>
- G.Skill RipJaws DDR4 SO-DIMM Series 64GB - <https://amzn.to/3AlstI8>
- Mk1 Manufacturing - <https://www.mk1manufacturing.com/cart.php>

See the whole kit here - <https://kit.co/TechnoTim/efficient-low-power-powerful-virtualization-server>

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

## Hardware

These [Intel NUCs](https://amzn.to/43TK8nS) are probably my favorite small form factor devices.They are only 4x4 inches and pack quite a punch.That’s because these NUCs have anywhere from a Core i3, to a Core i5, to a Core i7 processor in them.This one has a Core i7 with 4 cores and 8 threads and has a base clock speed of 2.8 GHz and can turbo boost up to 4.70 GHz.It even has QuickSync on this chip too so that I can offload encoding if I need to.You can check out the specs [here](https://ark.intel.com/content/www/us/en/ark/products/205073/intel-nuc-11-performance-kit-nuc11pahi7.html).

![Intel NUC Stack](/assets/img/posts/intel-nuc-stack.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APXf+CpPwO/as8QQ+HfjF8HviR8LPDvhPwR4fi8QfE/S9a0/X7a+8eeJbG00XQ/7SsvDmtaV8U/D2kiPwf4X8P6DE2k6noF1cb9Tkvrm4jXTorXlSwlSTdbDRnJrkjNqLqRpu75Oe0ZcvtJSla9lfRXTb6pSxNBt06rik05xU5pSk0o8ySVruDUXffW9z9Nfg78T/irrvwj+Fmt3nhT4WWt3rHw48EardW1vqXiy5t7e41Dwzpl3PBBc3dl9quIYZZmjinuf9IlRVkm/eM1cFTiPP6M50acMBKnSnKnTlUnJTlCDcYOaWEaU3FJys2r3s2j6ClkWUVqVOtOvjYzq04VZxjQpOMZVIqcoxbxSbim2k2k2t0j/AP/Z
" }
_My Intel NUC Cluster!_

I maxed out the ram on each machine, giving it [64 GB of DDR4 RAM](https://amzn.to/3AlstI8).Should just be just enough to run some of my workloads and another reason I chose not to run a hypervisor on these machines, I wanted to conserve resources.I added a [1 TB Samsung NVMe](https://amzn.to/41vUOrk) drive for the OS and to run all of my workloads, and then a [second SSD](https://amzn.to/3KQMriU) for additional Kubernetes storage that will be replicated across all 3 devices.I may expand this in the future however this was one of many SSDs I had laying around.

![Intel NUC Internals](/assets/img/posts/intel-nuc-internals.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APmfxPonx28fftDfA/QvEfxb8Tab4/f4nfDLVfib478IfELxxoWlavoU3iPw60nhXw/4CXzdGj03wxeW+r2/h2aS80u71bQzpWl63NDGlwR85hcdl/8AYtV0MPWhStJKpJr2/N7N06jlFVXSm5ynCftG1JezSgoRSgfpGc5Zn749wccxxOX4jG1ZU8fGhSdSGWrCxk8ZTwsebCe2oQp0aFaiqUadSnN15yryrVJzqv8AWSbxz+0yJpRqP7Svx1h1ASyC+i0P4sNZ6LFebz9qj0e0vfAV9eWulpPvXT7a7vby5gtBDFPdXEqvM/yy4kxMUoqhhpqKUVOdKXPNJW5p8tZR55by5Va7dtD9BxHhfwtVxFeoqucYf2larP2FDE4X2FDnnKXsaPtMJKp7Knfkp88pT5Irmbd2f//Z
" }
_Intel NUC Internals_

## Installing in the Rack

So once I had all of the hardware buttoned up then I had to decide where exactly I was going to put these devices.Now I could have put these on my workbench or my desk, but I have a server rack in my basement that I wanted to take advantage of.I have a few general purpose shelves but I thought that these NUC deserved a little bit better home than that.I wanted a rack mount system that would hold 3 NUCs, hold them securely in place, and even give me some cable management and that’s when I found this small company that makes all kinds of small form factor rack mount systems.[Mk1 Manufacturing](https://www.mk1manufacturing.com/cart.php) makes all kinds of rack mount kits for small form factor devices like Mac Studios, Lenovo ThinkStations, Mac Minis, and of course Intel NUCs.The nice part about these racks too is that they are made here in the US. I purchased one for my Intel NUCs and quick rack mounted all 3.It was super easy to mount these and they even thought about the cable management for both power and networking.

![Intel NUC Internals](/assets/img/posts/intel-nuc-rackmount-system.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APy7/av0n9um0+L8XjPw78c7Hwh4U+M6j4k2Hhzwl4v/AOEeu9O8K+NoNC+IFp4Vvb/TPgnb3r29lpniPTbGXS9Q1LxLpv8AaNm9z59ybHTLlPo8g4MlmuWU8zjPDezcarUK0q/O5UZulJzjTXJdv4XGS91apNtCxOYyw1SdJXWmrjCl8K6c0ouUns7PRNd0mfrx4H/aN1zwN4L8IeCvEfwV8MeLPEPg/wAL+H/C2veKpPij4ftpPE2teH9JtNJ1TxBJbj9mHED6zfWk+otCOImuSg+7XwNfFYSFetC2Ijy1akeWMabjHlm1aLnUcnFWsnJuVt23c+2wvCGPxWFw2JjicHy4ihRrx53WU+WrTjUXMoUuRStL3lD3U7qOlj//2Q==
" }
_Intel NUC, 1U Rack Mount System_

## Remote Control

I bet you’re wondering how I remote control these devices, because I wondered that too.Well, if you remember from a [previous video](https://www.youtube.com/watch?v=aOgcqVcY4Yg), I picked up a [PiKVM](https://pikvm.org/) and I was able to attach multiple devices to it using an HDMI switch.Ths current switch lets me connect up to 4 devices, but I am going to try to expand to 8 later on. From the PiKVM I can even power on these devices using WAKE ON LAN that will send a magic packet to wake them up.And in the case that Wake On LAN doesn’t work, I can then use my UniFI Smart PDU Pro to toggle the power off then on to force them to wake up.

![Intel NUC Internals](/assets/img/posts/pikvm-interface.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOz0Hwp+0xD4B8EeA/gh4+8AeG7L4MaX4e1j4qw+JdEtZz4isfGpufiL4h03whqV/wCEPGszCx0fxBplpof9p2Gj6edZOvS32lvbX6Sn4vKcXj83w+PxsK9PC4Z1q2Fy6Cp+0r0fYOMZ4jEcz9lOcqnO1RXNDklFc6lFyl99neXZHwxUyPA4jL62Z5hCnh8xzupPGVaGDxlHEc84ZfhI0lGtRhGk4J4puNV1ISfs5QqKFPxrVf2k/wBkLUNU1K/8c+Af2gLzxrfX95eeMLvSPEPgX+ybrxTc3Ek3iC40vdb6Y39nT6s93LZbtN08/ZmizY2h/cR+TNcZwnOKx2SVFGUoqpUw+IjOaTaU5xhDkjOXxSjD3U21HSx7UcL4b4iKrrLuJMOq6VZYenXw1SnQVRc6owqVcV7SpCkpckZ1PfmoqU/ebP8A/9k=
" }
_Intel NUC, 1U Rack Mount System_

## Operating System

After getting this all hooked up and on my network, I then had to figure out how I was going to get an operating system on them.I ended up using MAAS or metal as a service to boot and provision these machines.I chose to go with Ubuntu server for these, well, because I like Ubuntu and so is the rest of my infrastructure so it makes it really easy to manage it.I was sure to reserve a static IP for these devices as well as create a DNS entry for them.

## Why Kubernetes

Now, for the most difficult part of this all, installing kubernetes.I bet you’re asking, why Kubernetes?

> Because.

## Kubernetes

So to install Kubernetes I can do it one of a million different ways and on top of that I have my distributions to choose from.I ended up going with [k3s](https://k3s.io/) because I like how lightweight that it is as well as the active community behind it.

As far as installation goes I could spend the 20+ hours doing it manually but I’ve already created an [Ansible playbook that can do this all for me](https://github.com/techno-tim/k3s-ansible).It does everything that I need to give me a high availability Kubernetes cluster, with both an HA Kubernetes API as well as an HA service load balancer.With three nodes I can lose 1 node and everything will still function normally.

After setting my IP address it was off to the races. 🚀

I sat back and watched the automation run for about 3 minutes, and shortly after that I had a highly available Kubernetes cluster to run my workloads.If you'd like to do the same thing I will leave a link to the documentation and the video where I walk you through all of this.

![Running the k3s-ansible playbook](/assets/img/posts/ansible-k3s-install.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP40PEGu2lrMtrH5/lXFm80p+yQ7t0jylI0BvSFVTAhEgYMnmyBUOwGSIOonapRwesXaVOjGMo7WcWoRalra6atrvfTlhhqa5J36KcHFODTUqkJKSc5p/Dunqt0rHDfatPPO6855/wBRD3/7ea6406LSbnUTaTaVOLSdtbP2iuvOy9CpVKybShTaTaTdSSbV9Lr2bs/K79T/AP/Z
" }
_Running the k3s-ansible playbook_

## Installing Apps & Services

So once I had Kubernetes installed I then copied my kube config file locally so I could communicate with the cluster.I was able to ping the Kubernetes API that is really a VIP and it responded.I then asked Kubernetes to show me all of my nodes and there they were, all three of them.So that was there to do next?  Next I wanted to install some workloads to test out  HA.Now typically I would install Traefik as my reverse proxy and cert-manager to manage my certificates, and LOKI, Grafana, and Prometheus for logging, monitoring, and visualization; however I just wanted to test out a few things before I go all in.

So I decided to install a simple web server that runs nginx to host it.This web site is just a tiny nginx web server that services a single page that shows its hostname, IP address, and port, and a few other things.This was going to be a good test to test high availability. My plan was to create this workload with 3 replicas and then pull the plug on one of the nodes and make sure that both Kubernetes was still up as well as this web page.

So, that’s what I did.

I created a Kubernetes deployment for this container and set the replicas to this.This will ensure that 3 are running but I wanted to be sure that they were spread out across all three nodes.I did this by setting a typology constraint of hostname.This will make sure that only more than one pod is never scheduled on the same node so that I can ensure HA.

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginxdemos/hello
          ports:
            - containerPort: 80
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: kubernetes.io/hostname
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: nginx
```
{: file="deployment.yml" }

So once this was set, I then deployed the Kubernetes deployment and could see that I had 3 pods, all spread across 3 nodes, awesome.

But how to I actually get to this web page?  Well, remember how I mentioned that I typically use Traefik as my reverse proxy?  Well, that’s where this would come in handy.It would allow me to expose multiple services on the same IP, but since I don’t have it installed, I will just expose it on the metal lb load balancer that comes with my playbook.

To open up an IP on the virtual load balancer, all I have to do is create a service with a type of LoadBalancer.This will expose the service on one of the Metal LB Ip addresses so that we can see our web page.

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  ipFamilyPolicy: PreferDualStack
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
  type: LoadBalancer

```
{: file="service.yml" }

After deploying that service, we can then check the service to see which IP address it was assigned.Once we have that IP address we can then get to this web page.

After, we see our web page here so we know it’s working.And it should be HA because we have one of these pods running on each of the servers!

![Running the k3s-ansible playbook](/assets/img/posts/nginx-demo-site.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7v9a8KnU/Eel6z/wAJDrtg9kIxBYWc0QsSEL+fuR1Zk+2xuIbsx4aaKOJcrsBJam+WUqVOc4c3s6kopzp8ytLklbmjzLR8rV1o7qxEqalKM3a8b8raTcbq0uVvbmWjtv1udzQWf//Z
" }
_NGINX demo page_

Now we need to [introduce some chaos](https://www.youtube.com/watch?v=OagTowzqOls).

No, no no no, not that much chaos, just simply removing one of the nodes.

So, before doing that let’s ping our Kubernetes API to be sure that it ups, and you can see it’s up and responding.Next let’s open the web page and keep refreshing it.

Now, we can introduce chaos by shutting down one of the nodes.I can pick anyone that I like but let's go with 2.Let’s also ping node 2 so you can see it going down.

So we shut down node 2 and wait.We can see that  it’s down but out Kubernetes API is still up.We can do a kubectl get nodes and see all of our nodes, and if we refresh our web page we can see that the web site never went down.Now if we shutdown one more now, we will lose access to our Kubernetes api and web page, so let’s shutdown node 1.And as you can see we can’t get to it anymore, but if we bring up node 2 and leave node 1 down we can.

![HA NGINX Test](/assets/img/posts/ha-nginx-test.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APxv/wCCIkOheIP+CwX7IPgm/S4u21fXfilcvJqWmaXf2LQN8AvihcT2lzaM8VvPDLHbXCorWmYXkUlpgT5acU7qSupLlknrFxd004v3XdNp6arR6CcU7tq6kuWzbcWtbpx+HW9m92tHof6b1n8DtBgtLWCObQ1jht4IkVPAXhdFVI4lRVVFjCqoUABVAVRgAACnH3Uox92MUoxjHRRSVkklokloktEgSSSSSSSsktEktkl0SP8A/9k=
" }
_Testing my HA NGINX install, you can see that node 2 is down, but the Kubernetes API still responds and the web page is still up!_

## What else can we do?

Awesome, so now we have an HA cluster but what can we do with it?  Well, I mentioned a few things but you can do some awesome home Kubernetes stuff like install [Home Assistant](https://www.home-assistant.io/), [game servers](/posts/pterodactyl-game-server/), [web sites](/posts/jekyll-docs-site/), or many other workloads, just remember  that not all workloads can be HA out of the box, they have to be stateless like my nginx container, meaning they have no state like storage mounts or state in memory, but they get their state from outside of the container like an external database.

![Stateless k8s apps](/assets/img/posts/k8s-stateless-apps.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7gfGfgbxXr+tX1xp2oa9pNrPLcLHd6P8ZvGXh6RYrjTrC0M0fhyLwjrGh2U0DW832aCCWSGKV5NUDi/vJhD6FPH8uHWHdDBySSSnLAYeVbSpKpriVy1m3zWcnJycFGlfkikS8Fg6lHFxljcyo1cZ7NzlRXO6DpNJLB1KmMSwynFJ1PZUYe0blzRb99+4xkJGiFncoiqXYgsxUAFmPGWbGScDJOcCvPGtElq7Ld7/PzP//Z
" }
_This diagram explains how stateless Kubernetes apps should be architected_

## How efficient is it?

I bet you’re wondering how much power these three devices use, well I wondered the same thing and I checked my UniFi PDU to be sure.I let all three NUCs run a few workloads and kept them on for a few hours and each of them uses about 20 watts of power.Keep in mind that my PDU only shows average power over time so I think they are using anywhere from 15-25 watts.Is that as good as a raspberry pi?  Well, no, but what I do get is an x86 processor with 8 cores, lots of high speed storage, 2.5 Gigabit networking, AES instructions, and even a GPU for quick sync if I wanted to do any kind of transcoding.Also,  it has enough compute to run anything I can throw at it because remember it’s a core i7.

![Stateless k8s apps](/assets/img/posts/nuc-cluster-power-usage.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4zb9tRTxXaNdapqks2oWtzqFxMup3rOy3sNvewcmSMh40uQZIsmPz9xVnADtc6lSrOVSpOU5zblKUnzSbk+Zu76ttt27vuxQjBKMfhhG0bRV7Rj7ukXJJ2S0TkvVHQXUMcd1cxpLeBI7iZFBvLpiFSRlUFmmLMcAZZiSTySTWcJScItt3cYt69Wk+iS+5JdkiaU5SpU5OTvKnBu77xT6WX3JI//9k=
" }
_Each Intel NUC only uses around 9 watts of power on average, with an idle k3s cluster!_

## What do I think?

So, what do I think of these lower power, small, yet powerful devices?  Well, I think they are pretty awesome if you couldn’t tell  by the fact that I bought 3.You can find these devices relatively cheap if you go with a model from a previous year.Is it as cheap as picking up older small form factor desktops?  It’s not, what that might be a perfectly fine option for you if you want to save some money, but I didn't have 3 devices that I could keep around for years to come, not to mention that I still have my first NUC from almost 9 years ago. These little devices are great for servers, especially if you are considering clustering them.And rack mounting them is a great solution if you're thinking about picking up a few.

Well, I learned a lot today about low power servers, Intel NUCs, and cluster Kubernetes and I hope you learned something too.And remember if you found anything in this video helpful, don't’ forget to share, like, and subscribe. Thanks for reading and watching!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr" data-chrome="transparent" h>What a week! I built a lower power, efficient, and near silent server cluster! Although this cluster is small and efficient, it&#39;s still powerful enough to run many services running in High Availability mode! <br><br>Check it out!👉<a href="https://t.co/5VP32kGqP4">https://t.co/5VP32kGqP4</a><a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://t.co/8dWy6FQQVj">pic.twitter.com/8dWy6FQQVj</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1649797964318089218?ref_src=twsrc%5Etfw">April 22, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
