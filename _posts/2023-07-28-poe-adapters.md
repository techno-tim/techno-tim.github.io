---
layout: post
title: "Power Over Ethernet is AWESOME!"
date: 2023-07-28 08:00:00 -0500
categories: homelab
tags: hardware zimaboard poe
image:
  path: /assets/img/headers/power-over-ethernet-is-awesome-header.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4xrL43R22k6Xp998Lfh3rU0NulqNW1C9+KFvqzS2tswuL9bnR/iTpcVnd6nLNFPqA0qDTrSR7O2iitYbTzrabso5Pk8FVoQyvAxhiY0/apYXDpSVOU5wi17HVRk5NXb1k2c2Mz7iGvWwuMqZ5mbll/t1Qh9dxfJfEU6dOpKcViFGbcIxSvH3eVNWsreKX159tvry8WEWS3d1cXK2drc30ltaLPM8otreS/ur2+eCAP5UT3l5d3bRopuLmeYvK/sqH9+o/Nzk2/Ntu7fdvVng/WWtFRw0V0jChCMYrpGMYpRjFLRRikkrJJI//Z
---

I was unsatisfied with the huge wall adapter that many products ship with, so I replaced it! Want to power a mini PC or a smaller device with Power Over Ethernet (POE)?  No problem!

{% include embed/youtube.html id='qM1HUfcQJvA' %}
📺 [Watch Video](https://www.youtube.com/watch?v=qM1HUfcQJvA)

## How I use it

> *Power Disclaimer: Be sure to check your device for the appropriate voltage and wattage. As with all power adapters, using something that isn't intended for your device can break your device, switch, or both!*  
{: .prompt-danger }

Power Over Ethernet or POE. It's awesome!. I have some small low power devices that have barrel plugs and they have these power adapters that take up a lot of space. Also, this ZimaBoard (and even Raspberry Pis) have a power switch to power on and off. To power it on and off I have to unplug it and plug it back in and unplug it and then plug it back in.

I wanted to find a better way to power these devices, and that's when I stumbled on this little POE adapter. This little adapter plugs into my POE switch and delivers power to the device. So it will pass through the network too. So if I plug it into my switch and plug it into the device, the device will power on. My POE Switch is managed too so I can use its console to power the device on and off.

Now to power the device, I can just unplug the network cable!

![POE Adapter!](/assets/img/posts/power-over-ethernet-is-awesome-1.webp){: w="338" h="600" lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIABIACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APgL9nb4Xf8ABTbwr8Q7bxv8bvBn7Sfi7wh8OfB3hzxvHe+DvEXgHSU8Kwa/4Svr/wAPa74g8QeDtZ04anb3HhGw04afHM2qK6WVpZ6rMYLOPSrrw5rEznhYSnl9NPFVKdaNCNZSqU4OEeSDq8ip1IVHJynJ1qcoe5Gn7Sca9DnUMdeE5SpqMPfqqPtpKVKUE42UmuWV7786t7ripPnp/vzf+Pf2vNOvr3T7G++KupWVhd3NlZ6i+vhXv7W1meC3vXWbT5Jla6iRJ2EsjyAyEO7Nkntj9UcYvlSvFPWlQb1XV21fmdThXTavDRtayl0+T/Nn5U+IP23fjV4Y+OPi+XVP2RNY8QaZoem+F/DWqeF/DPxPvbax1DwVH4B03T5tKuNX8I/EWXwx4u+Jdh4U8PvFo2h6dZyahqHh21urOaW4Ny+rXXxccwr0MvqVKmbueMVflpyWCw8sH9YlOpKtCpiVQqezimqahOnLVyqOVoQR+/8A+p+TY/iCODwvDdPAZPPKvrUXUzXMP7bnGNnTxMMBis1oSi3F+/gamDnO/LNVV7WEX+ilj/wW0/YyFlaDVPHcXh3Uxa241Hw/rvgq7i1zQr4RILvR9ZieNnj1XTLjzLLUY3ZmS8gmViSCa8OWb8URlKLy7CtqTTcadRptOzaf1pXT6Oy06Hrw8OOBZwhOOYZtKMoxlGSx2DtKMkmpK2VTVmnfSUv8T3PW/goq6p/wT5/aOutTUajdWP8AwkHiSyub8C8ns/EVlrAvrPXrWa48yS31q0vYo7y21SJkvoLqNLiKdJUVx7U6dP8A1fcfZw5fqKny8sbc/Ipc1rW5ub3ubfm1vc+GlicR/r7Kr9Yr+1/t2VL2vtantPZ/WHS9nz83Nyey/d8l+X2fuW5dD531fRNGbVtUZtJ0wk6jekk2FqSSbmUkkmLJJPJJ618FHFYpRilia6Sikkq1RJJLRJc2iR/Qkssy2cpTnl+BlOUnKUpYShKUpSd5SlJ023Jtttt3b1Z//9k=" }
_This adapter splits power and ether so you can power your low power devices_

![4 zones!](/assets/img/posts/power-over-ethernet-is-awesome-2.webp){: w="338" h="600" lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIABIACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyJ+OfwE/bH8A/FBLD45ftA2XhqSLxh8P8AxB4D+H3j3463mpeBNc8M+NNe1K88J6HpPw9tbdPCOk2dtbmDStR8NzalfXvh4X8uranpmj6JputappPzGMrYXEUqyxGOw8MBWoYpReEwlVV4PD0051KmNw2IqVE4StVp1KGHoO6hT5+eVPn9ihwfxLmssTh6ODrSjGWCpSw0qf1PE82YylTwfLPFYmi6rlVjKUY0IQqQhGpWdqNGtVp/0X6B+yN+2xJoWivp37cXwct9PfSdOext9I+EWgajpUFm1nCbaHTNQfxFC9/p8UJRLK8aGJrq2WKdo0LlRNHjXJ4UaUHicBNwpwi5Ty3DucuWKXNJzwUpuTteTk3K7fM27s+j/wCIYcbQ9yWR4vmh7sv9qorWOj0WNstVstF0PDbb9hH9lS5+H/7THhO81v4P+OrjwN4o0vVvHumWPxp8T694w8RfCzxD8NfC/i+wGl2l3YPp9z8U7e6fU7vw149trm+8ReI/Evgaz0qW7i0nUX0ay8DF5PWo5XQnQdWOZYeDrXVOEaVScb+2wyhF6UGovkhyWvaUlec2/wBCwXidicZxTiZ4qFNZDmMoYJYaTcqtCkuWlhMdUrSbqzxStF1ZyqTtTbim/ZU2fLmnf8EzfDkWn2MXhz/goX8aNP8AD0dnax6DYTWoWax0ZIEXS7OVY/ENrGsltYiCFwltboGQhYIVxGv5/POLzm5ZRhXJyk5Pmnq7u7/gvd67v1Z+2U6tFQglj8xSUIpKNSjZKyta9O9u19bbnSf8EyLO0n/a0/b1t5rW3mt/+ET/AGVz5EsEUkP7rQPGcUX7p1KfuowI4/l+RAEXC8V+yV5zeAwsnKXM5Vby5nd+91d7n8bQS9tVVlZcjSsrJ2WqXR+Z4NrXijxNZazq1lZeItdtLO01O/tbS0tdX1C3trW2t7qWKC3t4IrhIoYIYkSOKKNFjjjVURVVQB+TYilT+sV/3cP41X7Ef55eR/QmDrVnhMK3VqtvDUG26km23Sjdt33P/9k=" }
_It also has Gigabit ethernet!_

## Where to Buy

Products in this video (see power disclaimer above):

- POE Splitter Gb 2.5mm (featured in video): <https://amzn.to/3rNhvKw>
- POE Splitter Gb 2.1mm: (other plug size):  <https://amzn.to/3KG5g9p>
- POE Splitter Gb USB C: <https://amzn.to/3KfvE9G>
- POE Splitter Gb Micro USB:  <https://amzn.to/3KjMWlU>
- 2.1mm to 2.5mm adapters: <https://amzn.to/3OAt6po>

See the kit here:
<https://kit.co/TechnoTim/power-over-ethernet-poe-devices>

(Affiliate links are included in this description. I may receive a small commission at no cost to you.)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Power Over Ethernet is AWESOME! (POE) <a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://t.co/HCFhuDyc1z">pic.twitter.com/HCFhuDyc1z</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1684967675921932304?ref_src=twsrc%5Etfw">July 28, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
