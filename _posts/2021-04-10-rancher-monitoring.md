---
layout: post
title: "Monitoring Your Kubernetes Cluster with Grafana, Prometheus, and Alertmanager"
date: 2021-04-10 09:00:00 -0500
categories: kubernetes rancher 
tags: k3s rancher kubernetes grafana prometheus homelab
image:
  path: /assets/img/headers/monitoring-dashboard.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APxW/Zr8XXutfDm4sotK8Ox65rdzrll4j8Saxp134ln8R2WiaHb6jplrqWmapqR021WyS/ihtrjQYdGvkl060uJLuZHvLa6+uzLCqMZ1Pa1eWT9nCnBUqfsXJScp0qkKXtk5SUZOM5zjokko6HyuU4pyXsfY0XUj7869R16sqqi4csZ0Z13h7RjNxTVK/V3ep8Bav4q1WTVdTkmjsGlk1C9eVo01G3jaRrmVnZIIdUWGFCxJWKJVjjXCIoUAV1UMuwMaFGMcNBRjSpxinaTSUEknKScpNL7Um5PdtvUwrZjmLrVXLGVHJ1ajbScbtzbb5YyUVd9IpJbJJH//2Q==

---

Today in this step by step guide, we'll set up Grafana, Prometheus, and Alertmanager to monitor your Kubernetes cluster.This can be set up really quickly using helm or the Rancher UI.We'll install and configure, set up some dashboards, and even set up some alerts using Slack.All this and more in this simple to follow, easy tutorial.Setting up Grafana and Prometheus has never been so easy.

{% include embed/youtube.html id='4HIn5SBGjCg' %}

📺 [Watch Video](https://www.youtube.com/watch?v=4HIn5SBGjCg)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
