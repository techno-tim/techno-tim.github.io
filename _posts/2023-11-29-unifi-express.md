---
layout: post
title: "Setting up your UniFi Express"
date: 2023-11-29 08:00:00 -0500
categories: network
tags: hardware unifi network
image:
 path: /assets/img/headers/unifi-express-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APlTVPHPw8gF9Jffs3/BLW7yHSvsiXWrD4qT7nt7WVLW4MUXxQgW1MMjfaPs+ktplrJNuLQ7WK1+OLirFutKWIwOXYqfs1SU61GrKUVBPlcU6zhB31l7OELu+qufrseHaLhCNHHY/DQ9p7Rxo1KMU+bSSk1RUp30t7SU7dmfF94nhO4vLq4T4eeEbNJ7meZLO0vPHptbVZZWdba2N744vbw28AYRQm7vLu5Mar59zPLvlbkea1pNyVKhFN35V7dpX1sm67bS2u233bZ6iy2jHR1KkmtHKUcPeTWnM7UErvd2SV9kj//Z
---

The UniFi Express from Ubiquiti is here and it's going to shake up how we connect small and home networks.  It's a gateway that has WiFi 6 that runs the UniFi network application and can transform into an access point or mesh when your network grows.  We'll be taking a look at this device, its features, how to configure and manage it, and discuss all the uses cases for this versatile device.

