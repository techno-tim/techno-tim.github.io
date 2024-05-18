---
layout: post
title: "Replacing the microSD with something MUCH FASTER!"
date: 2024-05-17 08:00:00 -0500
categories: homelab hardware
tags: pi raspberry-pi microsd ssd hardware
image:
 path: /assets/img/headers/no-more-microsd-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AN7VP2pPC3w41Gb4fa18IF8b3tt4wtvCd74lvPFejabcahF4wfUr+2u2gb4d6rqEJ0Etbx2sJ1yd7lIpYZLmKyuTZR/HcV8OZfw9w94b8b1VPMMTxdLMsMsGp1MHDLqdPF08NLmqQqV6WPdR1FU5p4XDzjGCpc0ou6/cPCnwxx/FvDnGWW43jDE1KWVZBm3E0K2OyXL8biq8MkhOUcuq16NTATUaypzUcVC06cqiqVaWKnC8sl9Hv7h2uIdZuLaKdmmitkm1plt45SXSBWGvIGWJWEYIRAQoO1egzWTU5JSjXrQjJc0YKriXyp6qN1iVflWl7LbZbH4/HLaCjFKpiklFJJYvEJJJaJL2miXRdEf/2Q==
---

Today I got rid of the slow and pesky microSD card in my Pi and replaced it with something MUCH faster in my Pi LED Panel.  Don't know what my Pi LED Panel is?  Check it out! This is my first video on the new channel [@TechnoTimTinkers](https://www.youtube.com/@TechnoTimTinkers) 🎉

{% include embed/youtube.html id='4hdeCwJhvgY' %}
📺 [Watch Video](https://www.youtube.com/watch?v=4hdeCwJhvgY)

Disclosures:

- nothing in this video was sponsored

## Parts

Things mentioned in the video (some are affiliate links) :

- Pi 4 8GB: <https://amzn.to/4dG93QP>
- USB to SATA Adapter: <https://amzn.to/3QNr4CU>
- Shadow Box (similar to mine, 12"x16"): <https://amzn.to/4dU7vTs>
- Cheapest SSD I could find: <https://amzn.to/3QPzQQG>
- 32x32 LED Panel: <https://www.adafruit.com/product/607>
- Matrix LED Hat: <https://www.adafruit.com/product/2345>
- Rainbow Ribbon Cable: <https://amzn.to/3V3pz62>
- 5v/10a AC to DC Power Supply: <https://amzn.to/3K5b5MT>
- Desk Mount for Camera - <https://amzn.to/4dDvSV8>
- Phone Mount Adapter - <https://amzn.to/3yquo0m>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

## Notes

This project was built using [rpi-rgb-led-matrix](https://github.com/hzeller/rpi-rgb-led-matrix)

After getting the new power supply I noticed a few odd things

- When powered via hat only with the new 5v/10a AC to DC power supply, the USB drive wasn't recognized
- When powering via USB-C 5v/5a the LED panel was too dim to display some colors so it looked distorted

I read the Pi hat [documentation](https://learn.adafruit.com/adafruit-rgb-matrix-plus-real-time-clock-hat-for-raspberry-pi) over and over, and no where did it mention that anything else was needed other than a large power supply.  I thought for sure it was now a hardware issue and was in over my head.  I dropped a message in a Discord that both [Jeff Geerling](https://www.jeffgeerling.com/) and I are in and he mentioned checking out [this post](https://raspberrypi.stackexchange.com/questions/27708/is-setting-max-usb-current-1-to-give-more-power-to-usb-devices-a-bad-idea)

In that post it suggests to add `max_usb_current=1` to your `config.txt`.

I tested it and sure enough the Pi can now power the LED panel, the Pi, and the USB drive all from a single power supply connected to the hat. 🎉

Thanks Jeff!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark">I just posted my first video on the new (3rd) channel &quot;Techno Tim Tinkers&quot;. 🎉. . <br><br>It&#39;s a project that I have been putting off forever...<a href="https://t.co/aL1k98Z9rO">https://t.co/aL1k98Z9rO</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1791478502773891454?ref_src=twsrc%5Etfw">May 17, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
