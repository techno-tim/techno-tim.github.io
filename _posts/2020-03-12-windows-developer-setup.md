---
layout: post
title: "Setting Up Windows for JavaScript Development THE RIGHT WAY (WSL Terminal NVM Node Yarn VS Code ZSH)"
date: 2020-03-12 09:00:00 -0500
categories: coding
tags: windows coding javascript wsl nvm zsh node windows linux ubuntu
image:
  path: /assets/img/headers/javascript-terminal.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4hvBOoaXqUOg+F9c0mXUobq3ZluItR+xFNxHlrIi2c88iovmK7RXdvI4cCKSBQyyN0ZOhmMqNV0MV/Z+IrUMUqVGtKjLDxeJlHkrwqRcKsKcqMuR0p3lGbnOMPZS6KNeCxOW0q1J1qU8ww1KdP2tSlCSxM44bnl7LllKdP2vPBzlKKcWlFOXMvbz8FvAi/L/wjukNt+Xc1x4xy2OMnb4zVcnqdqgZ6ADivnMHgc3xeDwmL/wBYcXT+tYahiPZrAZVJU/b0o1ORSeETko83LzNK9r2Wx6WLzDK8LisThf7AwtT6tiK1D2n17M4e09jUlT5+T61Ll5uXm5eaXLe13a5//9k=
---

You want to get started developing JavaScript with NodeJS, ReactJS, or AngularJS but you're not sure how to get started?  This is a complete, step by step guide on how to configure your Windows machines for JavaScript development the right way.You'll learn how to install and configure Windows, the new Windows Terminal, WSL, Ubuntu, ZSH with Oh My ZSH, yarn, NPM,  NVM, NodeJS, and VS Code.We'll also configure our git client for SSH access to GitHub.This is the perfect beginner tutorial for anyone trying to develop software on a Windows PC.

{% include embed/youtube.html id='kL8iGErULiw' %}

📺 [Watch Video](https://www.youtube.com/watch?v=kL8iGErULiw)

## Update Ubuntu

```bash
sudo apt-get update
```

```bash
sudo apt-get upgrade
```

## install zshell

```bash
sudo apt-get install zsh
```

## oh-my-zsh

Check this site for the command <https://ohmyz.sh/#install>

It should be something like this:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## nvm

Be sure `zshell` and `oh-my-zsh` are working before continuing

Check this site for the command <https://github.com/nvm-sh/nvm>

It should be something like this, but be sure to use the version from the link above

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

If `nvm` doesn't work, check this <https://youtu.be/kL8iGErULiw?t=507>

Close all terminals and all VS Code instances after doing this step

## Install Node

```bash
nvm install 12.16.1
```

## Install yarn

Be sure `nvm` and `node` are working before continuing

Check this site for the latest command <https://classic.yarnpkg.com/en/docs/install/#alternatives-stable>

It should be something like this, but be sure to use the version from the link above

```bash
curl -o- -L https://yarnpkg.com/install.sh | bash
```

## Configure Git

You'll want to follow this guide for configuring git.Be sure to follow the `LINUX` version

<https://docs.github.com/en/github/using-git/getting-started-with-git-and-github>

```bash
git config --global user.name "Techno Tim"
```

```bash
git config --global user.email "your_email@example.com"
```

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

```bash
eval $(ssh-agent -s)
```

## Cloning a repo

```bash
mkdir code && cd code
```

Be sure you choose the right repo before cloning, this is just an example

```bash
git clone git@github.com:techno-tim/techno-boto-discord.git
```

```bash
cd techno-boto-discord
```

```bash
yarn
```

## Continuing with the bot turotials

* Discord Bot <https://www.youtube.com/watch?v=YSZcyz2-twQ>
* Twitch Bot <https://www.youtube.com/watch?v=7uSjKbAUHXg>
* Slack Bot <https://www.youtube.com/watch?v=AajBk59nOgw>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