{% include embed/youtube.html id='v1FCTh8vNwk' %}
📺 [Watch Video](https://www.youtube.com/watch?v=v1FCTh8vNwk)

Disclosures:

- I was not paid
- I was sent UniFi Express devices for review

## What is the UniFi Express?

![UniFi Express](/assets/img/posts/unifi-express-1.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APs79pzSvBP7Tvws+HfhH4veFG1/VPDp8I+MbOeDVv7H0MfEOLRvE3h241WfSvD+naLFe+HrqLWmkt/D8kUK6aI7wPc6nLe2Muifh+D8b54Hlw2Hy7G0niaVHD5pWoYyhQliadGth8ZOnTi8LXUYSxWEp1o7e9CClGyP2al4Q0rV60cxoWcqkcPSqYWtVjBN+46k/rVOTajJQdk76yvff4ni/wCCa3wJljjlaxst0iJI2zw14bC5dQx2ibTbmYLk8CW5uJAMB55WzI3TV8eMc6tRqObNOpNp1MRgalRpybvOawsFOf8ANNRjzSu+WN7LePhbhVFKSwDkklJxjjoxckrNqP1l8qb1Su7LS73P/9k=" }
_Introducing the UniFi Express_

This newly released UniFi Express device is here and it’s here to shake up small networks.  It’s a device that’s flexible enough to be used in just about any situation and comes in a small compact form factor with a small footprint.  It’s a compact device that can act as a gateway and provide WiFI 6 to power your entire network, or can transform into a mesh device to expand your wireless network, or you can add it to an existing network and run it in access point only mode.  Yes, it’s that flexible.

If you’ve not yet experienced UniFi’s network app and wireless access points, this might be the best entry point for you, and if you’re already using devices in their ecosystem, this can fight seamlessly with your existing network deployments.

## Specs

![UniFi Express LCM](/assets/img/posts/unifi-express-2.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kLXxXqluIlguGW3V/ngeKN/MGNpBkP7xBjAG08YyK+chiJ04ToxhTamm3KUW5LmVn1t0Vk10PbeGhOSm3NOLjZJ+69dE/K+9tfUvjxTeMAS8uSATyvcZ9ayNLLsvuR//Z" }
_It has a nice little LCM screen that can display useful information_

It’s a small compact device that’s all white.

- It measures about 3 ½ inches long and wide, and sits only about an inch high.
- It’s made of plastic but has an aluminum bottom, I assume to help dissipate heat.
- It’s powered by USB C
- Has 2 network interfaces, a gigabit LAN port and a gigabit WAN port.  
- It has 2x2 2.4 GHz MIMO support and 2x2 5 GHz MIMO support which has a max throughput rate of 573 Mb/s for 2.4 Ghz and 2.4 Gb/s for 5 Ghz.  
- It supports most WiFi standards including WiFi6, and supports the typical WiFi security WPA standards from enterprise all the way up to WPA3.  
- It supports up to 8 unique SSIDS and can service over 60 clients at once, all from this little device.  
- It also has this awesome LCM screen that displays the network status reported by the UniFi network application.  

Setting up this device is easy too.

## Setting up / Network App

After powering it on you’ll want to adopt this device.  It has bluetooth built in so you can adopt it if you have an existing unifi device on your network that also has bluetooth, or even easier from the UniFi network app on your phone.

Then you have the choice of setting up a new system, which is what we'll choose, but you can also add this to an existing system which we’ll talk about later.

You’ll name your device and set up WiFi, and then it will set up this device for you automatically.

It will prepare the system for a few minutes and after that you’ll be able to connect to your newly created wifi network.

Once you’re connected, you can choose to manage the UniFi network via mobile app, or even the web.
If you want to manage this from the cloud you can do this easily in the UniFi site manager.  Once you land there you should see your UniFi Express ad clicking on that will bring you to the Network manager app.

If you’re familiar with the UniFi network app, you’ll feel right at home because it’s the same network application you’re used to with other UniFi products.  But if you’re not, we'll walk through some of the highlights of the application so you can understand how you can use your UniFi express.

### Dashboard

![UniFi network dashboard](/assets/img/posts/unifi-express-3.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4wfgnpemfE743fBzwT4xu9YtPC/jj4l+AfA3iS78Ptp48QW3hzxB4h0rw3qEminUbSbSl1Sy0a6b+ynv7Se1F7DDNeRTq0wfejUSqUvaL93zJVOSFNzdOTtU5eeMoufK3yOaajKz6GM6cpU5xpzUKko+5OSnOEJpLkk6catKUoppOUI1qbnG8eeN7r6m8d/s6fBfwx448ZeGtP8YfF97Dw94r8RaHYvd2/g+a7ez0nV7ywtmupoPscEtw0NuhmkhtLWJ5CzR28CERL69LB5VOlTnOpmCnKnCU1CGGcVKUU5KLcotxTbSbim1a6WxpKsuaXs8ucqd37OU87dOcoX92U6cciqxhJxs5QjVqKLvFTmlzP/9k=" }
_It comes with the UniFi Dashboard_

This is going to give you a heads up display of your network health and statistics. First we’ll need to turn on dark mode, there that’s better. The dashboard is great for seeing how your network is doing at a glance.  From here you can drill into the different aspects of your network or for example if you wanted to see why this device is the most active, you can drill into it, see details and insights about the device, and even test the latency right from here.

You can also discover these features using the navigation on the left.

### Topology

![UniFi network dashboard topology](/assets/img/posts/unifi-express-4.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4XLC5VLi2DRyTSi5ttpkuZPIOJcMskSKrurAoBtmjK7W5bcAvRSnSTXNTcpvRSlO8eZv4nDlXNZPSPOldXd9jKcZtPlnyqz2jqlptJtpPfXle60Vtc8yy5P72Tqf42H6ZrnZqtdT//2Q==" }
_Topology shows how data flows through your network_

Topology will show you your network typology and how each device connects to your network.  It also has this cool visualization of how traffic flows through your network, I would watch that all day.

### UniFi Devices

![UniFi network dashboard unifi devices](/assets/img/posts/unifi-express-5.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4c7++H2iVkEwAjsgqmXsYJC5LKACzNhjhFBbJ44o9dRW0stNP66mEb2QEjzZ+v99v/AIqgZ//Z" }
_This section shows all of your UniFi devices_

The unifi devices will just show your unifi devices on the network.  This will look pretty bare with only a unifi express but if you  have a more complicated network like I do at home, you can visually see how each device is connected.  We’ll make this light up a little later with another device, and even create a mesh network with that additional device just waiting to be adopted.

### Client Devices

![UniFi network dashboard client devices](/assets/img/posts/unifi-express-6.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4qvgt4esviP8ZfhR8P/Euqavp3h7x58SvBHg/Xr/Q0sn1mx0jxP4o03SNSvNJjvlNk+pW1rfTTWKXgNs1wkST/ALksKqLTlHnbUXKKk0lJpNpNqLcU2k7pNxTfVbgraXvbyetv8/U+tvHH7PHwh8NeNPF/hyw8YfFeSx0DxR4g0SykvLTwhNdvaaVq13Y2z3U0ItYZbhoYEM8sVrbRySlmSCFSI19qlhcplTpynPMYzlCEpxhHDSipOKclGTlFyindJuMW1ZtJ6DlXhzP2eXSnTu+SU85VOcoX92U6cchqxpycbOUFVqKLbiqk0uZ//9k=" }
_This section shows all of your client devices, non-UniFi devices_

In the client devices section you will see all of your client devices, your non unifi devices that are connected to the network. You’ll also see some more details about each device and you can always drill into each to see more information about them.

For example we can see that this device here is connected to the unifi express, using WiFI 6, and the connection is excellent. And here, again, you see insights, settings, and even test the latency for the device.

### Ports

![UniFi network dashboard ports](/assets/img/posts/unifi-express-7.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4pPgr4c074kfGX4V/DzxJqGq6Z4e+IHxL8DeDfEGpaII7jWrHSPEvinS9H1G90iPUpvsj6la215LPZJculvJcRxx3DCBpBVRtKUVNyUXJKTS5pJXs2k3FSaWyckm7arcElpe9k9bOzffyb1e6avra6PsTx1+zL8F/DPjfxj4c03xZ8W307w/4q8Q6JYPejwzNePZaVq95YWrXc1u1pBLdNBBGZ5IbW2ieUu0dvChEa+3Sw+VSpU5TqZlGcqcHOMI4aUIycU5KMnKLcU7qLcYtqzcU9AlWjzS9nl85U7v2cp5zGnOUL+7KVNZBVVOTjZygqtRRd4qpNLmf/2Q==" }
_This section shows the port manager.  The UniFi express only has 2._

In the ports section you see the port manager for each device.  This is where you can manage the ports on your device. With the unifi express, we only have 2 ports.  1 LAN and One LAN.  As far as port management goes on the WAN device, we can only manage the negotiation, but on the LAN side we can manage all aspects of the port.

We can rename it, disable it or enable it, we can change the VLAN (if we had more set up, which we’ll do in a bit) Allow or block tagged VLANs, and even some advanced configurations/

### Radios

![UniFi network dashboard radios](/assets/img/posts/unifi-express-8.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4vPg3oemfEj4sfCX4Z+IdR1PTPDvjX4o+EPC2uaxoVjYHxFBpfi7xLomiajNZm9ma0urjT7WWW50m2vibSO7Leb+7mlqqfI5Q9o6ns3OPtOSXvuDa5uXmbjzct+W+ifkTJNp2aUmnZvmai+j5IyhzJbuKlDmWnMr3X1X46/Z3+DPhjxv4x8Naf4u+Lj2Hh7xV4h0Oxa7tvBs921npOr3lhbNdTwR2cM1wYbdDNLDZ2sUkhZ47aBCIl9ulhcolSpynXzaM5U4OUYOjKEZOKcoxk6sXKKd1FuMW1ZuK2Ldand+zy1zp3fJOebwpznC/uynTWQ1lCclZygqtVRbaVSduZ/wD/2Q==" }
_This section shows the radio manager._

The radios section is where you will get lots of wireless insights.  You can see which network you are managing and other information.  But if you look at the top this is where you will see some really interesting insights.  Coverage is going to show you how dense your network is compared to the clients that are connecting.  This is helpful because it will let you know if clients are too far away and if adding another AP is recommended.  Connectivity is going to show you if any clients have connectivity issues which is super helpful if some of your clients have issues connecting.  

![UniFi network dashboard environment](/assets/img/posts/unifi-express-9.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4yfg/4V8J/EL4xfBzwF4mu/FWn+HPHXxJ8AeEPFt94evLL+3Y9H8S+J9P0vWL3RP7TiuNOXV4dP1GQ6b9vgnskuIYPtEMkfnedolTVZRnz+y9qoycbe09nz2bjf3XPl2vaN9xQ1Ub2u7Xttd72vt5N3Ppvx1+zj8E/C/jbxj4asfFPxblsvD3irxDodnLeR+GJbuW10nV7uwt5LqWCa1hluHht0aeSG1tonlLNHBChEa+vSwuUzp05VKuZRqShCU1CGFlBTcU5KMpOMpRTbUXJJtWbSehpKvTUpKnlrnTUmqc55z7KcoX92U6cciqxpylGzlCNWooNuKqTS5n/AP/Z" }
_This section shows other SSIDs in the area_

Environment is going to show you all of the other networks in your area.  This is really helpful for choosing your network channels for WiFi, something that UniFi can do for you automatically that we’ll see later. And speed tests are where all of your client speed tests are.  This is a hidden gem and yet another reason I love UniFi products.  

![UniFi WiFiman](/assets/img/posts/unifi-express-10.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AG/tN+IPht8Q/wBgd/2lLvQry4X4y/BbxDNc+Bv+Ee0Pw5pen67Z/EDW/Ai38t14e1ZRNaaYJNT1nRtP0600qxTUvsdxdWbyzak9x9bwdnuXZrmcMTjqmeLK814ZeCUKGIoyxuHzWjl2IrQxPJiZ18LPCVsfJ0MRCHscUsv5J0a8K1N0ans43F5vlFStkGVU8iWMhi8RSx+YZnlVHNJVsnzHDUqWJwuBdeEZZdj6Cpwr4DM6SnicJP6xRoulPErGUP5Np/hf4VaeYnSNGUmWQlV0m3KqS5JAJYEgdASASOoFbf2Uv+gqf/gj/wC+CP7OX/P/AP8AKEf/AJYf/9k=" }
_WiFiMan is a great app that works with UniFi network application to test your network and save the results_

They have great mobile apps like WiFi man.  WiFI man will help you test your network speeds from the client to the internet, check your WiFI signal, and even help you connect your device to VPN.  Once you run a speed test on your device, the results will be stored in the Speed Tests section so you can compare results later.

### Gateway

![UniFi network dashboard gateway](/assets/img/posts/unifi-express-11.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4wfg54c8L/ABH+NXwf8AeKW8Q6X4Z8Z/E7wX4L8V6j4Y1CP/hIzoviLxhpOkanqGlf20l/pcet22m6hOdOE9t/Z32uG2e6tpE80PpTcHUp+0UlDmjzum/f5brmcedtc1r8t7K9riX2Vum0tbbNeWn4WPqvxz+zv8FfCnjbxj4WsvFPxcns/DXinxBoFpPdr4ZkuprXR9Wu9OgluZIJbaF7iSK2R5nhtreJpCxjgiQiNffo4fLJUaUpzx6m6cHJRjQcVJxTkot1ItxTuk3GLa3S2FOdNzk6eAqSpuUnTlPOYU5yg2+WU6ccgqqnJxs5QVWqou8VUmlzP//Z" }
_Gateway shows which clients are using which services across your entire network_

The gateway section is going to show some of the metrics from your gateway.  This includes classification of services being used across your network.  You can see which apps, services, and protocols along with the amount of data they are using.

### System Log

In the system log section  you can see different types of alerts and logs for your device and even manage push notifications for alerts.

### Settings

In the settings section is where you can find all of the configuration options for your network.

### WiFi

In the wifi section you can create new networks, like a guest network in just a couple of clicks.  You have a whole host of options for configuring wireless networks here.

One of the other options you might have seen in the WiFi section is the option to optimize now.  This option scans for wireless networks and tries to find the best wifi channel for you to use.  I would recommend doing this right away, and then again on a schedule which we’ll cover in a bit.

### Networks

In the network sections this is where you will configure some advanced options like VLANs.  I won’t cover this here because I’ve already covered this in depth in a video, but this is where you would do it.

### Internet

The internet section is for configuring some of your WAN options, things like static IP addresses, dynamic DNS, and others can be configured here.

### VPN

The next section is for VPN and that’s where this device really gets awesome, not that it wasn’t already, but you can set up Teleport, which is UniFi’s 0 configuration VPN we talked about earlier with the WiFi Man app which will allow you to create a VPN connection just by sending a link.  It’s super handy.  If you don’t want to go that route you have your more traditional methods for doing that, with WireGuard, OpenVPN, and L2TP.  You can also configure this to be a VPN client of another network, or set up a site to site VPN connecting this network to another network.  Again, these are the same options you see across all unifi devices that support the UniFi network app.

### Security

In the security section you do see a slight difference between this device and some of their other devices.  This device does have IDS and IPS so you’re going to see any configuration options there.  IDS and IPS will help detect and block different security volitions based on rules and heuristics.  You do see this option on devices like the UDM pro but it’s missing on this device.  

I think the reason for this is:

1. cost
2. performance
3. make it more modular

It seems they are breaking this up a bit but we’ll cover this a little later. But here we can configure general security including ad blocking and country blocking, traffic rules that can apply to different categories, port forwarding, probably the most important thing in this section, firewall rules for your VLANs and your WAN.  

### Routing

We also have routing which is for creating static routes

### Profiles

Profiles where you get to create groups and settings that can be applied to ports, speed limits, RADIUS users, and IPs.

#### System

And lastly in System we can change UI settings, schedule automatic updates, schedule automatic backups, and turn on some additional services in the advanced section.
Who is this for Meshing

## Use Cases

After looking at all of the features that are supported in the UniFi network application and those that aren’t, you might be wondering who this device is for.  The more I thought about this the more use cases I came up with!

### Small Business / Small Networks

First of all, it’s obvious that this is for any small business that wants a low cost but powerful network management with WiFi 6.   It lets you create and manage a new site with vpn capabilities for a fraction of the cost of a typical deployment and on top of that it gives you WiFi 6.  It then allows you to expand the network by adding additional switches and other UniFi access points.

And if that site expands in the future, you can add additional UniFi Express devices that can act as an access point only and even mesh mode. That’s right, if you adopt this device to a network that already has a network controller running it will run in access point mode allowing you to extend your wifi range.

### Existing Networks

This also works for existing UniFi networks.  Say for instance you have a network set up already and want to add a simple, small access point, you can plug this in, adapt it to your existing network, and have a wifi range extender in minutes.

### Remote Workers

This is great for remote workers too, since it can connect back to your corporate network with a VPN connection.

### Home Network

![UniFi express at home](/assets/img/posts/unifi-express-12.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4cPAXib4XWfgLxxoPj7wJquva9ql1pt/4c8ZaHrcGmat4cayiukfTxb3ljeWd1puqz3Yk1QPGLphb2htJ7byZ0vOGeC9pi4YlYnFw9hRahhqdanDB1JynySniqUsPVqV0qc3yRp1sPKFWFGo6k6cKlCt6tPN/Y5XiMqeAy6q8bi6VaWY1cPUnmWHVGnUl7HCV44inTo06sl+9U6NZSheKjGThVpeMte3DszNLlmJZiYouSTkn7o6k+grpVGC0UFZaL3pbLY8vTq3f0X+Z//9k=" }
_UniFi express is an easy recommendation for home use_

This could also be used at home for the home user.  It’s more device than most will even need at home but provides a simple way to create a mesh network at home.    You can start with one and expand as you need.  And a majority of home users only use wireless anyway so the fact that it only has one network port is fine for most people.

### Mesh Network for Expansion

This also applies to anyone that has a Dream Router that wants to add some more coverage to their network without running ethernet cables and worrying about Power over ethernet.  With an express you just plug one of these in, mesh it, and you’ve expanded your network.  This is really helpful if you also have UniFi Protect Wireless cameras or DoorBells that aren’t near your router.

### Remote Tech Support

And a few personal use cases that I’ve thought about are installing one of these at my family’s house for the occasional remote support that comes up every now and then.  This makes troubleshooting their networks remotely so much easier than walking them through it.

### Travel Router

![UniFi express at a travel router](/assets/img/posts/unifi-express-13.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APjL9o/41eIIP2h/Hl1qXh7wv4h8Y6j45utGxe6dplr4ce18PfEjxRoOHD6Lql/Zz2+lXXhKCwv9Lis7+U6fdvqE0s1jYT3XkxrypOgqEVKdR2Ua05qmuXD+2lzcrlzJuMvd5deZLmjGNn1UaVKT9piHUUYqSkqSu2nLlVoynGmpOTivaWcoxTaUm1FfbEvxE8eanLJqVp4T8Cx2moSPfWqXOrzm5S3u2M8KXBj8ENGZ1jkUSlGZPMDbWK4Ncb4i9l+6r4KPt6f7ut7Kvz0vaw92p7KU6MJyp86fJKcIScbOUYttL2Fwxh6qVWjja3saq9pS9rh4Rqezn70PaRhXnGM+VrnUZyipXSlJWb//2Q==" }
_This might replace my travel router... time will tell_

And lastly something that I plan to use this for is for my travel router.  I’ve always wanted a UniFi device that’s small enough to travel with that provides secure access back to my home.  Now I know that’s super specialized but it’s something that I’ve been trying to build on my own for quite some time.

## UniFi Express is Versatile

![UniFi express to expand your network](/assets/img/posts/unifi-express-14.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APs/4d/D/wAMfA3xHqunW1rca74fvNAk8T6deahB4RfxXpPiTxt491XWrvTdP1ODwXZCw8CeD/D+rw+Bfh14ctpPtfhzwtoGgWFxquowWIgr8eh4uUKVVSxOUVqlKNKMXGFenzKopXnNNxi5Ra92MHJKNk3e9l+mS8K44qNqWZRp1uaSUpUp8jhG/LGSjU36uSTb2urXeF4haQa/rg0jWPE0elDWNSGmR32oaJJex6eL2b7El5JF4Z8p7pLbyluHj/dtMHZPlIrpfi3hptyhgcZGEnzQjKOGbjF6xTftdWk0m+rIXhPbSeLoSmtJSU8QuaS0lK3Lpd3dj//Z" }
_UniFi express is a great way to expand your network_

The more I think about this device the more use cases I come up with, from the first time home user that wants reliable WiFi at home, to the "pro-sumer" at home that wants to dip their toes in the UnFi ecosystem at a budget, to the company that wants to give a small remote site wifi access and the ability to expand while still managing their network, to the remote user that wants access back to their corporate LAN without a bunch of network gear in their home, to me, the odd ball, who just wants to bring a device with them when the travel so that all devices can securely connect back to home.  I am sure there are plenty more use cases I missed, so let me know your thoughts in the comments below.

Well I learned a ton about the net UniFi Express, how to mesh wireless networks, and I hope you learned something too, and remember if you found anything in this post helpful, don’t forget share with a friend!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">The past week I have been testing out a new device from Ubiquiti. It&#39;s the UniFi Express and it&#39;s here to shake up small networks! <br><br>👉<a href="https://t.co/E1CNDH5uNw">https://t.co/E1CNDH5uNw</a> <a href="https://t.co/svs44LnsqW">pic.twitter.com/svs44LnsqW</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1729878459013550204?ref_src=twsrc%5Etfw">November 29, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Where to Buy

UniFi Express:

- <https://l.technotim.live/ubiquiti>

Other items in this video (because I know you will ask)

- Slim Patch Cables: <https://amzn.to/3SXNGm0>
- Cozy Digital Fireplace LED Light: <https://amzn.to/3SVJQKf>
- Flickering Fireplace Lights : <https://amzn.to/3uvqcud>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
