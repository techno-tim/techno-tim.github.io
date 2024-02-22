---
layout: post
title: "Virtualize Windows 11 with Proxmox the Right Way!"
date: 2021-10-22 8:00:00 -0500
categories: homelab
tags: homelab proxmox windows-11 virtualization
image:
  path: /assets/img/headers/glass-layers.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APtn4tfC7wxF4f1jxDeTa/4k+HL674f8HH4L+KtYe+8G2FzqXiSx8ILrWg3mjW/h7WtFFvc3g1yPSorqe0tHi/svRJNEsZDt/Qqc604U6NScPbOhLFvFUqUKdSSp0vbKnOL9pGTtDl9ouXmcuapGpZRPj8VSpUfaYumqksK69LBvLq9R1MPF1MSsG61GUFRnTd6irKm+eMHBQoulfnXw5rv7Rt94F1vWPBEvgXw5r0ng7VdQ8Kya5e6l4ne91l/D13NpD6tdtqGsatftdai1mby4a+1XU7wyzObnUL2Yvcye1Swsq9KnX+sVIe2pwq8ijStH2kVPlXLThG0b2XLGK00ilovDrZjPC1quG9hQqfV6k6HtJSxPNU9lJ0+eXPiak7y5eZ805yu/enJ3b//Z

---

Windows 11 is here and with it comes new hardware requirements.These requirements not only affect physical hardware but also virtual hardware too.The TPM 2.0 requirement for Windows 11 is shaking the tech community, HomeLab community, and even virtualization too.Well have no fear,  today we're going to virtualize Windows 11 with a virtual TPM chip!  We're going to create a virtual machine according to proxmox best practices and even install a virtual TMP chip so that you can test Windows 11 with your hardware and software before upgrading Windows 10 in your HomeLab or production environment without any hacks!

{% include embed/youtube.html id='fupuTkkKPDU' %}

📺 [Watch Video](https://www.youtube.com/watch?v=fupuTkkKPDU)

## Links

Windows 11 Download

[https://www.microsoft.com/en-us/software-download/windows11](https://www.microsoft.com/en-us/software-download/windows11)

KVM/QEMU Windows guest drivers (virtio-win) download

[https://github.com/virtio-win/virtio-win-pkg-scripts](https://github.com/virtio-win/virtio-win-pkg-scripts)

Need to Upgrade to Proxmox 7?  

[See the guide here](/posts/proxmox-7/)

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
