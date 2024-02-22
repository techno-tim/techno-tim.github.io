---
layout: post
title: "Using the Raspberry Pi PiKVM with Multiple Machines"
date: 2023-02-18 10:00:00 -0500
categories: homelab
tags: pikvm kvm raspberry-pi hardware arch homelab linux
image:
  path: /assets/img/headers/kvm-dark-desktop.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5xvBf7YHiS6+EWmfA7x54R0vxb4I8J23xUu/BsljrOr+H9c0PX/iJ4FudAn1We6uG8QaTqEOjalb2HiKygXRLHUZ7u3ezuNaNrFoo0Pg4ijmWY4Wlh8Pj6WDj9cyyvXlPC1MROusFmWExkKXNTxmElCFT2E6VZN1I1YVeSpCdFTo1e3I8Jl2Ax8cVPDVq8o08dGEYYiFKEFjMDiMJVcYVcNiYRnFVo1KU4Rg6c4OcbVpKrD5iu/iJq0t3dSjSvDcQluJpBFFpTLFGHkZhHGv2o7Y0ztQZOFAGaxo5JGlRpUlmOZyVOlThzSxXvS5IqN3aG7td+Z6dfN51K9ao8DlsXUq1JuMcJGycpuVleTdleyu9j/9k=

---

> If you're looking to configure the TESmart switch with PiKVM, I finally figured it out and you can [read all about it here.](/posts/pikvm-tesmart/)
{: .prompt-info }

## What is the PiKVM?

