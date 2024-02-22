---
layout: post
title: "Introducing the ZimaBlade! - An affordable Low Power Single Board Computer!"
date: 2023-10-30 08:00:00 -0500
categories: homelab
tags: zimablade hardware casaos linux windows
image:
 path: /assets/img/headers/zimablade-review-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5itGl+FmkeCtSj1r9mf4C+M9Q0m/s9GuvEPiC9/aSs9e1W+sNVj8zXZX8KftIeG9G0+61WB5rLVtP0nRLLSJbS4mNnY2F7HYXtj8pgq9Kth8LiHh7Tr4OlWkvb1uT97GFa0oKUYTlGSSjNxUkrqKipST/TsyxeaUMZisKsxlKnluYYrCYdvCYN1YxpSq4V8ladGdaMJ01d0nUnHmUXJzlCMl+emrPbyapqUlpp9lplo+oXj22m2ZvZbTT7driQw2NrLqV7qGoyW1pGVggkv7+9vXijVrq7uZzJM/qKjBpP3ldJ2TWl9baq55E83xalJP2crSa5nGSbs2rvlnGN3u+WKXZJaH//2Q==
---

Introducing the ZimaBlade, an affordable, low power, single board computer that's great for a home server, homelabs, tinkering, NAS, retro gaming, or even a dual boot desktop system like me.

