---
layout: post
title: "The Ultimate Guide to Wake on LAN for Windows, MacOS, and Linux"
date: 2023-02-19 10:00:00 -0500
categories: utilities
tags: wol windows mac linux network network wake-on-lan
image:
  path: /assets/img/headers/electric-city.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APxf8Q+D9PT4Y/G/wDq0s9+vhfXPBXia11ewEOivqGp6hptzYhtT0qCK50t47az0SK3jaxgsLidbiV7y4uZljlX+qsZmE8XTw1Ct7dfW6dV4qdKvGkq1KhSp0qFGdKNF0pRhUw1OtKU4zlNpRXIkmvxjCcDYTA5nn+Lw1ago5PGDy+jVwPtnRxNWX13FYhYiWKWIj7enjq+GVOjOioRbqOdRynCXwX/Zxb5vtMi552pFAqLnnai+WdqjoozwMCsHisXTbprGYq0G4LkqU4R933fdgqTUI6aRTairJbHlU8oy+vCFeWAy69aEar58HGpO9RKb5qjqJzld+9NpOTvJq7P/2Q==

---

## What is Wake on LAN and why is it so hard?

After releasing [my video on the PiKVM](/posts/pikvm-at-scale/) I realized that there was so much confusion about Wake on LAN, and rightfully so, that I decided to put together this guide on how to configure Wake on LAN on any machine. Wake on LAN (WoL) is a networking standard that allows a computer to be turned on by sending a network packet. The client sends a special packet (sometimes referred to as a "magic packet") and the remote machine will wake up either from a cold power state or from sleep.This is where it starts to get complicated because different hardware manufactures have implemented different controls in BIOS to enable or disable this, and to make even more complex operating systems like Windows, macOS, and Linux have also implemented their own way to wake the machine up when it's sleeping or in a low powered state.I am just going to throw this out there, Wake on LAN is hard.Since there are many different combinations I will try to cover how to configure your machines wake up successfully regardless of hardware, operating system, and power state.

## Preparing your hardware for Wake on LAN

In order to wake your machine up, we have to be sure that WoL features are turned on in the BIOS and that other features are disabled.Since I cannot test every single BIOS out there, I am going to use my machine as an example for the types of options you will need to enable or disable.Most of the options should be named similarly however where it is located in your BIOS will depend on your manufacturer.

First, you'll need to get into the BIOS of the machine, this is typically done by pressing a key at book like `f2` or `del` but varies by machine.

Once you're in you're in we'll start changing some settings.

### Power settings

You'll want to look around for something similar to power settings.If you do not see these options in your power settings, it could be in advanced, networking, or onboard devices.

