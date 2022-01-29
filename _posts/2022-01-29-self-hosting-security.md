---
layout: post
title: "Self-Hosting Security Guide for your HomeLab"
date: 2022-01-29 8:00:00 -0500
categories: homelab
tags: homelab hardware security self-hosted
---

[![Self-Hosting Security Guide for your HomeLab](https://img.youtube.com/vi/Cs8yOmTJNYQ/0.jpg)](https://www.youtube.com/watch?v=Cs8yOmTJNYQ "Self-Hosting Security Guide for your HomeLab")


A HUGE thanks to Micro Center for sponsoring this video!

New Customers Exclusive – Get a Free 240gb SSD at Micro Center: <https://micro.center/0ef37a>

[Watch Video](https://www.youtube.com/watch?v=Cs8yOmTJNYQ)

See all the hardware I recommend at <https://kit.co/TechnoTim>

## Intro

When most people think about self-hosting services in their homelab, they often think of the last mile. By last mile I mean the very last hop before a user accesses your services.   This last hop, whether that’s using certificates or a reverse proxy, is incredibly important, it’s also important to know that security starts at the foundation of your homelab.  Today, we'll work our way up from hardware security, to OS, to networking, to containers, to firewalls, IDS/IPS, reverse proxies, auth proxies for authentication and authorization, and even lean in to an external provider like Cloudflare.

Take for instance this diagram.  This most likely makes up most of the things in your homelab and whether that be physical or virtual you will find that you should have most of these components.  But what if I told you that your homelab should look like this?  That might seem incredibly complicated but it’s much easier to set up than you think.  So today we’re going to discuss and review some great practices and architecture for your homelab.  We’re going to take a holistic approach to self-hosting applications out of your homelab.  We’ll dive into individual systems, hardware and configurations, application hosting considerations, networking configuration and segmentation, reverse proxies, certificates and 2 factor auth, firewall configuration internet security settings, and we’ll even lean in to external protection from a provider like Cloudflare.  This will cover everything from the last mile, down to hardware.  

## Don't self host

So, what’s the best way of protecting yourself while self-hosting?
Seriously.  Just don’t do it.  Exposing yourself to the internet also exposes risk so a way to mitigate that risk is just to avoid it altogether.  I know, that’s not why you’re here or what you want to hear, so let’s move on to the next best way to keep you safe.  Also, keep in mind that I am not a security professional, I am just some random person on the internet, so take all of this as a grain of salt and do what’s best for you and cross reference this with any other guide you find and fill in the gaps or strike out what I say.

## VPN

Exposing only a self-hosted VPN is probably the next best way of exposing our services without exposing your services publicly.  This will create a secure tunnel from outside if your network to the inside of your network.  From there you can create firewall rules limit what the VPN client can access.  This is a quick win and a secure way of exposing your services.

## Public

Again, this falls into the “don’t” category but you could just host in a public cloud and mitigate all the risk, but that means then storing some of your data in the cloud.
But for those that want to expose services directly to the internet from home, here is where the fun begins!  Again, most people think of the last mile when self-hosting services but security starts at a much deeper level.  So, rather than focus on this last hope, we’re going to zoom in and start at the server that’s running your services.
Hardware
You typically don’t think of the hardware when you are hosting applications and in the cloud you really don’t – but since we are hosting things in our own personal cloud, we do need to consider this.  The biggest take way here is to make sure that the hardware that your applications are running on are patched with the latest firmware.  
This includes:

* Firmware for the server itself
* Firmware for devices like motherboard, hard drives, network adapters, and any other device that is physically connected
* Firmware for any router or network device in your environment (we’ll get into configuration later)

## Bare Metal or Virtualized?

You’ll need to decide if you are going to virtualize your operating systems or run them bare metal.  There really isn’t a wrong answer here, it really depends on how you want to manage your infrastructure.  The key takeaway here is to make sure that your hypervisor is still actively maintained, up to date, and fully patched.  There are some networking considerations here but we’ll cover that in the networking section since a virtualized network and physical network have most of the same concerns.

## Operating System

Next is making sure you choose a secure operating system that your applications will run on.  This is a big topic for debate so we aren’t going to argue which ones are more secure – you have choices from Windows, to embedded, to many flavors of Linux - but the takeaways here are:

* Use one that is still supported, not end of life
* Patch it regularly and or automatically, and work this into your maintenance schedule
* For embedded systems, be sure to patch firmware regularly
* Use the principle of least privilege, meaning users are given the minimum levels of access
* Don’t run as root / admin
* Restrict who can access these machines
* Don’t install additional services
* Use application firewalls
* OS should be purposely built and maintained

## Containers

If you’re using containers, you have some of the same concerns as operating systems however at a smaller scale.  You’ll first want to be sure that the container engine is up to date, whether that be docker, containerd, podman, or any other – you’ll want to be sure this service is patched and up to date.
Container guidelines:

* Use containers from official sources.  This can be a challenge but you’ll want to be sure that you’re getting your containers from the maintainer themselves or from a reputable source like linuxserver.io
* After you’ve chosen your container, you’ll watch to check to see if they support a minimal image, one that is built on something like alpine.  The reason you want to do this is for a couple of reasons:

* Smaller container
* Less attack surface
* Containers with less dependencies means less to worry about
* Containers will less dependencies have less to patch or have a vulnerability

### Choosing a tag for your container

This is a double edge sword because most people would like to pin to latest and use something like watch tower to automatically update your containers when a new version is available, however latest may or may not have gone through the same rigorous testing that another version has.  This is really going to be up to the package maintainer but my general guidance is this

* `latest` < `stable` < `1.x` < `commit hash`
* Again, most of this will depend on the container maintainer so there really isn’t a one size fits all recommendation here, it’s really to help you decide on how you want to manage new versions while at the same time making your configuration repeatable.

## Networking

There are two sections to networking that are equally important, internal networking and external networking.

### Internal

Starting with internal networking, it’s a must to segment your network if you are planning on self-hosting applications.  The idea behind network segmentation is that you divide into multiple segments or subnets, each acting like its own small network.  This allows you to control the flow of network between two networks based on a network policy.  This is can not only improve performance but also security.  You can do this but subnetting or VLANS. This allows you to keep home “trusted” devices separate from the devices that are directly exposed to the internet, or, “untrusted” devices.  This will help mitigate the risk that if one of these systems get compromised, they can only communicate with other devices on this network, and not your trusted devices, thus limiting the risk.  This is not only a good idea for machines that are publicly exposed to the internet but IoT devices as well.

### External

Now is where the real fun begins, it how the users and devices enter your network.  For obvious reasons you’ll want to be sure that only the ports you need forwarded are forwarded to the proper devices.  In most cases, if you are hosting a website, it’s only going to be port 443 for HTTPS.  You don’t want to open any additional ports.  If you are running a web site, in most cases you’ll port forward to your reverse proxy, however I highly recommend using a public reverse proxy along with your own.  

### Cloudflare

Cloudflare provides a proxy, even with their free tier, that you can use top improve performance, somewhat protect your IP online, provide caching, TLS encryption / certificates, and I think most importantly protect your site from attacks.  Cloudflare is able to detect and block malicious attacks if you use them as DNS.  Since your DNS entry points at them, it’s in their best interest to detect and block these types of attacks since and attack against you is really a attack against them.  This might sound complicated to set up, but it’s as easy as using a dynamic DNS container or script that updates your Cloudflare domain to point to Cloudflare.  This will then route all traffic to go through their reverse proxy and then forward to you with TLS encryption, and if our under attack, you can simply turn on Attack mode to force a JavaScript challenge when people visit.  You can see some of my stats here.
(show traffic, and security, and performance)
So you should definitely set up something like Cloudflare for security, privacy, and protection.

But what’s stopping anyone from just going directly to my IP?  What happens if someone figured out my IP and wants to bypass Cloudflare?  Well, in this setup nothing, nothing at all.  But don’t worry friends, there are ways to protect against this too.

This is where we’ll combine both our port forwarding rules along with Cloudflare to force anyone trying to access our web services through Cloudflare’s proxy, and if they aren’t coming from Cloudflare, block them.
It looks like this.

Cloudflare publishes their list of IPS
<https://www.cloudflare.com/ips/>

From here we can build simple firewall rules for conditional port forwarding.  We can build rules that say, only port forward to our internal host if the source IP belongs in this range.

It looks like this.

While we’re talking about cloud flare you also have the option to block countries or even TOR if you like.  I’ve never really found this to be too helpful because most attacks ill come from a VPN in your country, so up to you whether you want to turn this on or not.

## IDS/IPS

While we’re talking about Firewall and networking we should also talk about IDS/IPS protection.  IDS (Intrusion Detection System) and Intrusion Preventions system) are ways to detect and block attacks.  These systems analyze network traffic for signatures that match known cyber-attacks.  I would l definitely turn these both on, self-hosting or not, because they offer protection against known attacks.  I say “known” because they are only as good as the signatures you have.  So if you are running PFSense this will be Snort or Suricata, and if you’re running a UDM pro or anything else, this might be under the security settings.  As you can see here, I have detect and block turned on, sensitivity is high against 25 categories.  Also there are other settings you might see here like dark web blocker (no dark web for me)  and,  I have both IDS and IPS turned on as you can see here, detect and block.  You can see here that there were some attempts on an attack here but they were blocked.  

## Reverse proxy

Now that we have everything in place, we can now finally meet in the middle and use our own internal reverse proxy.  Arguably if you’re using Cloudflare technically you don’t have to but I do with or without Cloudflare.    A reverse proxy is an easy way to direct traffic from clients to one of your servers (we talked about this with Cloudflare) and it’s also a place where you can have your certificates.  Having them here vs on each individual server makes maintenance much easier. Setting up a reverse proxy can be challenging however I’ve already documented this in another video and the reverse proxy I use is Traefik.  Traefik can route requests to your servers, get publicly signed certificates for you to use, and even integrate with other systems using middleware.  

## Authorization and Authentication

Speaking of middleware, another choice you will have make is whether or not you want your services to have authentication or not.  Some services provide authentication however some may not and some may not provide a second factor.  This is where something like Authelia comes in to play.  Authelia is an auth proxy that works with your reverse proxy to provide authentication and authorization to your services, even if they don’t have an auth system of their own.  This is great for applications that need another layer of protection and with 2 factor authentication helps give you confidence that your apps will be accessed by you and only you.  This is definitely an advanced use case and should only be set up after you have your reverse proxy running.

## What have we done?

After this last step we have made it all the way from the hardware, to the operating system, to the service or container, to your reverse proxy, to an auth proxy, to your network firewall, through the rules and up to Cloudflare and to your end use (should reverse this order so it makes more sense).  You should now have a little more confidence when hosting things, yourself, and remember if this sounds too scary or too complicated, you don’t have to expose things publicly, you can fallback to VPN only, hosting in a public cloud, or nothing at all.
