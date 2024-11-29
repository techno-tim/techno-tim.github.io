---
layout: post
title: "Meet netboot xyz - Network Boot Any Operating System"
date: 2023-11-11 08:00:00 -0500
categories: self-hosted
tags: netbootxyz pxe docker open-source homelab
image:
 path: /assets/img/headers/netboot-xyz-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APt6Hwl4U0fT47D/AIQ3wpqNzp5YTapqA8YPc37CeGS4kuILfxpb2EMl3tlEhtLWCOI3d1JaxwS/ZHtJjipXk+VK/K1bpZ9dHzJqNmtNHre2rdGNOL+0431lquuybdt+jOPPg+3cl4717eNiWS3i07R3igRjlYY3utPubp44lIRGubi4nZVBmmlkLSNUq8ZSlJ0Kacm5NRSjG7d3yxSSiu0VolotCVKtZWq2VlZct7K2mt9fU//Z
---

Imagine all of your favorite operating systems in one place, available anywhere on your network, and you'll never need to use your flash drive again.  That's the promise of netboot.xyz, a network boot service that lets you install or boot to any operating system simply by booting to the network.

{% include embed/youtube.html id='4btW5x_clpg' %}
📺 [Watch Video](https://www.youtube.com/watch?v=4btW5x_clpg)

Disclosures:

- Nothing in this video was sponsored

Don't forget to ⭐ [netboot.xyz on GitHub](https://github.com/netbootxyz/netboot.xyz)!

## Requirements

- docker (and compose)
- docker machine has a static IP
- dhcp server & access to settings (or install your own)

## Docker Setup

See [this post](/posts/docker-compose-install/) on how to install `docker` and `docker compose`

## Install

create folders `netboot_xyz`, `netboot_xyz/assets`, `netboot_xyz/config`

```shell
mkdir netboot_xyz
cd netboot_xyz
mkdir assets
mkdir config
```

Copy yaml to server or portainer, etc

### Container Images

linuxserver.io container image

[Parameter Docs](https://docs.linuxserver.io/images/docker-netbootxyz/?h=netboo#parameters)

```yaml
---
version: "2.1"
services:
  netbootxyz:
    image: lscr.io/linuxserver/netbootxyz:latest
    container_name: netbootxyz
    environment:
      - PUID=1000 #current user
      - PGID=1000 #current group
      - TZ=Etc/UTC
      # - MENU_VERSION=1.9.9 #optional, sets menus version, unset uses latest
      - PORT_RANGE=30000:30010 #optional
      - SUBFOLDER=/ #optional
    volumes:
      - ./config:/config
      - ./assets:/assets #optional
    ports:
      - 3000:3000
      - 69:69/udp
      - 8080:80 #optional
    restart: unless-stopped
```

Official container image

[Parameter Docs](https://netboot.xyz/docs/docker#parameters)

```yaml
---
version: "2.1"
services:
  netbootxyz:
    image: ghcr.io/netbootxyz/netbootxyz
    container_name: netbootxyz
    environment:
      # - MENU_VERSION=2.0.47 # optional, sets menus version, unset uses latest
    volumes:
      - ./config:/config # optional
      - ./assets:/assets # optional
    ports:
      - 3000:3000
      - 69:69/udp
      - 8080:80 #optional
    restart: unless-stopped
```

### Running

bring up stack

```shell
docker compose up -d
```

check to be sure it's running

```console
➜  netboot_xyz docker ps
CONTAINER ID   IMAGE                                   COMMAND         CREATED          STATUS                  PORTS                                                                                                                 NAMES
83e6c5192156   lscr.io/linuxserver/netbootxyz:latest   "/init"         14 seconds ago   Up 12 seconds           0.0.0.0:69->69/udp, :::69->69/udp, 0.0.0.0:3000->3000/tcp, :::3000->3000/tcp, 0.0.0.0:8080->80/tcp, :::8080->80/tcp   netbootxyz
```

should see something like:

Check the logs

```console
➜  netboot_xyz docker logs netbootxyz
[migrations] started
[migrations] no migrations found
───────────────────────────────────────

      ██╗     ███████╗██╗ ██████╗
      ██║     ██╔════╝██║██╔═══██╗
      ██║     ███████╗██║██║   ██║
      ██║     ╚════██║██║██║   ██║
      ███████╗███████║██║╚██████╔╝
      ╚══════╝╚══════╝╚═╝ ╚═════╝

   Brought to you by linuxserver.io
───────────────────────────────────────

To support the app dev(s) visit:
netboot.xyz: https://opencollective.com/netbootxyz/donate

To support LSIO projects visit:
https://www.linuxserver.io/donate/

───────────────────────────────────────
GID/UID
───────────────────────────────────────

User UID:    1000
User GID:    1000
───────────────────────────────────────

[netbootxyz-init] Downloading Netboot.xyz at 2.0.73
[custom-init] No custom files found, skipping...
crontab: can't open 'abc': No such file or directory
listening on *:3000
[ls.io-init] done.
4Lg88gNm_wqDORftAAAB connected time=1699460581160

```

### Configuring

You can now browse to the container's homepage

`http://192.168.10.125:3000/`

You should see a list of pxe boot menu items and the option to cache the pre boot environment locally

### Local Mirror

If you want to serve the files from a local mirror, you can edit the `boot.cfg` file from the boot menus

change:

`set live_endpoint https://github.com/netbootxyz`

to:

`set live_endpoint http://192.168.10.125:8080`

Keep in mind that you will not be able to boot from any environments you haven't downloaded.

### DHCP Configuration

Since I cannot cover configuring every DHCP service out there, I will cover the basics. Fortunately [linuxserver.io has many routers covered](https://docs.linuxserver.io/images/docker-netbootxyz/?h=netboo#router-setup-examples) as well as the [official netboot.xyz docs](https://netboot.xyz/docs/docker#dhcp-configurations).

UniFi UDM Pro / SE

Settings > Network > Choose Network > DHCP Service Management > Show Options

Here you'll want to check "Network Boot" and fill in the server IP and the file name

For me, it's:

Server IP: `192.168.10.125`
Filename: `netboot.xyz.kpxe` (this is the default BIOS option)

Save.

Preferably we would like to offer a PXE boot per architecture, and UDM supports it however not in the UI.  [Follow these instructions to do it via CLI](https://community.ui.com/questions/PXE-Network-boot-UDM-SE-Serving-files-conditionally-based-on-architecture/1843fcf6-87d5-4305-bc1d-4e55619ebb10)

If you're up to it, here's my config:

```conf
#
# Generated automatically by 
#

# Configuration of PXE boot for '


# The boot filename, Server name, Server Ip Address
dhcp-boot=netboot.xyz.kpxe,netboot.xyz,192.168.10.125

# inspect the vendor class string and match the text to set the tag
dhcp-vendorclass=BIOS,PXEClient:Arch:00000
dhcp-vendorclass=UEFI32,PXEClient:Arch:00006
dhcp-vendorclass=UEFI,PXEClient:Arch:00007
dhcp-vendorclass=UEFI64,PXEClient:Arch:00009

# Set the boot file name based on the matching tag from the vendor class (above)
dhcp-boot=net:UEFI32,netboot.xyz.efi,netboot.xyz,192.168.10.125
dhcp-boot=net:BIOS,netboot.xyz.kpxe,netboot.xyz,192.168.10.125
dhcp-boot=net:UEFI64,netboot.xyz.efi,netboot.xyz,192.168.10.125
dhcp-boot=net:UEFI,netboot.xyz.efi,netboot.xyz,192.168.10.125
```

Verify

```shell
cat /run/dnsmasq.conf.d/PXE.conf
```

Copy file to `/run/dnsmasq.conf.d/PXE.conf` on UDM

run

```shell
kill `cat /run/dnsmasq.pid`
```

You'll have to  do this on each reboot

If you don't want to do this, you'll have to change the image file each time.

### Booting to network

To boot to the network you'll need a BIOS and NIC that supports it

- enable in BIOS
  - enable EFI PXE Boot
  - enable Legacy (BIOS) PXE Boot
- Figure out boot override or network boot key
- Power on and boot to network (BIOS of EFI)

See the boot menu, choose OS and go!

> *Word of caution, there might be some that do not work.  This is a moving target.
e.g.  Ubuntu 23.10 isn't working for me now, but could soon.  Other OS are fine. You may need to try different NICs if you are using virtualization*
{: .prompt-info }

## What about Windows?

Requirements

- Windows 10/11 machine
- Windows ISO
- Windows ADK for Windows 10/11
- Windows PE add-on for the Windows ADK

[Windows 11 ADK downloads here](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install#download-the-adk-for-windows-11-version-22h2-updated-september-2023)

Install Windows ADK for Windows 10/11.

Install Windows PE add-on for the Windows ADK.

Run `Deployment and Imaging Tools Environment` as administrator from the start menu.

Navigate to folder

```shell
cd "..\Windows Preinstallation Environment\amd64"
```

Mount the Windows PE boot image.

```shell
md C:\WinPE_amd64\mount
Dism /Mount-Image /ImageFile:"en-us\winpe.wim" /index:1 /MountDir:"C:\WinPE_amd64\mount"
```

Copy files

```shell
Xcopy "C:\WinPE_amd64\mount\Windows\Boot\EFI\bootmgr.efi" "Media\bootmgr.efi" /Y
Xcopy "C:\WinPE_amd64\mount\Windows\Boot\EFI\bootmgfw.efi" "Media\EFI\Boot\bootx64.efi" /Y
```

Unmount the WinPE image, committing changes.

```shell
Dism /Unmount-Image /MountDir:"C:\WinPE_amd64\mount" /commit
```

Delete the temp folder that was created earlier (so we don't get an error when copying)

```shell
rmdir /s C:\WinPE_amd64
```

Create working files

```shell
copype amd64 C:\WinPE_amd64
```

Create a bootable WinPE ISO

```shell
MakeWinPEMedia /ISO C:\WinPE_amd64 C:\WinPE_amd64\WinPE_amd64.iso
```

Then copy the contents of `WinPE_amd64.iso` to netboot.xyz container's `/assets/WinPE/x64/` folder (need to create folders first)

Then you'll want to create an SMB share named `Windows` in your environment.  You can create or download a Windows ISO by visiting [Microsoft's site](https://support.microsoft.com/en-us/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d)

Once you have created your Windows ISO, you can then extract the files to the root of the `Windows` share you just created above.

Now we need to configure netboot.xyz

In netboot.xyz UI, update `boot.cfg` to `set win_base_url http://192.168.10.125:8080/WinPE` and save.

Now you can PXE boot to the network (be sure you are using the EFI boot image and your device supports UEFI) and then choose Windows from the netboot.xyz menu.

This should boot to a DOS prompt in the Windows Pre-boot Environment

Type

```shell
wpeinit
```

then type

```shell
net use F: \\<server-ip-address>\<share-name> /user:<server-ip-address>\<username-if-needed> <password-if-needed>
```

If you want it to prompt for a username and password, remove the `user` argument

```shell
net use F: \\<server-ip-address>\<share-name>
```

This will map the `F:` drive to your `Windows` share that the Windows ISO extracted

then type

```shell
F:\setup.exe
```

Then hit enter and Windows installer should launch!  

I'd love to also automate the mounting of the share however I haven't found a clean way to do it yet.  If you know, let me know in the comments below and I can add it!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Back in my tech support days I thought that if I had PXE network boot at home, that I &quot;made it&quot;. We&#39;ll, that day has come! This past week I learned all about netboot xyz! I can now boot and install any operating system over the network!<br><br>Check it out! <a href="https://t.co/PzPmYzKWLH">https://t.co/PzPmYzKWLH</a> <a href="https://t.co/FQr4W4TPtp">pic.twitter.com/FQr4W4TPtp</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1723377803700076676?ref_src=twsrc%5Etfw">November 11, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
