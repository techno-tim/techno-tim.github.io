---
layout: post
title: "Will 10 Gigabit work with Cat5e? - 10Gbe HomeLab Network Upgrade!"
date: 2022-07-09 10:00:00 -0500
categories: homelab
tags: homelab network unifi 10gbe
---

[![Will 10 Gigabit work with Cat5e? - 10Gbe HomeLab Network Upgrade!](https://img.youtube.com/vi/_HaLU3ecUSY/0.jpg)](https://www.youtube.com/watch?v=_HaLU3ecUSY "Will 10 Gigabit work with Cat5e? - 10Gbe HomeLab Network Upgrade!")

After deciding to upgrade my "old" 24 PoE switch to a new 48 port PoE switch with 4 SFP+ ports, I decided to check to see if my old house with old Cat5e network wiring will work at 10 gigabit speeds!  If this works, I will have a 10 Gbe network connection from my PCs to my HomeLab server rack!

📺 [Watch Video](https://www.youtube.com/watch?v=_HaLU3ecUSY)

A HUGE thank you to Micro Center for sponsoring today's video!

New Customer Exclusive, Receive a FREE 256GB SSD in Store: <https://micro.center/6af2da>

Check Out Micro Center’s PC Builder: <https://micro.center/f65221>

Visit the Micro Center Community: <https://micro.center/e64c4c>

## Items in this video

Intel Server Adapter X540-T1  - <https://ebay.us/mQCVfl>

USW-PRO-48-POE - <https://amzn.to/3PbuFYf>

Patch Panel - <https://amzn.to/3yuBduk>

Slim Patch Cables - <https://amzn.to/3yvdmdO>

10GBase-T SFP+ Transceiver - <https://amzn.to/3atGdHB>

Server Rack - <https://amzn.to/3AKfj8S>

Cat5e Spool (you should buy cat 6)  - <https://amzn.to/3PwNeX9>

Cat6 Spool - <https://amzn.to/3Pgk6TC>

RJ45 Keystone Jacks - <https://amzn.to/3IxwMDG>

SFP+ DAC - <https://amzn.to/3Pg96py>

## iperf

Install

```bash
sudo apt update
sudo apt install iperf
```

on the remote machine

```bash
iperf -s
```

then on another machine

```bash
iperf -c 192.168.0.104 # ip of the remote machine
```

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
