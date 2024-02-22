---
layout: post
title:  "Containerizing HandBrake with Docker and Kubernetes"
date:   2021-02-16 09:00:00 -0500
categories: self-hosted
tags: rancher kubernetes handbrake docker homelab self-hosted
image:
  path: /assets/img/headers/tire-brake.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5jPGPwy0TwXqPjHwL4aeW10m2bw5P4fub97vUNQ8LSXjWvjHUY9ClN7b21rFd3WnvbNcNavrLJcsbrWLyBTaSfAYyNapxJl3+1V6Xs8Nj5V4UFQp0cZTVPlo08SnRniJKg8T7SCjioUfaQ51QjKfNH974axmGoeDXHMauUZbj/AGudcNwwGJzB5jXxuSYvE4mhUxeOyjlzClleGrYvD5Y8FXqzymrjqmExMqE8dLD040JesaL8bfER0fSTNYWc8x0ywMs73uso80ptYjJKyQ6jHEjSNl2WKNI1JIRFUBR9GsLov31XZfyfrFv72fjEpQu/3UN3svM//9k=

---

Handbrake is a fantastic open source transcoder.It allows you to transcode, or convert, your video files into different formats. It has a nice UI that's easy to use and helps you transcode videos very easily. It supports profiles that are optimized for your target devices. And because this is open source and cross compiled, you can run this on Windows, macOS, or Linux...but did you also know you can self host a containerized version of this with Docker and Kubernetes?

{% include embed/youtube.html id='vyrj6t8xjoQ' %}

📺 [Watch Video](https://www.youtube.com/watch?v=vyrj6t8xjoQ)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
