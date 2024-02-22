---
layout: post
title: "I think I found a Dropbox replacement with Nextcloud..."
date: 2020-11-07 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker self-hosted nextcloud portainer
image:
  path: /assets/img/headers/cloud-geese-smoke.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APhf4O/tJeLfih8HPit421SwtrPXPB0VjbweVqOrXNlqOm6nJFcrZ3cU10t2jw+U/mTQXyRXMjhzaxRq8EvzWdZ4srw2DlDLcBVisdhlSg6FKCo1a1R0HXg1TkvaQpzcYNxbiut9T9H4O8Pf9Zs6zXDVuKeJsLUxPD2aSxeIhmmKq1MVhsJg4ZhDBVuavF/V6uKowq14U501Uas4qHuHxTq3x88drquprFbeGBGuoXqxiXT9ZkkCC5kCCSRfEMSyOFxvcRxh2ywRAdo0pcd4/wBnT/2LBfBDaCS+FbJxk0uybbtu3ucuL+jvw4sViUs/4gkliK1nUrwlUf7yWs5RUIym95SUIJu7UYrRf//Z
---

Are you thinking about ditching Google apps or looking for a Dropbox replacement?  Are you ready to self host your own productivity platform?  Well, Nextcloud may be for you!  In today's tutorial we'll walk though setting up Nextcloud with Docker and Kubernetes.We'll also walk through some of the new features, installing apps from the app store, exposing this Nextcloud publicly, as well as setting up 2FA (2 factor authentication) with TOTP clients like Google Authenticator and Authy.

{% include embed/youtube.html id='nt__J9Yr8_w' %}

📺 [Watch Video](https://www.youtube.com/watch?v=nt__J9Yr8_w)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