If you don’t know what a KVM switch is, it’s a device that allows you to connect multiple computers to one device which allows you to control them with a single keyboard, monitor, and mouse.They’re relatively cheap unless you’re looking for an IP based one that will let you connect over the network.IP KVMs are really expensive, that is until the [PiKVM](https://pikvm.org/) came along. The PiKVM is a Raspberry Pi-based KVM switch, which allows you to remotely control a computer using a keyboard, a web browser, and mouse from anywhere in the world.It runs a web server that lets you connect to any computer connected to it and remote control it as if you’re sitting right in front of it, without plugins or installing any agents on the device. It’s much more capable than remote controlling it using a remote desktop client, it can even let you remote control a machine before it boots to let you change things in the bios, or even reformat and reinstall your operating system remotely.

This is all great except for one small thing, unlike a traditional KVM that lets you control multiple devices, the PiKVM is really meant for remote controlling just one device.The PiKVM is built with just one HDMI input and one keyboard mouse input while traditional KVMs have multiple inputs for multiple clients.So how can we scale the PiKVM to connect it to more devices so that we aren’t stuck moving it from machine to machine each time we need to remote control one of our other devices?

{% include embed/youtube.html id='aOgcqVcY4Yg' %}
📺 [Watch Video](https://www.youtube.com/watch?v=aOgcqVcY4Yg)

![PiKVM v3 Hello screen](/assets/img/posts/pikvm-v3-lcd-hello.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/ALHjX4WfGHxXH+yppfhbx/o+maL8O9HtLzUBe2ghv4Lj4xWFp4v12HRJo9F1S4v0l0g6lbSSalf6fYWd7LZjR9D0+5/tnXta+AyXG4/Oa3EE5V40cNSxNXL8vUY/vcPOj7WnPETSspSnPlqKKqOzVk4o/WOIcoyPhnK+BqlPAyxWY4rD/wBtZ7OtU58NmNGrUwlWhgoRelKnSpqrQkvYe/GpKc3UlLlj0k37QnwJ1SaXU/Fp+J154q1GR77xNeQ+BtGuIbvxBdsbjWbmK4tfjV4dtp459SkuZUmt/D+hQSqweHR9MjZbKD46vmnFuGrVsP8A2th5ewq1KPM8NQk5eym4czlLCOTb5btybk922z9JoZL4WYyhRxi4NxcFi6VPEqEc3zGCh7eCq8qhDMOSCjzWUY+7FK0dEj//2Q==
" }
_The little LCD is both cute and functional_

You can build a PiKVM yourself by purchasing the PiKVM v3 HAT which is a great choice if you already have a raspberry pi4 and are willing to build it yourself.Or if you have a Pi Zero you can even build it using some inexpensive parts and without soldering.But chances are you have neither since raspberry pis are impossible to find and buying a pre-assembled kit is the only option.It was for me and that’s what I ended up doing.I purchased the PiKVM v3 pre-assembled which comes with a Raspberry Pi 4 2GB model, 32GB micro SD card, power supply, an HDMI cable, a USB C to USB A cable, and a nice case.The steel case is solid and feels sturdy and industrial.The PiKVM has lots of connections, connections for power, USB devices, mouse and keyboard emulation, RJ45 to serial connection, HDMI, and even an RJ45 connector for ATX power which lets me hook this up to a motherboard to power it on and off remotely.The other cool thing you get with the pre-assembled kit is the little LCD screen that shows system information and a cute cat when it boots. It comes pre-flashed with PiKVM installed and ready to go.

Oh, it runs arch BTW.

![Arch Linux Meme](/assets/img/posts/i-use-arch-btw.gif)
_I had to let you know_

## Sponsor

A HUGE THANKS to Micro Center for sponsoring today's content.

New Customer Exclusive – Free 256GB SSD: <https://micro.center/18l>

Shop AMD Ryzen 5 3600 & Gigabyte B450M Combo Deal: <https://micro.center/69d>

Check out Micro Center’s Custom PC Builder: <https://micro.center/d35>

Submit your build to Micro Center’s Build Showcase: <https://micro.center/dsw>

## PiKVM at Scale

But before we connect everything, remember when I said I wanted to connect it to more than one device?  Well, I wanted to connect it to 8x times that, yes 8 devices.I found this HDMI KVM switcher with a USB hub that I thought would be perfect for it. This TESmart allows you to connect up to 8 devices with video and USB and has a built-in USB hub.It also has an RJ45 port that allows me to change the input over IP and that’s it. It’s not an IP KVM otherwise I would need the PiKVM, but being able to switch the input over IP is all I needed to automate it with the PiKVM.I thought this device was perfect for remote controlling some of my servers considering it is rack mountable.However there was just one catch that would almost ruin this entire project that I didn’t know about yet.

## The Problems Ahead

I tested PiKVM on my workbench with this old intel NUC and it worked fine.I was able to remote control it and even power it on and off using Wake on LAN.I chalked it up as a success and started moving everything into my server rack.It might not seem like it, but mounting this HDMI KVM Switch took quite some time.I had to run HDMI cables and USB B cables to and from all of my devices that I wanted to remote control.I started running the wires  and wiring up 4 devices, just to be sure it worked with my existing machines before wiring up all 8.But, I bet you’re asking why I just don’t use IPMI that I have on my servers?  Well, this isn’t to control my servers, it’s to control my rack mounted PC conversion along my new Intel NUC cluster.None of these machines have IPMI so that’s why I needed an IP KVM solution like the PiKVM.

I decided to put my PiKVM on this little shelf for now but I’ll probably find somewhere a little more permanent to place it. Once I had everything hooked up, that’s when the troubles began.I could remote into some of the NUCs running Linux and the PC conversion, but not the ones running Windows.I thought for sure that it was something with my connection so I checked all of the connections over and over again.It was right around that time that the creator of PiKVM [Max Devaev](https://github.com/mdevaev) reach out to me asking me how I was liking the PiKVM and to let him know if I ran into any troubles because he was interested in advanced use cases for the PiKVM.I’m not sure why he thought I was going to be using this in an advanced way…. But he was right…

![TESmart switch with PiKVM](/assets/img/posts/pikvm-tesmart-8-port-switch.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AM7SP2Avjr8ffBXhfx5pPxf8G+B7rWvGdx4n8MzxaVc6lqknhfQPGWt6RF4S8QXx0G2ubXSrqygWzu7DT7rUGnthDE2pi0hewuPLpqL5uZvZJJQT3vd3ck77WdvLzOx8q+GNrSs/efvNxT2adlrrbX8b/anhz4E67N4e0GbxX4ti1fxTLouly+JdVhtIBDqevyWMD6xqEQlsUkEV7qJubmMSIrhZBvVWyBGnSU0uiu9F0XxA4y/u/cv8j//Z
" }
_This was my first attempt with a TESmart Switch_

I worked with Max for a few days on and off over discord.He sent snippets of code for me to run and even gave me lots of EDIDs to try. EDIDs (Extended Display Identification Data) are a signature or metadata that tell a device how to work with the monitor.Sometimes we could get the Linux machines running on the TESmart switch working, but not the Windows machines. And other times we could get the Windows machines working but not the Linux machines.We ended up discovering that the TESmart HDMI switch would “poison” the PiKVM and send the TESmart EDID rather than the one from the PiKVM.

TESmart EDID:

```text
Section "Monitor"
        Identifier "ITE-FHD"
        ModelName "ITE-FHD"
        VendorName "ITE"
        # Monitor Manufactured week 12 of 2010
        # EDID version 1.3
        # Digital Display
        DisplaySize 620 340
        Gamma 2.20
        Option "DPMS" "false"
        Horizsync 13-46
        VertRefresh 23-61
        # Maximum pixel clock is 170MHz
```

PiKVM EDID

```text
Section "Monitor"
        Identifier "PiKVM"
        ModelName "PiKVM"
        VendorName "LNX"
        # Monitor Manufactured week 28 of 2011
        # EDID version 1.3
        # Digital Display
        # Display Physical Size not given. Normal for projectors.
        Gamma 2.20
        Option "DPMS" "false"
        Horizsync 15-46
        VertRefresh 59-61
        # Maximum pixel clock is 150MHz
        #Not giving standard mode: 256x160, 60Hz
```

At this point, I had to cut my losses and go with a smaller, non rack mountable, but more compatible EZCOO KVM Switch and, I have to say,  it’s fantastic.

## A New HDMI Switch Enters the Chat

This is the EZCoo HDMI KVM switch. It’s a 4 port HDMI KVM Switch that allows 4 HDMI ports to be switched to a single display. This single display will be the PiKVM.It also has a built- in USB 3 hub which is awesome for plugging in USB devices that will connect to the machine when you switch the input.It has 4 HDMI inputs and 1 USB 3 input that you’ll connect to each machine and has one HDMI out and one USB for keyboard and one for mouse.We won’t be using these specific USB ports because we’ll be using mouse & keyboard emulation in one plugged into a generic USB port.

The real magic of this device is that it has a micro USB management port on the side that the PiKVM can use to control and toggle the inputs automatically, giving us a way to switch between all of our connected devices without having to manually press the input button.As nice as this device is, I really wish they made an 8 port rack mountable one because I want to control more than 4 devices without swapping them out or daisy chaining them,  Which is why I wanted the TESmart switch in the first place.

Oh, speaking of the TESmart, after working with Max for a while on this device he mentioned that this might work with the new v4 version of the PiKVM which just [recently launched on Kickstarter](https://www.kickstarter.com/projects/mdevaev/pikvm-v4).He said he was going to send one of their prototypes to test so, fingers crossed it works.I will be sure to create a v4 video once it’s released and hopefully it supports the TESmart switch.

![EZCOO switch with PiKVM](/assets/img/posts/ezcoo-switch-back.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APONa8N6j43+JniH43aR+1t8ZPBH9v32gapa/Duy+B+n6p4Y8B3tloOi6XD4c8GXumftP+DZYfCnhqbTorHwuItJ0e8Oh2WnLq0NzqC3dxcc0MRGNOVF0oS9p8UnToudr/ZqTpyqU9Fb93KN/IueH55wrqVSMqT0jGtXhTf+OlTqRpVHr/y8hPZaaH7hQft7fs+yQQvq0P7Qd3qrxRvqV3p/h74X6VYXOoMgN5cWWlnxPenTbSa5MkltYfbbv7HCyW/2q48vzXz9hS/vLyTdl5L3tjp9tU7Qfm4q79fd3P8A/9k=
" }
_This EZCOO is small, compact, and 100% compatible_

## Putting it all together

Now that I had everything working the way it should it was time to connect to each device through the web portal.Once connected, I can toggle between each of my devices here, from my first Intel NUC running Ubuntu, to my Second Intel NUC running Windows 10, to my third Intel NUC running Windows 11, to my PC conversion running Ubuntu server.And you can see that it’s pretty snappy. The latency is really low and I can even run HD videos no problem at all.If I do run into any latency issues or I am on a slow connection I can change the protocol and even the bitrate to something more fitting.

But running HD videos probably isn’t the reason you want a KVM, it’s more likely that you want to have access to the machine while it boots, and here’s where it gets really awesome. The PiKVM is open and it’s totally hackable and there are some great plugins and drivers that allow you to customize the UI with those plugins. For instance I can shutdown this machine and then wake it up using a Wake on LAN packet to power it back on.Side note, I learned a ton about making Wake on LAN work for Windows and Linux and I will be updating my blogs with complete walk-throughs of how to enable it, but anyway If that wasn’t cool enough I can then get into the BIOS of this machine to make any changes that I want.I can change the boot order, change boot devices, overclock the machine and do anything that I couldn’t normally do without being right in front of the machine.I can even upload ISOs to the PiKVM and then attach them to the device virtually and boot from it to install any operating system!  This lets me rebuild any of these machines no matter where I am all from a web browser.

Want to install Linux on a machine that’s powered off, no problem.Just attach the virtual drive to the machine, send a wake on lan packet to wake it up, then boot from the virtual drive and install! You could also attach the ATX power control to the header of the motherboard if you like and power it on that way, but I have network access to all of my machines so I will use wake on lan.Plus, it’s super awesome to be able to wake devices up over the network. And here’s where it gets really awesome,  remember how I said that my KVM also has a USB Hub?  Well, I’ve attached a 64GB USB drive to it with [Ventoy](/posts/ventoy-tutorial/) installed that has every ISO I could ever need.As I switch inputs between machines it attaches the USB drive with Ventoy to each machine allowing me to install any operating system I want.

![EZCOO switch with PiKVM and everything connected](/assets/img/posts/ezcoo-switch-connected-usb.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APnT9rWDwb+yt8aPE/gXS7jxhp7/ABt8C6H4y1W503/hG/GN7FHqfiTx5pNhp7eK/F+nWviqK30fT9C0OGwMV5Lq0EUItBr72umaai+Bl1anGnUqTpzlyxrUaPsqkKChKVKKUp05Ua8akG6jc4RlSk941IzfOvo6qxPt4VaFeFGpCpTnUlOlVrTnSbaqQp1YYrDSpVHT5qcKtSOIjFNc1KcVyPwjxn4g8CeGvGHivw5J8DvgO8mgeJdd0R3h+BXwMniZ9K1S6sWaKa6+GH2maNjASktz+/kUh5v3halCpNxi/aVNYp/xJ9Uv7xhOhDnl/il9mHd/3T//2Q==
" }
_You can make this even more powerful by adding a USB drive and Ventoy_

Because the PiKVM is hackable, I’ve customized the GPIO menu to let me switch between devices, wake them up, wake them up on different NICs, and restart the `kvmd` service or the PiKVM itself. (See my config below)  I should say that I didn’t really “hack” it, this isn’t a “techno tim” hack - there’s an overrides file that lets you customize most of the PiKVM so I didn’t go totally off the rails.It even has a web ui to give you terminal access to your PiKVM in case you aren’t able to use SSH, which is super handy if you’re mobile. But this little device has so many features already and the fact that the software is open source and continues to be updated makes this solution such a great investment for me.

![PiKVM remote control menu](/assets/img/posts/pikvm-remote-control-menu.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5ddFvPDfhLwn46gtfAtt4p+L+ueNdQun8f+OvFura94Z8M6BH4kvdT0618N/DwaXBpF9Ounw6Rpl7p3imfWdGuUGql4ZILixtrD26GFqVsXTxFXFyhl+Dlj6uIy6nh4znm2IqezpYWjicdKrCtgcBhKUcTOVPBU1isRiK1GccXhqeGnSxX2lDN/D3CcH0cJPhbN8bxysbivb5zis3hHIaeAq0qTy+pg8qoUqdb6/hcQq8K9PHVcdgMXS9nVnRUpuhR6XQvD17BomjwXEti08OlafFM1v8AaxAZo7SFJDCLp7q6EJcMY/tNzcT7NvnTyybpG3hTShBLRKEUlrKystOaTcpW7y1e71Pz2bTnJqKinKTUYq0Ypt+7FdEtkux//9k=" }
_You can customize the menu however you like (my config below), here I added WoL for each network card and even a way to restart the PiKVM from the menu_

## Is it worth it?

So I bet you’re wondering if it’s worth it? I am going to break this down into 2 parts.Is it worth it to buy pre assembled? And is it worth it for remote control with a PiKVM. Well for me it is for a few reasons.First of all I can’t find a raspberry pi to assemble this myself, and if you consider it comes with a case, a fan, a 32GB micro sd, additional cables, and even a little LCD screen 100% ready to go for an additional 90 bucks?  I would say it is.Now on to the tougher question, is it worth it to have a PiKVM at all?  I would say yes for me, but for you it depends.The way I looked at it was that I was going to scale it to 8, which would divide the cost of a PiKVM and switch across 8 machines making it around 70 dollars per machine if you include all of the cables.

`PiKVM $259 + TESmart $299 / 8 = $70 per machine`

 I’d say that it's worth it for me to have remote access to that many machines for the life of each machine.But, I did have to downgrade to a smaller switch that only gives me access to 4 machines which is roughly 95 dollars per machine.

`PiKVM $259 + EZCOO $120 / 4 = $95 per machine`

That’s a little bit higher, however it’s a much better value than remote controlling just one machine with the PiKVM, which would be the cost of the PiKVM.

`PiKVM $259 / 1 = $259 per machine`

## Hardware

Here are the items that I used during this project.

PiKVM - <https://pikvm.org>

EZCOO - HDMI KVM Switch - <https://amzn.to/3IyiIv1>

HDMI Cables - <https://amzn.to/3SgJ34g>

USB B Cables - <https://amzn.to/3Eel0wU>

USB C Cables - <https://amzn.to/3k8vQhb>

USB Flash Drive - <https://amzn.to/3XI50u6>

TESmart Switch (not full compatible) - <https://amzn.to/3YV0Gsi>

(Affiliate links may be included in this description. I may receive a small commission at no cost to you.)

### PiKVM Config

Here is my PiKVM config that I use.You will need to edit `/etc/kvmd/override.yaml` on your device and then restart the `kvm` service.

```yaml
kvmd:
    gpio:
        drivers:
            ez:
                type: ezcoo
                protocol: 2
                device: /dev/ttyUSB0
            wol_server0:
                type: wol
                mac: 1c:69:7a:ad:11:85
            wol_server1:
                type: wol
                mac: 88:ae:dd:05:cf:09
            wol_server2:
                type: wol
                mac: 88:ae:dd:05:c6:3b
            wol_server3:
                type: wol
                mac: a0:36:9f:4f:c4:b4
            wol_server3a:
                type: wol
                mac: d8:50:e6:52:8e:c2
            reboot:
                type: cmd
                cmd: [/usr/bin/sudo, reboot]
            restart_service:
                type: cmd
                cmd: [/usr/bin/sudo, systemctl, restart, kvmd]
        scheme:
            ch0_led:
                driver: ez
                pin: 0
                mode: input
            ch1_led:
                driver: ez
                pin: 1
                mode: input
            ch2_led:
                driver: ez
                pin: 2
                mode: input
            ch3_led:
                driver: ez
                pin: 3
                mode: input
            pikvm_led:
                pin: 0
                mode: input
            ch0_button:
                driver: ez
                pin: 0
                mode: output
                switch: false
            ch1_button:
                driver: ez
                pin: 1
                mode: output
                switch: false
            ch2_button:
                driver: ez
                pin: 2
                mode: output
                switch: false
            ch3_button:
                driver: ez
                pin: 3
                mode: output
                switch: false
            wol_server0:
                driver: wol_server0
                pin: 0
                mode: output
                switch: false
            wol_server1:
                driver: wol_server1
                pin: 0
                mode: output
                switch: false
            wol_server2:
                driver: wol_server2
                pin: 0
                mode: output
                switch: false
            wol_server3:
                driver: wol_server3
                pin: 0
                mode: output
                switch: false
            wol_server3a:
                driver: wol_server3a
                pin: 0
                mode: output
                switch: false
            reboot_button:
                driver: reboot
                pin: 0
                mode: output
                switch: false
            restart_service_button:
                driver: restart_service
                pin: 0
                mode: output
                switch: false
        view:
            table:
                - ["#NUC1", ch0_led, ch0_button, "wol_server0 | WoL"]
                - ["#NUC2", ch1_led, ch1_button, "wol_server1 | WoL"]
                - ["#NUC3", ch2_led, ch2_button, "wol_server2 | WoL"]
                - ["#PC", ch3_led, ch3_button, "wol_server3 | WoL-10g", "wol_server3a | WoL-1g"]
                - ["#PiKVM", "pikvm_led|green", "restart_service_button|confirm|Service", "reboot_button|confirm|Reboot"]
```
{: file="/etc/kvmd/override.yaml" }

## Wake on LAN

If you're having issues with Wake on LAN, see [The Ultimate Guide to Wake on LAN for Windows, MacOS, and Linux](/posts/wake-on-lan)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">The last few weeks I have been trying to figure out how to scale the PiKVM to more than one device. It took a lot of twists and turns but I finally figured out a solution, even if the first attempts failed... <br><br>Check it out ⬇️<a href="https://t.co/4qgwcmPwMi">https://t.co/4qgwcmPwMi</a><a href="https://twitter.com/hashtag/raspberrypi?src=hash&amp;ref_src=twsrc%5Etfw">#raspberrypi</a> <a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://t.co/ljxpIE3cYx">pic.twitter.com/ljxpIE3cYx</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1626989646713430018?ref_src=twsrc%5Etfw">February 18, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
