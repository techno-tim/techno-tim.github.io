---
layout: post
title: "100 Days of HomeLab - 1 Year Later"
date: 2023-06-20 10:00:00 -0500
categories: homelab
tags: homelab
image:
  path: /assets/img/headers/homelab-rocket-servers.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APsv/gml/wAElP2dfj7+xV8Hfi5Ndah4Ul8d+C9E8P694Pg0Lwzr3hnU5f8Ahauu6Rqmsat/aenx6teahqlnplpa+bZ6jpclhZQxwWcyXCm8bXjLx045yji3G5PkFLhzLsl4XrZFg45fXynE4z+0v7ShSliquNq080wcZSnHESgo+wlpCHM5Jcp+bcHeCXBOdcK1M34qxPFedZ/xbHP8yecYXPqWVVsijgYSp5bhMipLLMasJSwtTBLETlVnXliK9evJqmpRjH+PX4j/AA8+EujfEPx7pFn8OtPWz0rxp4o020U6hMCttY65fWsCkLbqoIiiUfKAPQAcV+uYTiClmGFw2Plk+ApSx2Ho4yVKCk4U3iacazpxdleMHPli7LRLRHy1XIMywFWpgVxLmVZYKpPCKtUhS9pVWGk6KqVLO3PUUOaX95s//9k=
---