![Windows WOL Client](/assets/img/posts/intel-nuc-power-settings.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP49re4+0eD9R0O5Fo2oX91ozt4pOlo+r6DpdoNPF1aaTDHf2tvfteGS4e4F81u0u2KOO5tfMlkH6tWoVamEcKWLarSpR5b4SnCKqaPWrGrOdv7/ALNy1+FH49RxVKljIyq4GLoRqSjP/bKlWThdrmjRqYeNPm/ue1ilsqjPMlfxdbqtvJ4l1LzIFEMnk6rqSQ74hsbylDoFj3KdihEAXACrjA8f6nilpLEXktJPnq6yW73W78l6I9f+0MM9YYZKD1gnTo3Ufsp6PVKyer9Wf//Z
" }
_Power settings menu for Intel NUC.This will look different for your machine but the idea is still the same_

Here are some things to look for:

- **Deep S4/S5 Sleep** - You'll want to **disable** this, otherwise only the power button will wake the machine which will disable Wake on LAN

- **Wake on LAN from S4/S5** - You'll want to **enable** this setting and if it has an option choose **Power on - Normal Boot**

- **Wake System from S5** - You'll want to **disable this**.This is basically an alarm clock for your machine.There's no need to enable this unless you want set a time for it to turn on every day.I've used this in the past as a contingency plan for some of my servers in case they were powered off accidentally. I would set an alarm for 12 AM.

- **USB S4/S5 Power** - I typically **disable** this if it's a server since nothing should be plugged in but if it's a desktop with USB devices you want powered you can turn it on safely.

- **Wake on LAN** - **enable** this might sound obvious but some older systems have an option that says exactly that however newer systems have options for waking in all of the different sleep states.

- **What to do when AC Power is restored** - This is optional but I usually set it to **Stay Off** if it's a desktop, **Power On** if it's a server that should always be on, and **Last power state** if it's something like a machine that I wake seldomly.There is one exception, which is if you have a way to toggle the power remotely too.I have a [USP PDU Pro](https://l.technotim.live/ubiquiti) from UniFi that I can toggle all of my servers on and off.If you are able to toggle them on and off, the best setting is **Power On**, that way you have a way to power them on, even if they were gracefully shut down previously.

Another quick check you can do is power down the machine and check to be sure the network light is lit up on your NIC.If it's not, this means Wake on LAN is not enabled on your machine and you'll have to find the option in your BIOS to make it work.

## Bare Metal Wake up

If you don't have an operating system on your machine yet, you should be able to wake up the machine over the network now.If you do have an operating system on your machine, another way you can test a bare metal / cold boot wake is by pulling the power on the machine and then plugging it back in.The reason this should work is because modern operating systems might not fully shut down (they go into a sort of sleep) or might disable WoL on the NIC when shutting down.We'll fix this in the next section.

## Waking up a Windows machine

After you enabled Wake on LAN in the BIOS, and verified you see the light on your NIC blinking when you power off your machine, we can now enable Wake on LAN at the operating system level for Windows.This will work on all modern versions of Windows (Windows 10 and Windows 11).

### Device manager

First we'll want to open the Device Manager.You can do this from the UI or from a command prompt

```terminal
devmgmt.msc
```

![Windows device manager](/assets/img/posts/device-manager-wol.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAcACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7cfhs2kr4b0uObw74X+xiF0W/Ml2t9OkVxLHGZ7JPDksIkChmONQZVyEDSNvmfSclf3Zza/vK1l0StKWi+XoXQhQ9lN151KVZcns4UqMK0J3i+d1Ksq9CVNpqKXLSrc6cm3HlSl5T4hi8Kf2/rmy108J/bGp7QNPcAL9tn2gD7PwAMcdqi77v72Qf/2Q==" }
_Be sure to select the network card that you use to connect to your network._

- Once open you'll want to expand Network adapters and find your network adapter, then right click and choose **Properties**
- Then choose the **Power Management** tab and be sure that all of these options are enabled
  - **Allow the computer to turn off this device to save power**  
  - **Allow this device to wake the computer**
  - **Only allow a magic packet to wake the computer**.

![Windows Power management for NIC](/assets/img/posts/windows-nic-power-management-wol.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4kJZ5CJ5S26aSSOSWbasbmaQmRiojwNoZX5JyW2uFjy60Bp5/f/X5lQNNgYlcDAwA7DA7DHbFAH//Z
" }
_Power Management options for your network adapter._

Then we'll need to verify a few more settings.These settings may or may not exist and depend on your network adapter manufacturer.

- Click on the **Advanced Tab** for your Network Adapter
- Find **Wake on Magic Packet** and set it to **Enabled**
- Find **WOL & Shutdown Link Speed** and set it to **10 Mbps** _You'll want to be sure that your switch supports this speed, otherwise **Auto** should be fine_
- Click **OK**

You should check to see if Wake on LAN works before proceeding to the next step since this might not be necessary with your machine.

### Fast Startup

Another Windows Feature that can prevent a machine from shutting down properly to allow Wake on LAN is **Fast Startup**.This disables hibernation.I recommend testing to see if Wake on LAN works before disabling this.

First, we'll need to open the Power Control Panel.You can do this from the UI or from a command prompt

```terminal
powercfg.cpl
```

Then we'll need to change some settings

- Click **Choose what the power buttons do** from the left menu
- Click **Change settings that are currently unavailable**
- Uncheck **Turn on fast startup (recommended)**
- Click **Save changes**

You should now check to see if Wake on LAN works for your machine.

## Waking up a Linux machine

After you enable Wake on LAN in the BIOS, and verified you see the light on your NIC blinking when you power off your machine, we can now enable Wake on LAN at the operating system level for Linux.This sounds odd but I have found that machines (especially Linux) need WoL turned on for each NIC.

Install `ethtool` if you don't have it already

```bash
sudo apt update
sudo apt install ethtool
```

First check to see if WoL is supported by your NIC

```bash
ip a # this will list all of your NICs
sudo ethtool eno1 # replace with one of the NICs you want to check
```

This should output something similar to

```log
Settings for eno1:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        MDI-X: on (auto)
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes
```

You're looking for `Supports Wake-on: pumbg`  with at least the letter `g` in the string.This means that the NIC does support WoL for a magic packet, which is a good thing.If you don't see this here, don't worry we'll fix it in `netplan`

### Using Netplan

There are lots of outdated commands you'll find on the internet that won't work or will partially work so I advise that you only do this with `netplan`.If you don't have `netplan` installed (Debian, etc...) skip to the next section.

To edit your `netplan`

```bash
sudo nano /etc/netplan/01-netcfg.yaml  # replace with your netplan yaml
```

Once here, you'll see your network settings.You'll want to turn on `wakeonlan` in this yaml for each NIC.For example if you have 2 NICs, `eno1` and `enp2s0` you would add it in both places under that key.

```yaml
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      dhcp4: yes
      wakeonlan: true
    enp2s0:
      dhcp4:  yes
      wakeonlan: true
```
{: file="/etc/netplan/01-netcfg.yaml" }

Once this is set, you'll want to apply your netplan.

```bash
sudo netplan apply
```

Then we'll want to shutdown

```bash
sudo shutdown -P now
```

Now we should be able to wake up the machine using WoL from a remote machine.

### Without Netplan (Debian, etc...)

Since you don't have `netplan` we'll have to create a service and enable it.Do not do this step if you configure it with `netplan`.

Find the path to `ethtool`

```bash
which ethtool
```

In my case it's at `/usr/sbin/ethtool` but your may vary.

Nest we'll create a file at `/etc/systemd/system/wol.service`

```bash
nano /etc/systemd/system/wol.service
```

In this file add the following

```shell
[Unit]
Description=Enable Wake On LAN

[Service]
Type=oneshot
ExecStart = /usr/sbin/ethtool --change eno1 wol g

[Install]
WantedBy=basic.target
```
{: file="/etc/systemd/system/wol.service" }

You'll want to be sure to change your path for `ethtool` as well `eno1` to the name of your NIC

Then we'll need to enable the service

```bash
sudo systemctl daemon-reload
sudo systemctl enable wol.service
```

Then we can check to be sure out service is started

```conf
systemctl status wol
```

Then we'll want to shutdown

```bash
sudo shutdown -P now
```

Now we should be able to wake up the machine using WoL from a remote machine.

## Waking up a Mac

Waking up a Mac is pretty easy, the easiest of them all.The most challenging part is finding the option in System Preferences.

For a Macbook:

- Open **System Preferences** and search for **power**
- Click on **Power Nap** in **Battery**
- You'll see **Wake for network access** here you can choose whether you want to wake up **Always** or **Only on Power Adapter**.Either of these options should be fine.

For all other Macs you'll want to search System Preferences for another option.

- Search for **"Energy Saver"**
- Here you'll see an option to **Wake for network access**.Be sure this is check

![Windows WOL Client](/assets/img/posts/macos-wake-on-lan.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAoACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5MtHTwTqun2T67q8tnqUzzR3UFrb237iRJpIbQoj/2XZQxTweXNe3FxfTSbiZ2VizbOPDxp1K0adapOlTl7sZ06VKp77aUFL2+KwlKFO79+rOtGNNe81ZO31M6svqsatOFGpUp04xdOUvYRVOlHlbSw2ExFSdVxinZUZVMRVlKdScqs3KXBnBJICgE5ACJgDsBweB9T9T1rPXrv19S+S+umvaWny93YxEJOcknp/Wg5KG0vX9CwZpiSTLKSTkkyMSSepJz1oNz/9k=" }
_This option might appear different in different versions of macOS and it also varies by form factor, but you'll want to be sure that the "Wake for network access" option is turned on_

## Installing a Wake on LAN client

In order to wake up a remote machine machine up, you will need a tool that can send a wake on LAN packet to the remote machine.

### Windows Wake On LAN CLient

I am a fan of doing this in a terminal however a decent Windows utility with a GUI is [WakeOnLAN](https://github.com/basildane/WakeOnLAN).It's also open source and hosted on GitHub.After installing it and configuring a machine to wake you should be able to wake your machine if it is on the same network and you've followed the other steps that are outlined in this guide.

![Windows WOL Client](/assets/img/posts/wake-on-lan-app-windows.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7t7Hwr4QtbSRYNsaSMJUij1i7iWExII0WHybyNwjbPMdXeQu7sCTHsjW/aT095uyUU3q7K1tXdt6JNvVrRtpsSVrtNq7u/el5+ei1dktF02R44/ia1DuAZSAzAEx3eSATgnNqTkjrkk+pNbRjeMW6/K2k2uaLs2tr+11ttcl1ay2Tt09+a06acmnof/9k=" }
_WakeOnLAN is an open source Windows utility that has a nice GUI_

### Linux Wake on LAN client

I usually prefer installing a command line tool to wake machines up over the network from a Linux machine and I typically using `wakeonlan` an open source utility that's simple to use.

To install it on a Debian-like system:

```bash
sudo apt update
sudo apt install wakeonlan
```

Once it's installed you can now wake machines on the same network by using the command:

```bash
 sudo wakeonlan 00:11:22:33:44:55
```

If your machine is on another network and you can reach the broadcast IP, you can supply it in your command

```bash
 sudo wakeonlan -i 192.168.2.255 00:11:22:33:44:55
```

Be sure to replace the mac address and broadcast IP above with the mac address of the remote machine and set the broadcast IP if on a different network.

### macOS Wake on LAN client

To instal a client for macOS it's very simple using `brew`

```terminal
brew install wakeonlan
```

Once it's installed you can now wake machines on the same network by using the command:

```bash
 wakeonlan 00:11:22:33:44:55
```

If your machine is on another network and you can reach the broadcast IP, you can supply it in your command

```bash
 wakeonlan -i 192.168.2.255 00:11:22:33:44:55
```

Be sure to replace the mac address and broadcast IP above with the mac address of the remote machine and set the broadcast IP if on a different network.

## Wrapping up

At this point you should be able to power on any machine from any machine on your network. One piece of advice is if you are using VLANs you'll want to b sure you are sending the WoL packet from the same network, otherwise you'll have to be sure that you can reach and target the right broadcast IP from the network you are on.As I mentioned in the beginning of this post, Wake on LAN is hard however if you follow these steps for each machine type you should be able to enjoy reliably waking up your machine remotely over the network.

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Day 252 <a href="https://twitter.com/hashtag/100daysofhomelab?src=hash&amp;ref_src=twsrc%5Etfw">#100daysofhomelab</a> <br><br>A day late, but I just wrapped up my Ultimate Guide to Wake on LAN for Windows, MacOS, and Linux! <a href="https://t.co/xYMVDoyuo9">https://t.co/xYMVDoyuo9</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1627410727588794373?ref_src=twsrc%5Etfw">February 19, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
