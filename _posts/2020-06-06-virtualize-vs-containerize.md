---
layout: post
title: "Virtualize vs. Containerize (Which should I choose?)"
date: 2020-06-06 09:00:00 -0500
categories: homelab
tags: homelab rancher kubernetes proxmox docker portainer
image:
  path: /assets/img/headers/box-purple.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APqrWtHup4fGcMGoR2q6j8ZtF1GFRZCaKztovB0dnd2Yhkudk0t5t3G+/dSQxrFAIpFjLv8At+IwFHD+JvB2Ppc0KlPIOLcvxijJqWPwsHk1fC0a87uPssLiKlavCEqdVOpOM7xnThJftWGryXDWcYaS54RxuV1afM01SqP65Cc4K11KpCEISakvdjbZyT27LSoRZ2glYyyi2g82UNPGJJPKTfII1uCsYdstsBIXO0EgV+mxjQqxVVwqJ1EqjSraJzXM0v3eyvZHzmvdfd/wT//Z
---

Should I virtualize this?  Should I containerize this?  These are great questions to ask yourself when spinning up self-hosted services in your Homelab environment.We'll review my previous video ([20 Ways to Use a Virtual Machine (and other ideas for your homelab](https://www.youtube.com/watch?v=SVQmzaSabEQ)) and decide which should run in a Docker container, which should be virtualized with Proxmox, and which should run on hardware as bare metal.

{% include embed/youtube.html id='pxwUXJmAER4' %}

📺 [Watch Video](https://www.youtube.com/watch?v=pxwUXJmAER4)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
