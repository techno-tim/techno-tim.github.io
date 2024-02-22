---
layout: post
title: "Meet Guacamole, Your Remote Access Gateway"
date: 2020-09-26 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes self-hosted guacamole portainer docker vnc ssh rdp
image:
  path: /assets/img/headers/avocado.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APkz9mn9t79pDXP2ov21vAet/EjXtb0T4Ma3qGpaZZ63cpq2m3fgqD4j3P8Aa3hTS9JvoZrHwprt7pcWgaTpHjjSEa78MwaVqE2m6O8mv3oi/GOKs9zDEZRwnj4VqlCrXqOpHkqTvTxqhRVDGc0XB1HQvVtRkuSoqrjN8l4y+2r5NgMBmWaYF0IV4wlLCUptez5JV/epVXCLkp+wcP4bajVvaTioxS/oD8GX92fB3hP+3rmbX9c/4RrQv7a12RLPTn1rVv7Ltf7R1Z9PsrNbOxfUrzzrxrO0UW1sZjBABEiCofF+f3fLmNaMb+7Hkwk+WPSPPUws6k7LTmnKU5byk5Nt/Wf6oZD9rAUpS6tVMXBN9WoQxMYQTevLCMYx2ikkkf/Z

---

Do you have a lot of virtual machines?  Are you running Windows, Linux, and Mac and need remote access from a single UI?  Well, Apache Guacamole is for you!  Apache Guacamole is a clientless remote access gateway that give you a web portal to access any of your clients over standard protocols like VNC, RDP, SSH, TELNET, and more. Join me in this step by step tutorial as we set up a self-hosted version of Guacamole in your homelab.As an added bonus, we'll set up 2FA (multifactor authentication) to help secure Guacamole.Oh, yeah, and we'll do this all in Docker and or Kubernetes, it's up to you!  :)

{% include embed/youtube.html id='LWdxhZyHT_8' %}

📺 [Watch Video](https://www.youtube.com/watch?v=LWdxhZyHT_8)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
