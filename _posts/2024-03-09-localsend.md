---
layout: post
title: "Meet LocalSend - A Cross Platform, Open Source Alternative to AirDrop"
date: 2024-03-09 08:00:00 -0500
categories: apps
tags: app open-source homelab localsend windows android ios macos linux
image:
 path: /assets/img/headers/localsend-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5otD+PHhXTNLm02/8A2bfgl4umtrvw5a6hrnizVvj8ddvxs1F/tdrJ4Q+OPg7RtF1IjT7UPeaZokQdra3ZodouY7rzcUoKtTxM4OSw8JVadOFSpRamm1K8oT5JxlC0VCpRmo+9b3ZOJ3UKtRQq0ISio15Rp1XOlRq3gkpx5PaQc6clJtuVOcXJ2b1SZizWNpczS3K2NvbC4kecW0GoeKmgtxKxkEELXPie5uWiiDeXGbi4nnKKDLNLJudvGjn0pJS+rRXMlKznSdrq9rvD3fq9XuyZ0HCUoc9+WTjezV+VtXsp2W23Q//Z
---

LocalSend is an open source application that securely transfers files between devices without the internet.  It's cross platform meaning that it's available for Windows, Mac, Linux,  iOS (iPhone, iPad), and Android devices.  This is a great alternative to AirDrop or QuickSend and can send and receive files to other devices without a 3rd party service like Google Drive.  

{% include embed/youtube.html id='2ITezMkbAqE' %}
📺 [Watch Video](https://www.youtube.com/watch?v=2ITezMkbAqE)

Disclosures:

- Nothing in this video was sponsored

Don't forget to ⭐ [localsend on GitHub](https://github.com/localsend/localsend)!

## Installing on Windows

From a terminal:

Using Winget

```powershell
winget install localsend
```

Using Chocolatey

```powershell
choco install localsend
```

Install from GitHub
<https://github.com/localsend/localsend/releases>

## Installing on iOS

App Store recommended for most users.

[Download on the App Store](https://apps.apple.com/us/app/localsend/id1661733229)

## Installing on Android

App Store recommended for most users.

[Get it on Google Play](https://play.google.com/store/apps/details?id=org.localsend.localsend_app&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1)

Install using an APK <https://github.com/localsend/localsend/releases>

## Installing on Linux

Package Manager:

Install with terminal.

Ubuntu / Debian

Download deb file <https://github.com/localsend/localsend/releases>

```bash
cd ~/Downloads #change to download folder
sudo dpkg -i LocalSend-1.14.0-linux-x86-64.deb #change version to match download
sudo apt install -f # install missing dependencies
sudo dpkg -i LocalSend-1.14.0-linux-x86-64.deb #change version to match download
```

Flathub

```bash
flatpak install flathub org.localsend.localsend_app
flatpak run org.localsend.localsend_app
```

AUR

```bash
yay -S localsend-bin
```

Nix

```bash
nix-shell -p localsend
pkgs.localsend # Config
```

## Installing on macOS

Package Managers:

Install with terminal.

Homebrew

```bash
brew tap localsend/localsend
brew install localsend
```

Nix

```bash
nix-shell -p localsend
pkgs.localsend # Config
```

Binaries:

Download for offline usage. <https://github.com/localsend/localsend/releases>

App Store recommended for most users.

[Download on the App Store](https://apps.apple.com/us/app/localsend/id1661733229)

See all releases
<https://github.com/localsend/localsend/releases>

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I found a free and open source alternative to AirDrop called LocalSend! It works with Windows, macOS, Android, and even Linux! Join me as I test it on every platform and see if I can transfer a file to every platform using this app!<br><br>👉<a href="https://t.co/iWcGjDL476">https://t.co/iWcGjDL476</a> <a href="https://t.co/K24T37TOoq">pic.twitter.com/K24T37TOoq</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1766501460416557368?ref_src=twsrc%5Etfw">March 9, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
