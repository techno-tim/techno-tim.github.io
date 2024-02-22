---
layout: post
title: "SSL, Traefik, and OAuth for Rancher! (Google, GitHub, Keycloak, Azure, and more!)"
date: 2020-09-05 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes github
image:
  path: /assets/img/headers/wire-cutters.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOH/AGjf27P2gfEvwp8T6VLrmlaN4T1V7KztfB3hvTP7I0DTx9rlaJ/JWe4nu1gOls6RPPEnm3PmHi3jQ/hvC+YZhQzTAVamYY3FYmnW9q6teu5RnCrCp7Sk6SVkpRqOnzczfLunfT7zAZzTqYXH06+V5fUWJy/F4ai4UvZvC1mrUcXD43OrQdNSjG8Vd6OFrnj+i/8ABUL9rLQtG0nRNP8AGcVvYaNplhpVjBDBJFFDZ6faxWltFFEsu2OOOGFERF4RQFHAr3sbw7PGY3F4yec5nCeLxWIxM4U6sVCEq9WdWUYKSb5IuTUbtuyV23qeSqGFglH6tTlypR5mld2Vrv3d3a78z//Z
---

Do you want to self host your Rancher UI securely in your homelab? Have you thought about putting your Rancher UI behind Traefik and your reverse proxy to get free SSL certificates using Let's Encrypt?  Do you want to make your Rancher UI available publicly and secure it using 3rd party OAuth providers like Google, GitHub, Keycloak, Okta, Shibboleth, and more?  Well this is the guide for you.In this step-by-step tutorial we'll walk through setting up the Rancher UI to use Traefik reverse proxy, get SSL certificates using Let's Encrypt, host our UI publicly, and then add 3rd party OAuth providers so that we can use 2 factor authentication (2FA) and all of the other security features auth providers give us.

{% include embed/youtube.html id='Af7HXhElams' %}

📺 [Watch Video](https://www.youtube.com/watch?v=Af7HXhElams)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