A year ago I started a challenge that encouraged everyone to join the [#100DaysOfHomeLab challenge](/posts/100-days-of-homelab), a challenge designed to help improve your skills in IT. This is similar to any of the "100 Days" challenges - pick a topic, stick with it for 100 days, and form a habit. Some of you might be asking what a "HomeLab" is, and I think in it's simplest terms it's a "lab environment" mostly at home. Think of this as a test environment to learn about technology without the fear of breaking anything. If you'd like to learn more about HomeLabs and how to get started, I [summarized it in a video](https://www.youtube.com/watch?v=gPGf4Y8nQqM).

After creating the challenge, I had lots of folks join in on [Twitter](https://twitter.com/hashtag/100daysofhomelab), [Mastodon](https://mastodon.social/tags/100daysofhomelab), [YouTube](https://www.youtube.com/hashtag/100daysofhomelab), [Instagram](https://www.instagram.com/explore/tags/100daysofhomelab/) and many other social networks using the hashtag `#100DaysOfHomeLab`, and it's still going today!

## 365 Days of HomeLab

I ended up sticking with it, posting on socials (when I remembered), and took it all the way to 1 year! While some posts seemed redundant and repetitive, I kept on building, breaking, learning, and posting. Once I hit 100 Days, I decided to see how long I could go. 100 days turned into 200 days, and 200 days turned into 300... and today I hit 365 days. Looking back at my very first tweet, it seems I missed a few days of sharing, or I am really bad at math. If you can spot where I missed or messed up, let me me know in the comments below! 😀

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">OK, my turn 😀<br><br>Day 1 <a href="https://twitter.com/hashtag/100DaysOfHomeLab?src=hash&amp;ref_src=twsrc%5Etfw">#100DaysOfHomeLab</a> <br><br>Since Day 0 was spent launching the video, planning, connecting with people, and celebrating 100k - today will be spent:<br><br>Operationalizing the self-hosted website &amp; Bot <a href="https://t.co/5EObleZiAV">pic.twitter.com/5EObleZiAV</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1536007162840944640?ref_src=twsrc%5Etfw">June 12, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## So what did you learn?

Over the last year I learned so much about HomeLabbing, but specifically Docker, Kubernetes, networking, ZFS, GitOps, and many other related technologies. You can see all of my [100 Days of HomeLab tweets here](<https://twitter.com/search?q=(%23100daysofhomelab)%20(from%3Atechnotimlive)%20-filter%3Areplies&src=typed_query&f=live>) however I will summarize some of the topics.

## Bots & Website

I started out by creating a [Twitter bot](https://twitter.com/100DaysHomeLab) that would retweet everyone who was joining the challenge. I felt like this was important to build and grow a community around HomeLab and a simple way to bringing people together. This is a self-hosted bot that I wrote myself, and even [open sourced the code](https://github.com/techno-tim/techno-boto-twitter)!

I also decided to create a [100 Days of HomeLab website](https://100daysofhomelab.com/) so people could learn more about the challenge and even showcase some of the creators I worked with to make this possible. Huge thanks to all creators, featured on this page or not, who joined in on the fun!

## What not to do

Another bucket of learnings were what not to do. This can be seen as mistakes but I looked at them as opportunities. These were things like:

- Backup everything you can't recreate (even if you think you don't need it)
- Test your backups
- Don't run beta firmware in production
- Don't run early access firmware in production (I had to list this twice in case I think about it again)
- Don't deploy and walk away (for hours)
- Try not to test in production (although sometimes there isn't any way around it)
- Don't over buy or over build hardware, unless you think you can repurpose or sell it easily in the future
- You may not always need the fastest connection like 10G (things will just take a little longer)
- Don't delete CRDs in k8s unless you are certain you don't need any of the resources

## What to do

It wasn't all bad, I also picked up some good habits and learned what I should continue doing in the future:

- Build a small test environment, even if it's hard
- Create good documentation and write it as if someone other than yourself will have to follow the steps
- Write tests, when you can, even even when you think you can't
- Have just enough hardware, repurpose what you can
- A little battery backup goes a long way
- Use DNS when possible (even if it's painful)
- Use certificates, always
- Use strong randomized passwords
- Set up monitoring & alerting, even if it's just to yourself!
- Keep it simple. Seems like an oxymoron for HomeLab, but the simpler you keep it, the easier it will be to support

## Hardware

I made lots of changes to my HomeLab over the past year, from a pile of machines on a shelf, to an open post rack, to a [fully enclosed server rack in a room I converted to a server room](https://www.youtube.com/watch?v=dzh3so5wOro). With this came new challenges like networking, power, and even RGB. I was sent a [Storinator from 45 Drives](https://www.youtube.com/watch?v=yqiCsSNpwjQ) and really expanded my storage while deprecating my old Disk Shelf. I also picked up a handful of low power devices and built a small low power cluster of Intel NUCs and rack mounted them in my server rack!

## Automation

I also got to dive into [Ansible](https://www.ansible.com/) deeper than ever before! Ansible is a powerful tool for automating things, especially infrastructure. I automated things like updates, configuration of my machines, password changes, and even building a fully [HA Kubernetes cluster with k3s](https://github.com/techno-tim/k3s-ansible). The time spent learning this tool has already paid back in dividends compared to the time I would put into doing these task manually or even worse, pile up tech debt because I would skip them.

I also picked up [Terraform too](https://www.terraform.io/)! Terraform is one of those things you may not ever learn until you need to. It's definitely been eye opening building up new infrastructure with Terraform. Every time I see a form or a UI to create some sort of Infra, I automatically think about how I can automate this with Terraform... but thinking and doing are two different things and I need to start doing this more often. I've already figured out how to apply [Terraform to Cloudflare DNS](https://www.youtube.com/watch?v=FmYvrxYvBP0) and will be applying to more systems in the future.

## Networking

Once of the biggest changes to networking wasn't new hardware or network speed, but VLANs. I implemented VLANs here to keep all of my network traffic segmented according to the roles these devices fill. For instance I created an `IoT` vlan for all of my IoT devices, a `Camera` VLAN just for secure video devices, and `Server` VLAN for my servers that are used for public facing services. This helps ensure that not only am I not mixing traffic, but also minimizing the blast radius if one of my devices were to become compromised. I talked about this and more [security recommendations in a video here](https://www.youtube.com/watch?v=Cs8yOmTJNYQ). Highly recommended if you are going to self-host anything.

## Kubernetes

The next big theme is Kubernetes and has been a theme on my channel almost since the beginning. I now run 3 HA Kubernetes clusters at home. That might sound crazy, but it's true. It's taught me so much about how to build, support, and maintain one of the most popular technologies in the world. It's been challenging but rewarding at the same time. I ended up going all in and migrating all of my Docker only hosts to Kubernetes. I no longer have single Docker hosts (pets) and now have more Kubernetes nodes (cattle). Once I moved everything to Kubernetes, I quickly learned that I needed a better way to manage it than just a UI or applying manifests from the CLI.

(_GitOps has entered the chat_)

## GitOps

Git Ops, such a such a huge term and people have varying opinions on where it starts and where it ends - but it's the idea that Git is the source of truth to deliver infrastructure as code. What does that mean for me and in my HomeLab? For me it means that my Kubernetes cluster (and custom code) is source controlled in Git and the only way to get those changes applied is through CI. This was one of the most rewarding things I have learned about during my 100 Days of HomeLab. All 3 of my Kubernetes clusters are defined in code (YAML) in a Git repository and when I need to make changes I just commit them to my repo and push them up and [FLUX takes care of the rest](/posts/flux-devops-gitops/). It has not only taught me how to deliver infrastructure as code but also taught me about [secret management with SOPS](/posts/secret-encryption-sops/) which is such a valuable lesson, Kubernetes or not. I will be looking to expand into more IaC this year and beyond because this is truly the future of infrastructure.

## Community

Last but definitely not least is community. Doing this challenge has taught me that there are so many other people out there just like me, trying to build/break/fix/learn with a lab environment at home. There are countless times where I have been inspired from others or even found better, more efficient way to accomplish things by interacting with the HomeLab community. I have even picked up new tech all thanks to you. I have met lots of people on socials and will continue to follow your journey!

So, what are you waiting for? Want to [join the 100 Days of HomeLab Challenge](https://twitter.com/intent/tweet?text=I%27m%20publicly%20committing%20to%20the%20100DaysOfHomeLab%20Challenge%20starting%20today!%20Join%20me!&url=https%3A%2F%2F100daysofhomelab.com&hashtags=100DaysOfHomeLab)? You're just one click away!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Day 365 <a href="https://twitter.com/hashtag/100daysofhomelab?src=hash&amp;ref_src=twsrc%5Etfw">#100daysofhomelab</a> <br><br>One year. It&#39;s been a year since I have started the 100 days of <a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> and I&#39;ve learned a lot. Here are my learnings in a thread 🧵</p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1671261492392648709?ref_src=twsrc%5Etfw">June 20, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
