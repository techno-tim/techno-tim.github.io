---
layout: post
title: "Self-Host Code Server in Your Homelab -- VS Code in a Browser!"
date: 2020-08-08 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker portainer self-hosted vscode
image:
  path: /assets/img/headers/code-esc.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4YvCuoxWmjLENK024nh1o6ml/cLeNdiOxsY5jphWO8jsn067mS3muRNZy3YktYPst3bRtcx3GWNwca2W46bqVIOSWHThKzjFuF5R6c/wC8aTcW0e7hoQ9th8Q4RlOk6nKndr3IdVfVP2jT620v1MS88S6oby6KyrGpuZ9qRgqiDzWwiLn5UUcKOwAFeXRwGGVGknFyapU9ZNNv3Fq3bVvdvuXVqS9rV0gv3k9FFJfE9l0R/9k=

---

Have you ever wanted to run VS Code in your browser?  What if you had access to your terminal and could pull and commit code as well as push it up to GitHub all from a browser or tablet?  That's exactly what code server does!  In this tutorial we'll walk through step by step of how to install and configure code server to get it self-hosted in your homelab.We'll start with bare metal and virtualization and then work our way up to Docker, Kubernetes, and Rancher.Then, you don't have to carry around your laptop anymore! You can preserve battery life on the go and leave the intensive tasks to your homelab server.

{% include embed/youtube.html id='_QwQnyoz_-w' %}

📺 [Watch Video](https://www.youtube.com/watch?v=_QwQnyoz_-w)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