{% include embed/youtube.html id='NAN1pzj77b4' %}
📺 [Watch Video](https://www.youtube.com/watch?v=NAN1pzj77b4)

Disclosures:

- I was not paid
- Ice Whale provided ZimaBlades and accessories for testing
- I bought everything else with my own money

## Intro

![ZimaBlade among others](/assets/img/posts/zimablade-review-1.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APwL+Dvw98CXn7Mnh7UNU8Sa5ZeIPE/gTxz4h0/QB4GtPFFnI2iLpV3JBd/ES4+JPhjVtEF6dYtnQaP4DuYrN4XiMV3BGqz/AHmQeLfGPD+X5hhsBlOUV+F8HGeFxGGnxTxzgMzq0Kaq05zoPBZp9RwuKjGE405UKdLCSclOeCUW6C/Oq3htgsw4hWIzTjPiiWfY2eGrxw2By7KaPCVH6x7OeFhVyitWr4nHcsHQ+t1MRi+evUhJx5Yykp/hLqWpI2o35Q6hGhvbopGb8yFFM8hVC/lJvKjC79ibsZ2LnA+NrVcLUq1alCliaNCpUnOjSqYiNadKlKTlTpzq+wp+1nCDUZVOSHO05ckb2X30KeIhGMKs6FSrCKjVqQoypxqVIpKc403Um4RlJOSg5y5U0uaVrv8A/9k=" }
_ZimaBlade stands out_

Every so often a device comes into focus that’s a little different than the rest.   It looks familiar yet different. It stands out among the others in the sea of familiar devices and once you use it and hold it in your hands you understand why it’s different and why that matters.  This is the ZimaBlade, a single board computer from Ice Whale.  It’s the second device we’ve seen from them and it’s much different from their first device, the ZimaBoard.  There are a few features that make you think that this might be a successor to the ZimBoard, but there are many others which show that the ZimaBlade can stand on its own as a new product in their lineup.  Today I am taking a look at the ZimaBlade and discussing some of my thoughts around this device, how it compares to the ZimaBoard, and some of the interesting quirks I found that you might be interested in.

## Unbox Experience

![ZimaBlade looks like an 80s walkman](/assets/img/posts/zimablade-review-4.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP2V/a40bVfj3/wU60T9jn4Z6w/g340+B/h34u/au+F/xf8Aivp3hb44eCfCvxDi8GaJ4e8HS6F4K8Z+E7vVvA8XhHXl0DXbez8N69caJqAsNXW+0aS81yW6t/BpYbncXJqUalSFGrTle1Siv3rg5LdTpxnTkpQkk2pXbWnqwrxpwfuWfJKpTlB2dOomoqyd7KMnGScJQbtLRObZ6hp37Mv/AAXGtNPsbXVv2gf+Cces6pbWdrb6lq8/wP1yGfVdQhgSO81KaK0+GdraRS31wsl1JHa21tbo8pWGCGMLGvW+G+FpNylk2F5pO8v9jwctXq/elT5pa9Xq93qX/b2cLRZpmSS0VsbiIqy2tFVGkrdE7LZH/9k=" }
_ZimaBlade looks like a Walkman from the 80s, and that's a good thing_

Upon opening you can’t help but notice the cyber punk theme on the packaging and the device.  I am a fan of this design and it fits right in with the renegade, self-hosting, cyber native vibe they are going for.  Next, they chose to make the case transparent, which again plays well with the theme they have going and gives this device some character.  And last, how much it looks like a Walkman from the 80s.  Now that’s not a bad thing, Walkmans had a ton of style, came in all shapes and sizes, and was an icon in 80s culture.  But I digress.

## Hardware Specs

![ZimaBlade hardware](/assets/img/posts/zimablade-review-2.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APwL+Dvw98CXn7Mnh7UNU8Sa5ZeIPE/gTxz4h0/QB4GtPFFnI2iLpV3JBd/ES4+JPhjVtEF6dYtnQaP4DuYrN4XiMV3BGqz/AHmQeLfGPD+X5hhsBlOUV+F8HGeFxGGnxTxzgMzq0Kaq05zoPBZp9RwuKjGE405UKdLCSclOeCUW6C/Oq3htgsw4hWIzTjPiiWfY2eGrxw2By7KaPCVH6x7OeFhVyitWr4nHcsHQ+t1MRi+evUhJx5Yykp/hLqWpI2o35Q6hGhvbopGb8yFFM8hVC/lJvKjC79ibsZ2LnA+NrVcLUq1alCliaNCpUnOjSqYiNadKlKTlTpzq+wp+1nCDUZVOSHO05ckb2X30KeIhGMKs6FSrCKjVqQoypxqVIpKc403Um4RlJOSg5y5U0uaVrv8A/9k=" }
_ZiaBlade without its case_

The ZimaBlade comes with either an Intel Celeron J3455 Quad core Apollo Lake processor or an Intel Celeron Dual core processor depending on which model you choose.  
This CPU supports AES NI for encryption, VT-x for virtualization, and VT-d for directed I/O or hardware passthrough.

This processor is paired with the Intel integrated HD 500 graphics processor which is clocked at around 700 Mhz.  This chip also supports QuickSync and a handful of other features that help ensure that video playback is smooth as well as enough processing power to do some lightweight retro gaming.  You output the video with this mini display port that supports up to 4k at 60Hz.

It has a SODIMM slot that supports up to 16 GB of DDR3 RAM which is removable and not soldered on.  As far as storage goes it has 32GB eMMC for storage and dual SATA 3.0 ports for connecting additional drives if you choose to do so.

It has a 1 Gb ethernet port and as far as USB goes it has one USB A 3.0 port and one USB C port that supports power, data, and display.

The back of this case is also aluminum alloy that is fused to the heatsink which will help dissipate heat without a fan,

Last but not least is this bump you see here and that’s the PCIe 2.0 x4 slot.  This slot is what made the ZimaBoard unique,  was not only creating an x86 single board computer but also including a PCI slot to connect devices that you can’t use on other mini PCs, laptops, or similar devices without using a Thunderbolt enclosure.  And as you can see the ZimaBlade also gets this slot.

This slot can be used for almost any PCIe device you can think of that can fit into a 4x slot and doesn’t require external power.  This includes things like 10g network adapters, 2.5g network adapters, additional USB ports, WiFi 6 adapters, additional SATA ports, NVMe adapters, cards and for AI and ML.

## First Boot experience

![ZimaBlade in side of its case](/assets/img/posts/zimablade-review-6.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP2K1H9iz9pzx3+2Z8Cv2gvC/wAXPCWg/CD4ceK/DOuat4JvPFHxCGsXXh+xvbuPxH4f0rw1pukw+Dpo9e0C5ETHVr6RE1gLeOWjgRZPjMLyOlUpzTbnKXvJR0TglHe7vFrm0aT7K9z66rCaSqxa9nGCh7PmkrJq0kkvdakm731vqfuub6zUlRZcKdo+dRwOB/BW31Gn/PP/AMl/yOJNWWi28/8AM//Z" }
_ZimaBlade with its case, showing off some of its ports_

After installing the RAM and plugging in the device you will boot into Debian Linux which comes preinstalled. You can sign in using the username and password of casaos.  You’ll want to change this as soon as possible and update your system.

You might want to grab the IP too because you’ll need it to get into the CasaOS web UI that also comes preinstalled.  [CasaOS](https://casaos.io/) is an open source management interface to help you install over 50 docker apps with a single click along with supporting any other docker image you can find.  It makes setting up a NAS with Docker apps a snap and great for a beginner although if you’re already familiar with other open source NAS solutions you might be missing some features when evaluating CasaOS.  

If you’re interested in a deeper dive into what CasaOS is, I’ve done a video on 20 different projects you can run on your ZimaBoard and now ZimaBlade, including CasaOS.

One thing that was mentioned in the instructions, yes I read them, if you go out to <findzima.com> you can easily find your Zima device by clicking this button.  Now this didn’t work for me even though my devices were on the same network but that might be because this feature isn’t ready yet.

You’ll also see that they have released Windows and Mac clients too.   After downloading and installing these clients you’ll notice that it also installs ZeroTier.  Again, there isn’t documentation on this stuff yet because it’s pretty new but it looks like they might allow you to connect to your Zima device easily over the internet no matter where you are and if you have an edge connection or not.  This might be for the upcoming ZimaOS that I peeped on their Github.  Oh and if you’re worried about the code or client that’s running, all of this is open source and on GitHub so you’re free to check it out if you don’t trust it.

## My Workbench Testing System

![A mini pc doesn't usually have support for PCIe](/assets/img/posts/zimablade-review-7.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APqf/goH+z38a/H/AO0VF+078IP2nvGvw/8AsOm2mnj4MeIbS61n4YaheW1pbabLZ3NlpGt6RbjwlrVnbPJ4i8K6roviPSdb1K4uJ9atdV0e6u/D03yM8xpqhVg8Fh6knzShWqU4OpF2k93GevO01JSUoLSDi9T6zKsF7etCisTXpRvCMuSUmnGUvefIqkIuVls/del9j5FPxz/al0YnRxpf7I5GlE6aDa/s6eBLK1IsT9lH2azt/C8cFpb/ALr9zbQIkMEe2KNFRFA/HK3EHEKq1V9doq1SassNhWl7z0TeFTaWybSbP7KwXh34WVMFhKksizarKeFw85VZ5njKcqspUoSdSVOGYShCU2+ZwjKUYtuMZNJM/wD/2Q==" }
_PCIe connectivity is often not found on mini PCs_

The nice thing about this hardware being open is that you are not locked into how the vendor wants to use it.  If you don’t like Debian or CasaOS, fine, just wipe it and install whatever you like.  Want to build your own NAS using OpenMediaVault or TrueNAS, go for it.  Just get a bootable flash drive, install it, connect a couple of drives and you’re good to go.  If you do go this route I would recommend picking up the NAS kit that includes this dual 3.5” storage drive stand and a special Y SATA cable that helps you connect and power 2 additional drives.  And just like that you have a NAS…. or do what I did and create a dual boot Windows and Linux system!

I use both Windows and Linux a ton on my workbench and I always find myself toggling back and forth when testing hardware.  Plugging in   When I saw the ZimaBlade had a case for 2 additional drives I knew right away that this is how I was going to use it.  I grabbed a few old SSDs out of my drawer, picked up a couple of cheap 3.5 to 2.5” drive adapters, installed the drives, and then connected them all with this Y SATA splitter and it was ready to go.

Installing a dual boot system on this was relatively easy however I’ve had some experience with this in past and I even did a video on it, but if you’re interested on how to do this I will have a link to my documentation that will explain exactly how to do dual boot with a ZimaBlade.

Now when booting I can choose Windows or Linux when booting up.  You can see that this little quad core processor is working its tail off during the boot process but it tapers off after a few seconds.  The integrated intel video card works decent enough for watching videos and I assume it works fine too for retro games but this is just enough for what I need to test out hardware and flash and wipe drives.

![Windows boot, showing GPU and CPU metrics](/assets/img/posts/zimablade-review-8.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5/vjn4J+HVoLH4S/8ACv8AwTaHRfAHgfX7vxfoPhuTRvF/iS9m0DwfKg8S6/8A25ez6hE1nrLNcxWVtpME2oWyXBg3TPKvp5ZRVLLZ47F0KWIw0MPj1ShGq6eIdSr7KalVkqNnChGny0Yc75XKTunKTffXxtCtUw+XewjCpRrQlWrezjKVf2vKkp1HPntGUU1ZRS+ykcTY/sDS6pZWep2WvaPBZ6ja29/aQSXGoLJDa3kSXFvFIo0q4CvHFIiMouJwGBHnS/fb5qWIpqTX73Rtbp9e7ld+r1Y5YiipSShJJSaSUY6JPRfF2P8A/9k=" }
_This device can boot into Windows 11 and play videos, no problem!_

On the Windows side it’s using anywhere from 6-10 watts of power after signing in and letting the machine sit for about 5 minutes to ensure that most sign in tasks were complete.  This variance we see here is due to a lot of the background tasks that run on Windows and a little bit for the task manager.

When launching the default browser of Edge and playing a video on YouTube we can see the power usage jump from 10–18 watts.  The other thing when looking at the task manager is that the integrated graphics have kicked in to decode the video.  If we look at the stats for nerds there were only a few dropped frames and most of them were when starting the video and resizing the window to full screen.

![Linux boot, showing GPU and CPU metrics](/assets/img/posts/zimablade-review-9.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5+tU8O/AX4d/D3T73QPhpFc/ETxjbeEvGdt4w13TfDOs2+htp1rr6nTbLRr/TZ7M2Gq6TqE0GvWEqy2Oq61Z6VrxgtpNL02zsu91eHq+S4HArKs3wud4erX+t5pSz6jXy/H4SVHFKjCGVyyWhisBiaOIWHk6sc4xVOrRhUhKiqk1Vj9t4d5Dic38R6eHzzGZdmPDOY4bFSw2VU8nrYLMsDiMFk+JxdaVbNVnGJw2Y0q+IoudOEcpy54ePJByrcspS8Dm1TUPOl+W1H7x+IlMEY+Y8RwQosMKD+CKJVjjXCIoUAV4KwckknWm3ZXbnUbb6tvn1b6s9rHrhynj8bTpZXONKGLxMKUeWiuWnGtNQjZSa0iktGf//Z" }
_It's no surprise that this also works with Linux! (Ubuntu 23.10 shown in picture)_

The same goes for Linux, when booting this Ubuntu 23.10 machine the machine I can choose Linux from the GRUB menu and boot into Ubuntu Desktop and as you can see the CPU and resources taper off after a few seconds and everything runs smoothly.   Power usage after letting the machine sit for about 5 minutes is anywhere between 5 - 7 watts, again the variance is due to background tasks and  System Monitor.  Playing a YouTube video with the default browser of Firefox we can see the power usage jump from 11 - 17 watts.  System monitor doesn’t report GPU status so I installed intel gpu utilities and was able to see the intel video card decoding the video.

One of the things I use this for most often is flashing SSDs and wiping and formatting drives.  These two things are pretty cumbersome to do without physically plugging them into a system via SATA, PCIe, or Thunderbolt.  Each of these solutions take up a lot of space or require additional hardware requirements.  I found that having an “open air” PCIe slot on this machine makes it super simple to test complete any of these tasks, and with a small footprint.  And this is just one of many possibilities with the ZimaBlade because at the end of the day, it’s really just a mini desktop.

## My Thoughts About the ZimaBlade

![ZimaBlade in white](/assets/img/posts/zimablade-review-11.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AMzxdeftb63+0vfNbfFBb3QvCvxm0e/0x9Q+KPxA0aaw8Gy6zaSX3hrSvDvh/wANppNnJc2un32nFrjUb/TJbK9aC7024R3UedRUPYScoQleMuZuF5+6201PmVv/AAH5rU76lJfWIuMpxakuVJpRu2k7xtfW+99bapn9C0mveVI8ZiZjG7IWwoyUJUnGeM4ziuA63Rg226dJtu93HfzP/9k=" }
_The engineering sample came with a white PCB, let's hope it sticks around_

I do have some thoughts after using this for a couple of days.  Overall it’s great and hard to complain about something when there’s so much to like.

I think my biggest gripe has been power.  I went into this thinking that I can use any USB C power adapter since it supports Power Delivery 3.0.  Turns out that this is a 12v Power Delivery 3.0 power supply and I couldn’t find any power adapters here at home that supported it, not my Macbook charger, an Anker charger, or even this no-name charger.  This really isn’t a big deal however if I used one of my existing adapters, it seemed to also do something weird to the device to where I had to reset the CMOS a few times.  I reached out to IceWhale and they pointed out that I needed to use a Power Delivery 3.0 12v/3a power adapter like the one that is included.  I 100% agree that the provided adapter works but USB C Power Delivery 3.0 with 12v/3a is less common in North America with a lot of power adapters, at least the ones I have access to.  IceWhale did say that they were going to try to make it compatible with more adapters before production so we’ll see.  Moral of the story is just use the adapter they ship and you’ll be fine, which means you might want to buy their power adapter to be sure.  When using the correct power adapter with a USB C hub, everything worked fine including USB, HDMI, and power delivery.

Another small gripe is that you can’t see the power LED when you have it in the case.  The only reason I am bringing this up is because I had to check the LED over and over when figuring out the previous issue related to power.  Not a big deal but one little hole or clear cutout in the case would go a long way.

While we’re on the topic of LEDs it would be nice to have a pair of lights for the NIC for status and activity and also I noticed that the HD activity light doesn’t flash for eMMC.  Again, not deal breakers, just nice to haves.

Also a small power button would have been awesome.  I still feel odd pulling out the power to reset or power down this machine.  I did check for pins and I could only make out the reset switch.  It would be great to add these pins to the documentation, I am sure others will ask about this if they haven’t already, and everything else is documented nicely in the booklet that shipped with the device.

Oh, and they sent me 2 devices, one was an engineering sample with a white PCB and one that is closer to the final product which has a black PCB.  Honestly I love the white PCB model even though I am a huge fan of dark mode!  This white PCB just makes it feel more SciFi and futuristic and really makes all of the componentry pop.  I dunno, what do you think?  Light Mode PCB or Dark Mode?

![ZimaBlade with device dangling](/assets/img/posts/zimablade-review-12.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APnJdN/b0+PH/BSLXfhD8Z/2m31j4TWGnR+NG0PwT4o8e/DeHUfCtumkWTwXeh+C00NH1+7n1eyjiS/8RaxDo+lwtp9nrFxbWVnBJ83icTSlg41adKMa0mo3nFVVGbje6c5OTVk725bvZJHvYLBKeIlG0Y07XSjKXMop6xXMpdXpdu3Vtn7yab+ztb6Vp9hpdhLo8djptla2Fmlxc+Nb+4S1s4Et7dJ7+/8AFdzfXsywxoJbu9uLi7uXDTXM0szvI3guVdtt1Kerv/Ba/BVbHpPCU4tx9/3Xb+Iumn/Po//Z" }
_Hopefully some printed caddies or the like make their way into the ecosystem_

Also, it would be cool if there were some sort of printable adapter to prop up your PCIe devices when they are plugged in.  When you aren’t using the 2 drive base stand it’s easy to prop something under it, but when it’s dangling about 6 inches up it’s kind of scary.  A printable tray or stand that could hook into the existing stand would go a long way.  You could even sprinkle in some of the Cyber Punk designs from the device.

OK it sounds like I am nitpicking now but these are just small things that I think would really put some polish on this device. 

It’s hard to complain when there’s so much to like about this $64 board.  I know that it has an older CPU in it, along with DDR3, and the PCI is only 2.0, but considering the cost and what I will use it for I would rather keep the cost down than pay for features I personally won’t use.

And I think that’s the goal of this device as stated by IceWhale:

> “The ZimaBoard was built on top of a relatively expensive ($120-$200) x86 single-board computer compared with the popular Raspberry Pi. Since most people can’t afford such expensive hardware without knowing what exactly it can do, we decided to create something better suited for the broader cyber native – something that is cheaper, smaller, and easier to use and carry around.”

If this is something you want to support, check out the links for more information:

- ZimaBlade on CrowdSupply: <https://bit.ly/3PeSpxv>
- ZimaBlade Official Site: <https://bit.ly/3tOlpUx>

Well I learned a lot about the new ZimaBlade, Power Delivery over USB C, Dual Booting Windows and Linux and I hope you learned something too.  And remember if you found anything in this post helpful, don’t forget to share!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">The past week I got to play with and configure the ZimaBlade, a new single board computer. Super fun device with some quirks. Did it replace my ZimaBoard? <br><br>👉<a href="https://t.co/GfuWbkqXMJ">https://t.co/GfuWbkqXMJ</a><br><br>(Also I couldn&#39;t pass up doing a Halloween themed thumbnail!) <a href="https://t.co/HzW7mxE35n">pic.twitter.com/HzW7mxE35n</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1719361580092035521?ref_src=twsrc%5Etfw">October 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Where to Buy

ZimaBlade:

- <https://bit.ly/3PeSpxv>

ZimaBlade Accessories:

- 10g NIC: <https://amzn.to/47aLJXl>
- Quad 2.5g NIC: <https://amzn.to/3sl2Bf1>
- 4 Port USB Card: <https://amzn.to/3FFIzPr>
- WiFi 6 PCIe: <https://amzn.to/3sfwLQY>
- PCIe SATA Expansion: <https://amzn.to/3sbNdlj>
- SAMSUNG SSDs: <https://amzn.to/3Sf5bxU>
- 8GB SODIMM RAM: <https://amzn.to/40iXUiw>
- Anker USB C Hub: <https://amzn.to/49tQCwL>
- Slim Cat6 Cables: <https://amzn.to/45NVj1e>
- 2.5 to 3.5 Bracket: <https://amzn.to/3s6q7fZ>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
