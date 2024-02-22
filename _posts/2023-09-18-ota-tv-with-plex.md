---
layout: post
title: "Turn Plex into a Powerful DVR"
date: 2023-09-18 08:00:00 -0500
categories: homelab
tags: plex tv ota epg dvr
image:
  path: /assets/img/headers/plex-ota-tv-hero.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5JPCvxC8D+Evh14O03XP2c/gb8Rb+60yO5u/E/i7/hcln4j1CXUr+5mtTfS+DPjF4U0cf2PHpqWdmNL0XSkvLSec6yuqXpW+XOmnGlWnKXO4OtWp3WsVGU06cnJy5k0rR+FQX2ZOzXp4dxrVKNGEY03iKuFy+pKVOjVX71UpKtBSpKUJxcne0+eW3tVFuL+cdU0Gzg1LUYELBIb67iQKFQBY7iRFARNqIMAYVFCqOFAAArb61Tn76ocqn7yjzQfLza2v7FXte17L0R506bpTnT5lL2c5Q5mnd8jcbv3nq7X3fqz//Z
---

Cut the cord and get free over the air TV with Plex!  Today we'll dive deep into selecting a TV tuner, an antenna, dialing in your TV signal, and configuring Plex to help you get the most out of Live TV and DVR!

A huge THANK YOU to Plex for sponsoring this video during [Plex Pro Week](https://www.plex.tv/pro-week/)!

Get started with Plex today! <https://www.plex.tv/>

{% include embed/youtube.html id='Q5okoyPewyU' %}
📺 [Watch Video](https://www.youtube.com/watch?v=Q5okoyPewyU)

## Turn Plex into a Powerful DVR

There’s this great free resource out there that many people aren’t taking advantage of. It’s something that most homes can access absolutely free and that’s over the air TV. Now I know what you’re thinking, what year is this?? I know,  it sounds odd talking about over the air TV in this day and age but I found a way to modernize it and make it more accessible with a little bit of hardware and a little bit of software from Plex.

I have been using Plex for almost 10 years and one of the features that isn't talked about that much and is one of my favorites is Live TV & DVR. I’m not talking about the free TV channels that Plex offers, although I will be talking about that a little bit later, I am talking about over the air channels like ABC, NBC, PBS, and many others to watch Sports, Local News, and more. And with ATSC 3.0  or NextGen TV rolling out in some areas, you can be sure that you’re getting the clearest broadcast possible with up to 4k resolution and uncompressed when over the air vs. 1080p and compressed from most providers. You’ll need a few simple things that I will cover in this video so you can start watching and recording Live TV today. So, full disclosure Plex is the sponsor of the original video and I want to thank them for asking me to share my deep dive on Live TV & DVR with Plex.

![Plex as DVR](/assets/img/posts/plex-ota-tv-show.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5u9N1n4B+D/F+kQyR/GyK5vrHQZVtZZ/hd4r0r+wrnwrps2s2rLqnhXRryPUpvF0MN7aXkEyovh+eXSpU+1QPf3/59l3C+IzJ4PA8XzwChQzWvLFY3hylVp4hYJ4DHRwtXB4bMnVw31+GInhY1YYuWIwzw88RKk4YmlQqy/qHOM+4WwWSZjjeEqHEdfimfCNRZZSz/ABGCweRf65f64ZdT5cficreJzZcMVOB3mU5SwqWaUuLKeCjyV8lr4iNCKD45eMXgheK28NXUTxRtFdXPhHwbaXNzGyApPcWsXhu7itp5lIklt4ru6jhkZo0uJlUSN87j/BjgyGOxkcNhscsPHF4iOHVXPOII1FRVaapKpGhmtOhGapqPPGjThSUrqnCMLJdGD4unLCYWWKWJeJlh6EsQ6Kwbouu6UXWdJ1sNOs6bqc3I6s51OW3tJSldv//Z" }
_Plex can be a powerful DVR to record or watch your favorite TV shows_

## Plex TV & DVR

With a TV Tuner, an antenna, and a Plex Pass you can turn your media server into a powerful DVR to record your favorite shows or watch them live, even on the go. You can record any show in your area, whether that be sports, local news, or your favorite TV series and watch it from any device. Plex has apps for mobile devices, SmartTVs, gaming consoles, Apple TV, on the web and more. It’s hard to find a device that doesn’t have Plex.

Watching Live TV is as simple as launching the app and picking a channel. This will stream the channel from your Plex Media Server to your device. After the Live TV stream starts, you can pause or even rewind Live TV. But if you start watching something that’s currently being recorded, you have the option to watch from the beginning or watch live. If you choose to watch from the start you can skip through commercials and get caught up to the live broadcast. This is a little life hack I use to watch something that’s live without the commercials. For something you’ve already recorded, there’s also this awesome feature that will allow you to skip commercials or remove them altogether. This is a great time saver and we’ll get this set up today too a little bit later.

One of the best parts of Plex Live TV is you get the best EPG out there. EPG stands for electronic programming guide and it lists all shows for all channels along with some additional data like episode information and more. It’s how I know that Jeopardy! is on NBC at 4:30 local time, or that the episode of Nature is a rerun. It’s also what helps populate their powerful search in the Live TV section. I can’t stress enough how important it is to have a solid EPG when using a DVR, without accurate data you could schedule the wrong show to record or miss your show altogether. The EPG is even interactive on some clients, giving you a picture-in-picture guide while you browse the guide looking for the next thing to watch. And if you only watch a handful of local channels you can add channels to your favorites so you can quickly access them. Plex Live TV lets you prioritize your recordings so that I don’t get in trouble recording a rerun of Nature instead of the latest episode of The Bachelor. We’ll talk more about the EPG, recording priority, how not to miss your favorite shows when scheduling recordings a little bit later.

![Plex EPG](/assets/img/posts/plex-ota-tv-ota.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APq34o/tk/8ABQn9nHWNJ0XVdP8A2VvEt3rumTXmnzaPD450eGS7N8dLjm1Y3vh3UsPZveCSFrK28udJrkzQLKkDh4zxHcpU1jMHUlpCmoUq1aSiqjbVqksTCajegm4paKyTtofMU+F6+Vfu6FTBRdaSleOHp2bjKpG81LDtc372buo9W922vlO9/wCCn3/BTxby7WPxp+ztaxi6nEdrD8PJJYrZBK4WCKWTS1kkjhXEaSOqu6qGZQxIpf674T/oXTfm6uJbfm3/AGhq318y/wCz8y6Y+lFdFHC4dJeSXsdEtkux/9k=" }
_Plex's EPG is the best Electronic Programming Guide out there!_

## Setting Up Live TV & DVR

So, what do we need in order  to have our very own DVR? I know all of this sounds complicated but it’s much easier than you think. You’ll need a couple of things, all of which I use in my own home and have been recording TV for years, so you can be sure that this setup will also work for you.

## TV Tuners

First, you’re going to need a Plex server and a Plex pass. Next you’ll need a TV Tuner and an antenna. I’ve used a lot of TV Tuners in the past but the best tuner by far is one from SiliconDust, it’s the [HDHomeRun Flex 4k](https://amzn.to/3r1v3SL). This nice little device sits on your network and converts a TV signal into a video stream so that your Plex Media Server can consume it and even change the channels when requested. This one in particular has 4 tuners inside that allows you to watch or record up to 4 channels at once. This one also supports the new ATSC 3.0 NextGen TV that we talked about earlier - so it’s future proof!

![HD Homerun TV Tuner](/assets/img/posts/plex-ota-tv-hd-homerun-4k-flex.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APvnwj4B+M/xf+POq+K/E3jvTtB074l/C+8sNC+F3hedU8FaNZTaZYWFjrd3qMvhK1muPEmnadphggXUPD3iDSygtbV4ms45o5/zrLc1xGGxFHK8W1icTiIVsVVxdNOlChyqbhSoUnKo5wfLJNuVKUdG3VlKUl+u53kGVZlkuOz/ACajUyrBZM8DgaeCryjjMRmU69aFPE43GYtRo+xrKWIoyp0oQxNJpVI0/qtOFOnL+efWfHf7QtvrGq2938bvEDXUGpX0NybW2tY7Y3EV1Kkxto/LTZAZFYwpsTbHtXauMD9Ei+ZKS2aTV/NXPyNqza7Nr7j/AP/Z" }
_Silicon Dust's HDHomerun TV Tuner will get you up and running in no time!_

## Antennas

Another important thing you’ll want to have is an antenna that connects to our tuner. Antennas come in all shapes and sizes and depending on where you live, you might be able to get by with a small indoor antenna. If you’re in the US, there’s a great site to help you determine your distance from TV towers which might help you choose the right antenna. You can visit the site, enter your location, and see how far away you are from TV towers, their location, and get an estimate of the signal strength to your location. Based on this legend you can make a better decision about the antenna you choose.

![Selecting an antenna](/assets/img/posts/plex-ota-tv-flat-antenna.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOn1z9kX9rH4ufHXxr+0i3xb0bw14i+KnijWtf8Ah/4T074vfFZ/CXhrw9oUNlZeHND1XTYPB+n6faTWfhWx06C7uNK0q8hudTtWzD5U7XSeFhs2wsaFNOlVUlG0+WFPl51Lkny/vE3Fzbs2k3HVpN2Pps5yaeBzHGYZV/aKlUpypTbcXKhWpQr0OeKi1Gr7GcFVjFyhGopRhOcUpy+0rf8A4KpftSeGreDw5rvgH4R6vregQxaJrGrR+JvHOzVNV0pFsdQ1FM2Nudl7dwTXK5ggOJRmGM/IvxeJ4mrUsRXp08PS9nTrVYU+ZT5uSE5RjzWqW5uVK9tL7aH6zlvhvwjisuwGJxWOz+OJxGCwtfERoU8u9hGvWoU6lVUed8/slUlJU+f3+S3Nrc//2Q==" }
_Selecting an antenna is key to getting the right reception!_

Here are my recommendation for choosing an antenna:

* If you’re close to the TV towers and want something low profile, or you live in an apartment or condo and can’t put an antenna outside, go with a flat antenna which is thin, low profile, and can be placed in a window or on the wall. This [flat antenna from Channel Master](https://amzn.to/3Z5AQmR) (affiliate link) should work great if most TV towers are in the green or yellow. It’s slim, low profile, and can be attached to a window or wall.
* If you’re further away from the TV tower or you just want the best reception,  I recommend picking up something like this [Antennas Direct antenna](https://amzn.to/3sHLST3) (affiliate link) that can be used indoors or outdoors. It’s not the best looking antenna but it has a great range and will work better than the flat antenna if you can hide it or aren’t concerned about aesthetics.
* Either way, you’ll want  to mount it somewhere in your home, the higher the better, outdoors or an attic will work best.
* I got lucky when I moved into my house because the previous owner installed a massive long range antenna in the attic and ran a coax cable to the basement. Having one in the attic above the trees and other houses is one of the best places for an antenna.

## Hooking Up Your Antenna & Tuner

Once you have your antenna and tuner, go ahead and connect your tuner to the network and connect your antenna to the coaxial terminal and then finally,  connect the power to the tuner.
A word of caution, you might be tempted to buy an amplifier but I would recommend against it until you truly know that you have a weak signal, you run the risk of introducing noise and interference. We’ll see this later on and from there you can determine if you need a [signal amplifier](https://amzn.to/3LgwB26) (affiliate link) or not.

Once your tuner is on the network, visit tuner’s web page by typing in the IP address in a browser. Here you will see the landing page for your device. If you see a message to update your firmware I would update it before continuing, it will only take a minute, plus, who doesn’t love updating firmware 😀

Once it’s updated you can see the tuner status and more information about your tuner. Next we want to see which channels our tuner can detect. We can do this by going into the channel lineup and clicking “Detect Channels”.

This will scan for all of the channels you can pick up using your antenna. Now your mileage may vary depending on your area and how close you are to the TV towers, but it’s a good idea to compare the results to what you expect. If you aren’t seeing the channels you expect, you might need to adjust your antenna or think about getting a signal amplifier, however I’ll show you how to check the signal strength in a little bit.

One thing you might have noticed is that little plug that I have connected to my HDHomeRun. This is a [signal filter](https://amzn.to/3Pax72J) (affiliate link) that will filter out LTE and 5G signals from the line. I’ve noticed that as more cell phone towers go up, the more they can interfere with my antenna, so I popped this little filter on to filter out those frequencies. If you’re wondering what interference looks like, it's that weird pixelated blocking that you see sometimes when watching TV. This isn’t going to magically make channels appear out of nowhere or boost the signal, it’s just there to take away the noise created by cell phone towers.

Once we’ve got our tuner all set up, make note of the IP address because we’ll need this for configuring Plex.

![LTE Filter](/assets/img/posts/plex-ota-tv-lte-filter.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APWf+Ci+r6N8cPHvwv8A2XbSTWdJ8N6jqlprcXnNPBH4W8SeG4tT0hPGekXFnrssOuarDp3jVrCHRNa0SHT7uIyyz6hbi0htrv4PLs6xtfMY0sJHD0aSxFel7WtCVTESdCNql9XTjB1FzRiryklrODm3H9gfBeS5bww88zd43G41U8PW9hhK9PD4LlxtJywtNxdD6xKauvb1lXhGG0KFZRftPI7H9q7/AIKE/Cqys/hfp/xg+FuqWHw3tbfwFY6nqXw70m41HUbPwfEnh62v7+d9CZ5r28h05Li6mclpJ5JHYksTXhYrGZtSxOIpyzCrzU69WD5VRlG8KkovllUoOcldaObc2tZNu5+lYHh3gjG4HB4xcPxti8Lh8SuZyjK1ejCquaNKuqcZe/rGmlBPSCUbI//Z" }
_You might need to pick up an LTE filter to filter out 5G noise!_

## Setting up Plex for Live TV

Now that we have our TV Tuner and antenna set up, we can now configure this in Plex!   You’ll need to sign in to your Plex Media Server and then go to settings. In the Manage section you should see Live TV & DVR. Here you’ll want to configure a new tuner. When you try to add a new tuner, it will try to search for your tuner and in most cases it will find your device. If it doesn’t you can manually add your device by typing in the IP address of our tuner. Once it’s added you’ll need to set a few settings for Plex. You should choose an antenna, your home country, and your Postal Code. The postal code is needed to download the EPG. Once you’ve set this, you will then see a list of all the channels we found earlier. You can scan again or even remove channels however I wouldn’t remove channels here, I would just create favorites later. If you’re happy with the list, click continue. Plex will start to download the latest guide and after a few minutes we should see all of the TV shows that are available!

## Recording Live TV

The channel guide can be found in the Live TV section. Here we can see a list of all of the shows we can watch or record. This will look different on different clients but the experience is mostly the same. The live TV feature is pretty self explanatory, we can scroll through channels and when we see something we want to watch, we just click on it. This will start a live stream. You can even pause or rewind a Live TV show, pretty cool.

So you can see that I have a pretty good signal and quality but what do you do if you don’t have the greatest picture quality?  Well, earlier I mentioned that we could check our signal strength for a broadcast to determine if we need to adjust our antenna or think about a signal booster. This might work differently depending on your tuner, but if you’re using a SiliconDust tuner like the one I am using, the easiest way I have found to do this is to start a live show and then go to your tuner’s homepage while the show is playing. Once here go into Tuner Status and choose the tuner that’s being used, which you can see in the Summary. Click on the tuner that is in use and here you can see the status. The most important stat here is Signal Quality. The higher the better. If you notice that this is noticeably low and your TV stream isn’t the greatest you can try adding a signal booster or a line filter to try and clean it up. I will have links to this and all of the other hardware we talked about today in the video description. So, back to recording from the channel guide… After selecting a show, if you want to record a show all you have to do is click the record button. From here you can choose whether you want to record new airings only, new and repeat, and which library you want to save it to. I have multiple libraries, TV Shows and Recorded TV. That’s because I wanted to separate the two but that’s totally up to you. It’s as simple as creating a new library and setting the type to TV Shows. You will then see this option when scheduling recordings.

![Plex EPG DVR](/assets/img/posts/plex-ota-tv-epg.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5QtC1KfxFqlnDeXt4J73QI7xrxYNNa4tp5reWymkg8+1uLcz/ZPOWC6e3+1QXMq3sEsF5FFOnlvD0E+aFP3dI2naTbsuZu0Yqzkm0tXFNRcpWcpd0sbiE2uZKX8ybbT7rmb1836pLRL31P2a7WRVceLvELh1DhpdTuDI24A7pCI8FznLkcbicVosFBpP2dLVJ7d/kZfXMT/wA/Z/8AgUv8z//Z" }
_Scheduling to shows to record couldn't be easier with their great EPG!_

You also have some additional settings in “Show Advanced” but we won’t change them here, we’ll apply these to all recorded TV a little bit later. After clicking record we can now see that we have a record icon on the show, letting us know that it’s currently being recorded. You also have lots of quick actions when hovering or clicking on shows where you can schedule recordings or even cancel recordings, it’s pretty handy.

One thing you might have noticed is the categories across the top. Most of these are self-explanatory, however there’s one named Plex Channels that is different from the rest of the TV channels. These are FAST channels or Free Ad-Supported Streaming Television. It’s streaming TV that can be watched at any time. They aren’t channels that you can find over the air from your local TV stations, but channels that stream content 24/7, like for instance if you wanted to binge watch Top Gear or the Price is Right classics, there’s a channel for that. But, back to recorded TV.

## Watching  Recorded TV

Once a show has recorded it will be in your Library you set for recorded TV, the default is TV Shows. Once here you’ll see a similar experience that we see for Movies, you'll have a “Recommended” section, a “Library” section, and a “Category” section, and view controls for your media. Clicking on your show will bring you to that show and from there you can see all of the recorded seasons for that show and if you want to get to your show you click into the season to get to your episodes. Once you are on your episode you can see more details about it like  the date it aired, how long the recording is, the rating, and even details about this episode. You can also switch the track to another language and choose your subtitles if the broadcast supports it. After clicking play the video will start and you can watch it as you normally would!

![Plex watch recorded TV](/assets/img/posts/plex-ota-tv-library.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP52TZWOj/CD4Wyaj4L8G6lJ8QfD3hq/03WZdD+H1xrNvepfa1ZStfXN98KLjVoLZ7zw9bPPAniLVH1C1lu1vbgy3spTzsNKtTw2bVqlWNWWAnjMxpXhVssJRlN1sLUjLE1FXqOHKsPO9ClTcf4Nrcv2+VYaniXltDD4bDqeeYnLuF5SxEMFONLGY36m6OPpueWV6mHUJ1JutUpSeKqRlyc7s5T8q8R/DjSrTxDrtrbxXMdvbazqlvBGuo6agjhhvZ44kCW3hS1tkCIqqFt7a3gUDEUEUYWNfW/tfLMR/tFLBYqnTr/vqdN1MHeEKvvwg+TBxheMZKL5Ixjp7qSsj5DEZdXwmIr4WdaEp4atVw85RdSSlKjOVOUlKVpNNxbTklJrVpM//9k=" }
_Watching recorded TV is just like watching other media, complete with all of the artwork and metadata you're use to seeing with other content!_

## AutoSkip Intro, Commercials, Credits

One of the best features that comes with Live TV & DVR is Intro Skip and Commercial Skip. If enabled Plex can detect intros, commercials, and even credits to help you watch more TV without interruptions. When playing a show where an intro is detected, you will see a skip intro button in the bottom right corner that you can click on and it will skip right to the show. This also works for commercials too!  When a commercial break starts you will see a button to skip Ads which will skip right to where the show picks back up!  Now it’s not perfect but I’d say it’s pretty close for the shows that I watch. It’s not enabled by default so let’s enable it!

We can do this in our library settings which you can find in the Manage section. If we edit our Recorded TV library and go to “Advanced“  we should see a few settings in here that help us skip unwanted content. Be sure that “Enable Intro detection” and “Enable Credits detection” is turned on and then for the “Ads detection” setting  you’ll want to choose “For recorded items” . This enables ad detection for new recordings. If you’ve already recorded TV with Plex or from another TV you can turn on “For all items” to force a scan of all items in this folder.

Great, once that’s turned on it should now add these markers so we can skip unwanted content. This detection does take a few minutes and only starts after a show is done recording. Also, you won’t see new recordings in your Library until it is done doing the detection. Now we can skip all of that unwanted content and watch TV like a pro. Like this show right here, if we start playing you can see it detects the intro that we can skip through if we like, and then once we get to a commercial break it will prompt us to skip it we like, and if it detects credits it will do the same.

![Plex intro and commercial skip](/assets/img/posts/plex-ota-tv-skip.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyMl/4Kk/DXVvEUXjO9/ZduYLi8jaeXwrD8e/jRqPw9a8v7O5gvJz4J1zxjqGiRwJYz2kmladb28GnaTqtvNdRW09rJZWOnfy7OhxxChPBR4lwk5wnKMcbPLMJTxfLGajCLnSwvJdVIz558nPUpyim4zjKU/wBvw+ByF1442rQxjoVuVrAKXNQg50+d++8TGbShJckXpGa+0mrW9V/aO0aPVNSjPwX8CxGO/vEMcd7r8kcZW4kUpHI17EzomNqu0cZZQCUQnaPpYYDi+MYxlxGpyUUpT9lQjzNJJy5fqDtzPW13a9rs8iSyBybWUJJttLnm7Ju9r+1V7bXsr9kf/9k=" }
_Skipping commercials, intros, and credits makes watching OTA a breeze.  No more wasting time!_

## DVR Settings

Now there are some additional settings you can choose for skipping commercials like removing them altogether. This is in the DVR settings where we can set our default settings for new recordings. In the “Detect Commercials” setting you can choose from “Disabled”, “Detect”,  “Mark for Skip”, or “Delete”. “I would recommend setting this to "Detect and Mark for skip” rather than setting it to “Detect and Delete” because deleting is a destructive action and while Plex commercial skip is really good at detecting commercials, it’s a lot safer to just add markers than accidentally delete part of your show. As for the rest of the settings in here, I have only adjusted a few. I set the resolution to Prefer HD. I don’t replace lower resolution items, I do allow partial airings, and I don’t adjust the minutes before and after a recording. Shows are pretty good at starting and ending on time, but if you find that you want to record a minute or two before and after, adjust the setting here. Live broadcasts that go over the scheduled time like sports might be a good good reason to add some padding at the end of the recording so you don’t miss overtime!  Also I enable a refresh of the guide data during the maintenance window and for me that’s 2am.

## Adjusting Recording Priority

So now that we have scheduled some recordings, how do we make sure that my reruns of Nature and NOVA don’t get scheduled instead of my wife’s show The Bachelor?  (You’ll only make that mistake once). We can do this easily by adjusting our recording priority. If we go back into the Live TV area and choose the DVR Schedule we can see everything that’s scheduled to record and on the far right we can see our Recording Priority. This is where we can drag and drop to reorder our shows with the highest priority being at the top. This helps when there are scheduling conflicts due to the tuners being in use when recording or watching live TV. I have 4 tuners so I rarely have a conflict but if I did this is how it will choose to prioritize one recording over the other. Let’s say for instance I wanted to get in trouble again and prioritize Nature over The Bachelor, Survivor, and even Big Brother, I would just drag Nature all above all of those shows like. This would ensure that if there was ever a conflict or not enough free tuners, Nature would record instead of all of these shows. OK, let’s move this back before I get in trouble again.

![Plex recording priority](/assets/img/posts/plex-ota-tv-priority.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP494Nc057e0+2adFczJZrJK5tLQGZpCwUSSMGdwrSJtLAlF8wDI2rVVU7U1Hlj7kW3a7bvd313tpd3t20JpNXqOfNL35pJSUUvdsre67JSs2re8rq8bpr0GfU9MSeZf7L09dssi7V0TRiq4cjCkW6AqMYGEQY6IvQQrWVr2tpezdul2klfvZJeSNJO8pOyV5N2V7K72V23ZdLtu27Z//9k=" }
_Be sure to adjust your recording priority so that you can be sure your tops shows record over others if you run out of tuners!_

## Channel Favorites

Now that we have everything set, there’s also this small feature to make your life a little easier when channel surfing and that’s Favorites. As you can see from my list of local channels, I have a lot of channels that I almost never watch but at the same time I don’t want to remove them from my channel lined up. This is where favorites come in. I like to add all of my favorite channels to my favorites list so that I can easily browse them when I am looking for something to watch. You can even add some of the Plex FAST channels to your favorites too!  I really like the BBC Earth channel, PBS Nature, and the Modern Marvels channel and I have added those to my favorites too. They have over 600 to choose from, so there’s no shortage of content there. Now, if I switch and go to my favorites, I can see a quick list of my favorite channels without skipping around through all of the channels I rarely watch.

## Mobile

Now just because I did all of this from a browser doesn’t mean you have to do it here too. Plex’s mobile app works great for watching live TV, previously recorded TV, and even scheduling recordings. There have been many times where my wife and I  are out and about and hear about a new show that’s airing soon and it’s now second nature to immediately schedule it to record. I just open up the app, go to Live TV, Search for the show, and schedule the recording. It’s super simple and convenient to do.

![Plex mobile app](/assets/img/posts/plex-ota-tv-mobile.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APkmLTPEnxz8L6v4x1r4k+O5ofizfeGPEmhR634l8Yai+j+MtT8PXPheXWdU0Ky8ZaX4Lvp4df8AC2reJm1G+8Pa3qF6PF2q6VJ9nt4xJcfiFbxY4U4d4LzJVuAcBmWKqU84jiM+x9XE4vN3Gk8RWl9XovHYfAUMTGMatGjjpQrVIRqRn7H2qnOp+6/6j5zGMczhxRmGGrynhYYbL8DLC4XKqOGg8LGVKqp5dicbXp1JxU54aGJoU5ytepyQVJ8BrXhFW1nVmOr31oW1O/JtdGm1jT9ItibqUm30qwvdf1i8sdNhP7uxs7vV9Vuba1WKGfUr6VHupf5//wCIze1/e0uEsJRpVf3lOk89ziXsqc/ehT5ozpxlyRajeNOEXa6hFe6u3+x8wh7ks6nOUfdlN5Xld5OOjk+bDyleTV/elJ66yb1P/9k=" }
_The mobile app is not only great for watching shows, but also scheduling a recording while you are on the go!_

## Conclusion

So that’s everything you need to get started today to record live TV like a pro. I’ve been using this setup with Plex for years and it’s everything I could want in a DVR system, from high quality over the air uncompressed video and audio, to an accurate EPG, to how easy it is to schedule recordings anywhere on any device, to commercial skipping and so much more. I want to thank Plex again for sponsoring this video and thank you for watching. Well, I learned a ton about live TV, antennas, network tuners, and Plex, and I hope you learned something too. And remember if you found anything in this post helpful, don’t forget to share!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">STOP Paying for TV and cut the Cord for good. I haven&#39;t paid for OTA TV in over a decade, and neither should you. I made a guide on how to build your own DVR with <a href="https://twitter.com/plex?ref_src=twsrc%5Etfw">@plex</a> for their Pro Week!<br><br>Check it out 👉<a href="https://t.co/3dZ7Ca9ru3">https://t.co/3dZ7Ca9ru3</a> <a href="https://t.co/bmAoSOEl8t">pic.twitter.com/bmAoSOEl8t</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1703778413557768197?ref_src=twsrc%5Etfw">September 18, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Where to Buy

📦 Products in this video

TV Tuner that supports 4K and up to 4 streams!

<https://amzn.to/3r1v3SL>

Flat Indoor Antenna

<https://amzn.to/3Z5AQmR>

Indoor Outdoor Antenna with 60+ mile range!

<https://amzn.to/3sHLST3>

Adjustable Gain TV Antenna Preamplifier with LTE Filter

<https://amzn.to/3LgwB26>

LTE / 5G Filter

<https://amzn.to/3Pax72J>

Antenna Splitter with Power Passthrough

<https://amzn.to/3sLTZy4>

Solid Copper Coax Cable (NOT copper clad)

<https://amzn.to/3r3fhqk>

LTE / 5G Filter Alternative

<https://amzn.to/3PtSV9V>

See the whole kit!

<https://kit.co/TechnoTim/build-you-own-dvr>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
