---
layout: post
title: "Will 10 Gigabit work with Cat5e? - 10Gbe HomeLab Network Upgrade!"
date: 2022-07-09 10:00:00 -0500
categories: homelab
tags: homelab network unifi 10gbe hardware
image:
  path: /assets/img/headers/highway-10gbe.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APwI+G2kPrdrCP7S1CxNxewQq9tPIrxP5d0kEoZHjytsluIo7cBIGhKRyq5jVj6uZ1YQr4jBVsNhsTRjhMfioKtSjJU6uFwzxMuRSUv94a5a8m3OT95TTUVH8A4YyGlmdCvLE4ivONWrgqMYSfMqc6bqYVVtZaydJxi4x5IuFKlGV5QUzkdb8bxaTrWr6XL4b0i/k03VL/T5L6ZrmKW9ezu5bd7uWKKQRRSXLRmZ44gI0ZyqAKBXTl+RRxeAwWLhjsXh44rCYbERw8PYThQjWowqKjGc6TnONJS5Iym3OSinJttnj4zEYDB4vFYNZVh6iwmJr4ZVJzlz1FQqypKcvdfvSUeaWr1b1Z//2Q==
---

After deciding to upgrade my "old" 24 PoE switch to a new 48 port PoE switch with 4 SFP+ ports, I decided to check to see if my old house with old Cat5e network wiring will work at 10 gigabit speeds!  If this works, I will have a 10 Gbe network connection from my PCs to my HomeLab server rack!

{% include embed/youtube.html id='_HaLU3ecUSY' %}
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

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
