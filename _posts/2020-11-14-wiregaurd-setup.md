---
layout: post
title: "Meet WireGuard, the new hotness in VPN..."
date: 2020-11-14 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker wireguard self-hosted vpn portainer
image:
  path: /assets/img/headers/energy-ball.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5CPBdx4cX4a+LUuvCWn3urSvpkNlrst7qEd7pqH7W10IIIZksZhfKPLuPtNvJtRIhB5Obv7X9nljoyyud8LQd1UpzlOLlOTcbwmpJxjBwad0oNTUmnZ3b+SzCdKljMwjU+uyx6eUVctxmGx9TC0sDThXxEczoVsI6ddY6OZ0J06alOvQeDqUI1KaqQnUoy8NaSMsxFtABuOB+9OBngZ83nHrXykqkVKSVNJczslJ2SvstNj66FO8IuSpylyxvKSrOUnZXk39Y1berfVn//2Q==

---

Self hosting a VPN has traditionally been hard to set up and we've had very few options.That is until WireGuard came about. WireGuard is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography.It also supports running inside of a Docker container and that's exactly what we'll be using in this tutorial!

{% include embed/youtube.html id='xlyTCuWqDOg' %}

📺 [Watch Video](https://www.youtube.com/watch?v=xlyTCuWqDOg)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
