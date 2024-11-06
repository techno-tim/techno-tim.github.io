---
layout: post
title: "Proxmox Automation with Proxmox Helper Scripts!"
date: 2024-05-30 08:00:00 -0500
categories: proxmox
tags: proxmox homelab lxc docker virtualization
image:
 path: /assets/img/headers/proxmox-helper-scripts-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOP/AGR/ENlbfstaxdr4O8EXms6Pa6obTX9b8MaV4g1RAZ4ZTHG2sW93ZwxCO4+zKsdoD5Rn8xpXlie2/orPIVP9ZKVL6zi40K86KnRo4qvQh7yt/wAuakJP791G1kmn/P8AlcqcuGJzeHw8qsKdRRq1aFGtNWUnoq1OcLq3u+7aN3o9DwOXxNMksiCw04hJHXLWls7HaxGWd4GdmOMlnZmY8sxJJr61UFJJ89RXSdueWl9e6/JHzFLMKrpUmqWF1pwfvYTDTesVvKVJyk+8pNuT1erP/9k=
---

Proxmox helper scripts is a collection of scripts to help you easily make changes to your Proxmox  VE server along with installing many LXC Containers.  This makes installing, configuring, and maintaining your Proxmox server in your HomeLab along with many applications as simple as running a script.

{% include embed/youtube.html id='kcpu4z5eSEU' %}
📺 [Watch Video](https://www.youtube.com/watch?v=kcpu4z5eSEU)

> *Note: [ttek](https://github.com/tteck) who created the scripts initially is no longer able to maintain these scripts due to health issues.  We thank [ttek](https://github.com/tteck) for his contributions and wish him the best.  He has turned it over the the community and links in this post were updated to reflect the community version*
{: .prompt-info }

Check out Proxmox VE Helper Scripts on Github: <https://github.com/community-scripts/ProxmoxVE>

- This is the new community version of the repo

## Disclosures

- Nothing in this video was sponsored

## Notes

> *Note: Be sure to always inspect any script before executing it, whether local or from the internet!*
{: .prompt-warning }

You can find the website here: <https://community-scripts.github.io/Proxmox/scripts>

- This is the new community version of the site

If you want to execute scripts from a commit SHA (somewhat immutable), you can execute the script like so (commit SHA of the date this video was released):

- Visit the link with a commit hash <https://github.com/community-scripts/ProxmoxVE/blob/a4a1821822f0f00fde56bc9b1ebe7204f5e01c08>
  - This is the new community version of the repo
- Find your script (`homeassistant-core-install.sh`) choose the RAW option
- This will create a link like <https://raw.githubusercontent.com/community-scripts/ProxmoxVE/a4a1821822f0f00fde56bc9b1ebe7204f5e01c08/install/homeassistant-core-install.sh>

You can now use this hash to execute this script.  This will ensure that you can run this repeatable (and not always latest)

```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/community-scripts/ProxmoxVE/a4a1821822f0f00fde56bc9b1ebe7204f5e01c08/install/homeassistant-core-install.sh)"
```

You can reuse this commit SHA for all other scripts (just replace the path)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">This past week I got to learn all about Proxmox Helper Scripts, a wonderful collection of scripts to help you automate common tasks with Proxmox along with LXC container installs!<a href="https://t.co/CRuExA8Ik2">https://t.co/CRuExA8Ik2</a> <a href="https://t.co/1u1JRWGEav">pic.twitter.com/1u1JRWGEav</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1796217587526778897?ref_src=twsrc%5Etfw">May 30, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
