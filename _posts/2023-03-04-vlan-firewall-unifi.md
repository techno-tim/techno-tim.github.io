---
layout: post
title: "Configuring VLANs, Firewall Rules, and WiFi Networks - UniFi Network Application"
date: 2023-03-04 10:00:00 -0500
categories: homelab
tags: unifi vlan network
image:
  path: /assets/img/headers/network-fiber.jpg
---

## What is a VLAN and How Do They Help?

Today we’re going to cover setting up VLANs using UniFi’s network controller.  We’ll set up a VLAN, from start to finish, which includes creating a new network, configuring a wireless network that uses VLANs, and then we’ll set up firewall rules to make sure we’re keeping our network safe.   If you think VLANs are only for the enterprise, you’re wrong, I will show you how they are helpful at home too.

So what’s a VLAN?  A VLAN or Virtual Local Area Networks, is a group of devices, computers, or servers that communicate with each other as if they are on the same physical LAN, but they are actually located on separate physical LAN segments.  VLANs can be created by configuring a managed network switch to segment the network into different broadcast domains.

So why are VLANs important, even to the home user?

- VLANs are important for security.
  - They can help isolate sensitive data and systems from the rest of your network, improving security by preventing unauthorized access.
- VLANs are important for performance.
  - VLANs can be used to separate network traffic into different segments, reducing network congestion and improving overall performance.
- VLANS are important for management.
  - VLANS can be used to simplify network management by grouping devices based on location, department, or even function making it much easier to configure, monitor, and troubleshoot.
- VLANs give you flexibility.
  - VLANS allow for network changes and reconfigurations without physical changes to your network infrastructure saving you time and money, and we all want to save that, right?

So what’s not to love about VLANs if they give you greater control over network traffic, help optimize network performance, give you better security, and give you management and flexibility?
Well, for me it was complexity and knowing where to start.

{% include embed/youtube.html id='v0B2IDEfnjA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=v0B2IDEfnjA)

## Hardware

Ubiquiti UniFi 6 Lite Access Point - <https://amzn.to/41ZhyR7>

UniFI UDM SE - <https://amzn.to/3yu7vpM>

UniFi UDM Pro - <https://amzn.to/3J8Ebtw>

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

## How to Create a VLAN with UniFi

![Unifi Network - Networks](/assets/img/posts/unifi-na-networks.jpg)
_A list of common VLANs in UniFi Network Application_

- Navigate Settings
- Choose Networks
- Choose "Create New Network"
- Name it whatever we like (IoT)
- Choose something descriptive
- Choose your router (if applicable), but I wouldn't offload routing unless you know what you're doing.
- I typically uncheck auto scale network and define it myself
- We’ll choose the host address and netmask
- While we’re at it we should also choose manual for the advanced section
- Choose a VLAN Id
  - I typically match the 3rd octet in my case that would be 100
- If you’re using Apple devices or Chromecast (or similar devices) on this network, you’ll want to turn on IGMP snooping & Multicast DNS
- DHCP Mode - you’ll want to keep as DHCP server
- For DHCP Range you’ll want to choose the beginning and end of your range.  Can be anything within range.  At home I usually start at 100 so I know which devices are using DHCP at a glance.
- There are other options here that you don’t really need to change but if you do, change them to your liking

Congrats you just created your first VLAN! 🎉

## Creating Wireless Network for a VLAN

![Unifi Network - WiFi](/assets/img/posts/unifi-na-wifi-networks.jpg)
_A list of common WiFI networks in UniFi Network Application_

Once we’ve created our VLAN, we can now add this to a wireless network.  This is perfect for IoT devices or really any VLAN that you want to use over your wireless network.

- First, we’ll go to Settings, then WiFi
- Then choose create new WiFi Network
- We’ll name the network and give it a password
- Then we’ll choose the Network it belongs to (IoT)
- In the network list we can see our newly created network!
- You can make any other adjustments you need to your wireless network, but I am going to keep the defaults.
- Then we’ll hit apply

If you check your access points, you can now see this wireless network being set up and provisioned with the new config that contains our new WiFi network that is bound to our VLAN!

## Assigning a VLAN to a Switch port

![Unifi Network - Ports](/assets/img/posts/unifi-na-ports.jpg)
_UniFi Network application port management_

You can now assign this to one of your switch post by going into your switch and assigning it this VLAN / VLAN ID

Choose the new VLAN and let your device get a new DHCP address from the new VLAN. You should expect to see an IP in the range that we set above.

Once you choose once we assign it, let’s connect a device and test it out.

Connect a device, check its IP, ping google, then ping another device on another VLAN.  Uh-oh!

UniFi allows inter VLAN communication out of the box.  I guess this was a conscious decision from them to make things easier, but it does make your networks open to other networks.  

We can fix that, with a firewall rule!

## Configuring a Network Profile

![Unifi Network - Profiles](/assets/img/posts/unifi-na-profiles.jpg)
_A list of common WiFI networks in UniFi Network Application_

Before we set up our firewall rules, first let's create a profile.  Profiles are a simple way to group items or alias them.  This comes in handy later when creating firewall rules.

- Navigate to Profiles
- Create a new Profile
- Name it something like "(VLAN NAME) Only"
- Set type to IPv4 Address/Subnet
- Add all of your other VLANs
  - `192.168.0.0/24` (this is the default network)
  - `192.168.10.0/24` (this is my "Trusted" network)

Again, this Profile is for all other VLANs, not our new VLAN we just created.

## Configuring Firewall Rule

In order to block inter VLAN Communication we'll need to set up some firewall rules.  The pattern I usually follow is blocking all traffic from one VLAN destined to all other VLANs.  This can be done by creating Profiles.

- Navigate to Firewall & Security
- Choose the Type
  - For inter VLAN communication you'll want to choose "LAN In"
- Give your Rule a description, I usually follow the convention
  - **Block thing to other thing**
  - e.g. Block IoT to ALL
  - Be sure this applies before predefined rules
  - for Action, choose "Drop"
- For Source Type, Choose "Network"
- For Network choose your new VLAN e.g. "IoT"
- For Destination choose "Port/IP Group"
- For IPv4 Address Group choose "IoT Only" (this is the Profile we created above)
- For Port Group choose "Any"

This rule will block all communication that that originates on your IoT VLAN to all other VLANs (IoT Only).

You'll also want to be sure that this rule applies after every rule that you want to allow in your list of Firewall rules.

- Navigate to Firewall & Security
- Check rule order
- Be sure that any rule you create that Allows / Accepts is above this rule that Blocks / Denies.  

## Testing

![Testing Your Rules](/assets/img/posts/vlan-testing-rules.jpg)
_Be sure to test all of your firewall rules!_

Once you have these rules in place, I highly recommend you test your firewall rules.  Some examples of things you should test

- Can you communicate with the IoT VLAN from your Trusted VLAN?
- Can you communicate with the Trusted VLAN from your IoT VLAN?
- Can you communicate with the gateway (`192.168.100.1`) from your IoT VLAN?
- Can you communicate with DNS from your IoT VLAN?

Checking these types of things will help you verify that your network rules are being applied properly.  Repeat these tests anytime you make changes.

## Wrapping up

At this point you should have a new VLAN that works on your WiFi access points, your network ports, and should have firewall rules in place to prevent unauthorized access! You can simply repeat this process for every new VLAN that you need!  Have you set up VLANs yet?

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
