---
layout: post
title: "PiKVM with TESmart KVM Fixed!"
date: 2024-01-19 08:00:00 -0500
categories: homelab
tags: homelab hardware pikvm tesmart
image:
 path: /assets/img/headers/pikvm-v4-tesmart-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5dv2F7zwz8dvCXhn9lfx38IvhF4p8O33iz4keIdK8ceLrX4s3fjbwn4h134ZeHfD8+reHG8EfGL4d+Hg+nW/hrQdU0mz13QtcsG13Tln1+38QaNI+g1w5hmlXDUneEaqp+zVOLaiotv2d37sm7KKuk4320O/LcppYyqrVJUnOVX2jtzuShF1rR96Cim5NK6lZu+uqf5mav4Nt7XVtUtorry4rfUb2COOOB/LSOK5ljRE866nm2KqhV82eaXaB5ksjZc9EajaTstUn96OWVO0mr7Nrbs/U//9k=
---

After many hours and testing, swapping, resetting, and EDID training, all of my PiKVM and TESmart issues were solved with with a simple, cheap dongle.  If you aren't aware of the struggles I faced when using the PiKVM with a TESmart switch, all of it is detailed [in a previous post](/posts/pikvm-at-scale/) where I ended up settling on another switch altogether. That's all changed now with a simple [EDID emulator passthrough adapter](https://amzn.to/3tQp04Z)  (affiliate link).  However, for the uninformed, I'll summarize the symptoms I experienced with the PiKVM and TESmart KVM and how I was able to fix these issues.

## My Experience

When I originally set up my PiKVM (v3 at the time) I wanted to remote control more than one machine.  I have a server rack and I rationalized that 8 would be a good number of machines to remote control and ultimately justify the cost of the hardware (cost spread over 8 machines).  I also wanted something to rackmount since, after all, I have a server rack.  That's when I found the [TESmart 8X1 HDMI KVM Switch 8](https://amzn.to/425zhqs) (affiliate link).  

It met all of my requirements:

- 8 ports
- Rackmountable
- Compatible with PiKVM (or so I thought)

This device was [listed as compatible with PiKVM](https://docs.pikvm.org/multiport/#list-of-tested-kvms) so I thought it was a safe bet.

I have (3) Intel NUC 11th Gen device I planned on connecting to this switch along with an old PC that has a ASUS Z87-PRO motherboard.  I figured since they were all Intel based GPUs it was a safe bet.  Boy was I wrong...

Shortly after configuring the PiKVM with the TESmart KVM and my devices it was clear that something was definitely wrong.

![PiKVM Issues with TESmart](/assets/img/posts/pikvm-v4-tesmart-4.gif){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APsv4Y/GH4E/Cbw/pPh7w98C/iXL4Y0mzuLXxVHon7Ot5eSt4iSC1igutLhbVLBfEWnXskPiZv7btnjOmR3OliOJjd24h8Gi8DhVThSwVOnT9nJVPZYaK998ji0oqN4y/eXt1tfdMKi9s5zqSVSo2mpVE5SbfM5SlJt32hpdN66vS3yB4z/Z28Za94w8V65o2talBo+s+Jdd1XSYLnxf4j0u5h03UdUuryxiuNM0/wASCw06eO1miSWxsQLO0kDW9sBDGld3PgHq6Wr1d42169DypYXE80uWUeXmdvh2vp07H//Z" }
_As you can see, 1 out of 3 devices work.  All 3 are the same model.  Usually none of them work even after properly training them._

Some of the symptoms were:

- Black screen without any video
- When switching machines, you see video but quickly goes to black
- When switching to some devices, you see a green screen
- While getting a green screen, the CPU spikes on the PiKVM to where you have to reboot

## Things I tried

I knew this was not good, however I figured it was something that could be fixed in software, after all the PiKVM is [open source and running Linux](https://github.com/pikvm/pikvm). I did the obvious first, which was [training the PiKVM and the TESmart switch](https://www.youtube.com/watch?v=w56QCshaiNQ&t=1001s) according to TESmart's YouTube video (which is excellent by the way).  This kind of helped and by kind of I mean that 1 device would __sometimes__ work but then after adding additional devices it would start experiencing the same symptoms as above.  So I thought I could fix it in software...

I tried updating the device, testing different [EDIDs](https://docs.pikvm.org/edid/),and even working with the creator of the PiKVM, [Max Devaev](https://github.com/mdevaev), to see if we could tweak any settings to make it work with the TESmart KVM. After capturing logs and EDIDs, Max determined that the EDID was getting "poisoned" with some other EDID when switching. So we decided that it was a hardware issue.  I ended up purchasing an [EZCOO switch](https://amzn.to/3IyiIv1) (affiliate link) which ended up working perfectly, albeit not rackmountable.

I reached out to TESmart around the same time to see if maybe it was something they had experience in the past, or something that might be addressed in a firmware update. They were great to work with (huge shout out to Ray from TESmart!) and walked me though some additional troubleshooting steps. Each step still yielded the same results. When we exhausted everything we could try, they sent a replacement to see if that might resolve the issue, but sadly it did not.

## PiKVM v4 and More

All of this troubleshooting was done on the PiKVM v3, which I had purchased pretty late in its lifecycle, and v4 was right around the corner.  Max from PiKVM said that he felt the issue could be resolved in their v4 model and mentioned he would send one when it launched.  I was hopeful that this work.  A few months later, the [PiKVM v4 Plus](https://pikvm.org/) arrived on my doorstep.

![PiKVM v4](/assets/img/posts/pikvm-v4-tesmart-1.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APsv4Y/GH4E/Cbw/pPh7w98C/iXL4Y0mzuLXxVHon7Ot5eSt4iSC1igutLhbVLBfEWnXskPiZv7btnjOmR3OliOJjd24h8Gi8DhVThSwVOnT9nJVPZYaK998ji0oqN4y/eXt1tfdMKi9s5zqSVSo2mpVE5SbfM5SlJt32hpdN66vS3yB4z/Z28Za94w8V65o2talBo+s+Jdd1XSYLnxf4j0u5h03UdUuryxiuNM0/wASCw06eO1miSWxsQLO0kDW9sBDGld3PgHq6Wr1d42169DypYXE80uWUeXmdvh2vp07H//Z" }
_PiKVM v4 Plus & PiKVM v4 Mini_

After receiving the PiKVM v4 and hooking it up to the TESmart switch I found that I had the same issue as before.  This told me it was most likely something with the TESmart switch.  I reached out to them again after discovering that I had the 4k 30 fps model and hoped that the 4k 60 fps model would make a difference, after all there were some people who said theirs worked just fine and internet rumors that the 60 fps model worked better.

I talked to TESmart again and they shipped a replacement, this time the 4k 60 fps model.  I quickly hooked it up and once again experienced all of the same symptoms.  I was really puzzled as to why this was happening to me when it works fine with other switches and others claimed to use this switch fine.

## Community to the Rescue!

After testing all of this, I was convinced that I would never be able to use my rackmount KVM. I have to admit that I wasn't that upset that it didn't work, I was more upset that I didn't know when to quit.  I was frustrated that I sunk over 80 hours of my time trying to fix this when in fact there was no fix.  Sometimes you gotta just let go...  

That's when I got lucky and someone posted a comment on my [previous post](/posts/pikvm-at-scale/#links) with something new to try.  The comment from [juristoeckli](https://github.com/juristoeckli) that mentioned something about an "EDID Emulator".  I had never heard of these before nor was I sure that this was the issue. Then [NateDiTo](https://github.com/NateDiTo) also left a comment about how they had used these [EDID emulators](https://amzn.to/47MUtCO) (affiliate link) and they worked for them. Finally, I wasn't alone!  Someone else who was experiencing the same thing or at least knew my struggle!

That's when I decided to give it a shot.  I told myself "If these don't work, I am giving up!" and I meant it this time (maybe... 😂).

![EDID Emulator](/assets/img/posts/pikvm-v4-tesmart-2.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APsXw14X/af179q/4cal4I+J/wAOtO/Zov8AwlLo/wATfBPiqxH9taZrdjJqsv2zwtd2cNudSv8AxRBq+lxSjUNRt7XQB4cjkt4L63u7vSNZ48PiJVZOMkk7XXRWXZdX3f6Kyell3v8A5f0v0PojWvCHgW21nVrebRPBU01vqd/DLM2j6Y7SyxXUsckhc6S5YuylixdyxOdzZyewmy7L7kf/2Q==" }
_This little device will override your EDID possibly making it compatible with the device it's connecting to._

## How I fixed it

I purchased a cheaper version of the [EDID emulator](https://amzn.to/3tQp04Z) (affiliate link) hoping they would work.  Also, serendipitously, Ray from TESmart had mentioned an EDID emulator in an email that same night.  He mentioned this as a last resort, however in my mind this was my last resort.  After the devices arrived, I quickly inserted the emulators into the TESmart and connected my machines to them.  

![EDID Emulator with TESmart](/assets/img/posts/pikvm-v4-tesmart-3.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APEPGvx81Cz1Gf4n/B/xB4Q+HOtfEWK/8LaVpPiOPVNe1ebVNKs9Q8JzWGleJ18YSeKdMthD4tl0LSdXm1q8ttPS9n1jT9OibT/sFhlGtjVRnhZSrzwcKrxM4QnJUuZezj7WpRg4wnNOEIxlKOnuxVru+c6VCNeNdU6H1h0YU41HGDqeynGVSMIzfNOMWpzk4xdm+Zq9ly+l2/x7/a20y3g02O90IR6fDFYoJP2k/wBo5pAloi26hzbfEJLcuFjG4wIsJOTEqptAzdGi23bd3+x1166/fr3OpOH80vkn/mf/2Q==" }
_I plugged them directly into the TESmart switch and all devices started working immediately!_

I retrained the devices per the video, and sure enough after powering the first one one it worked!  I could see my machine in the PiKVM without issues!  I quickly tempered my expectations because I have been here before. One device would sometimes work fine, but never more than one.  Sure enough after training the next 2 devices it worked fine.  I could now control all 3 devices from the PiKVM with the TESmart KVM switch.  I tested by rebooting the devices and even the PiKVM and everything still works! They now work as reliably as they did with the EZCOO switch.

## So why does this work?

When I think about the solution, it's challenging to know how and why this is working.  As I understand it, EDID emulators are meant to override a device's EDID, basically telling the connected device which capabilities it supports.  You would think that my devices were sending the proper EDID to the TESmart switch, however as I experienced with 4 devices (2 unique), this was not the case.  

Some people have mentioned that this happens more often when running Linux, and I even experienced that myself too. When one of my Intel NUCs was running Windows it seemed to work fine but when running Proxmox (Debian Linux) it seemed to experience these issues.  This could be a Windows vs. Linux issue, or it could be chalked up to my other experience where 1 device would work fine but none of the others.  I've tested quite a bit over the span of a year and it's challenging to know for sure.  Oddly enough, this doesn't happen to everyone who uses TESmart switches.  I do think it's a combination of TESmart + Device + OS/driver that triggers the problem, because again, it works with my with EZCOO switch.  I also have a hunch that these emulators might be instructing the device's GPU to stay powered on even when a device isn't plugged into it (just like HDMI dummy plugs), however I don't know if that's true.  If you know, let me know in the comments below!

I am considering this "fixed" now even though technically this is a "workaround."  A huge thanks to Max from PiKVM, Ray from TESmart (and the TESmart team), and juristoeckli and NateDiTo in the comments because without all of you I would have given up.  Each new idea or additional troubleshooting step motivated me to keep going.  I can finally use this switch and recommend it to those who want something rackmountable (with workarounds).

## Config

Here is the configuration I use:

`/etc/kvmd/override.yaml`

```yaml
# /etc/kvmd/override.yaml.bak.tesmart
####################################################################
#                                                                  #
# Override Pi-KVM system settings. This file uses the YAML syntax. #
#                                                                  #
#    https://github.com/pikvm/pikvm/blob/master/pages/config.md    #
#                                                                  #
# All overridden parameters will be applied AFTER other configs    #
# and "!include" directives and BEFORE validation.                 #
# Not: Sections should be combined under shared keys.              #
#                                                                  #
####################################################################

kvmd:
  gpio:
    drivers:
      tes:
        type: tesmart
        host: 192.168.20.63
        port: 5000
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
        mac: 3c:ec:ef:0e:d3:a4
      wol_server3a:
        type: wol
        mac: 3c:ec:ef:0e:d3:a5
      wol_server4:
        type: wol
        mac: 3c:ec:ef:90:c8:0c
      wol_server4a:
        type: wol
        mac: 3c:ec:ef:90:c8:0d
      reboot:
        type: cmd
        cmd: [/usr/bin/sudo, reboot]
      restart_service:
        type: cmd
        cmd: [/usr/bin/sudo, systemctl, restart, kvmd]
    scheme:
      ch0_led:
        driver: tes
        pin: 0
        mode: input
      ch1_led:
        driver: tes
        pin: 1
        mode: input
      ch2_led:
        driver: tes
        pin: 2
        mode: input
      ch3_led:
        driver: tes
        pin: 3
        mode: input
      ch4_led:
        driver: tes
        pin: 4
        mode: input
      pikvm_led:
        pin: 0
        mode: input
      ch0_button:
        driver: tes
        pin: 0
        mode: output
        switch: false
      ch1_button:
        driver: tes
        pin: 1
        mode: output
        switch: false
      ch2_button:
        driver: tes
        pin: 2
        mode: output
        switch: false
      ch3_button:
        driver: tes
        pin: 3
        mode: output
        switch: false
      ch4_button:
        driver: tes
        pin: 4
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
      wol_server4:
        driver: wol_server4
        pin: 0
        mode: output
        switch: false
      wol_server4a:
        driver: wol_server4a
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
        - ["#HL15", ch3_led, ch3_button, "wol_server3 | WoL-10g", "wol_server3a | WoL-10g"]
        - ["#Storinator", ch4_led, ch4_button, "wol_server4 | WoL-10g", "wol_server4a | WoL-10g"]
        - ["#PiKVM", "pikvm_led|green", "restart_service_button|confirm|Service", "reboot_button|confirm|Reboot"]
```

edit `/etc/sudoers.d/99_kvmd`

add to the end:

```bash
kvmd ALL=(ALL) NOPASSWD: /usr/bin/reboot
kvmd ALL=(ALL) NOPASSWD: /usr/bin/systemctl
```

Then reboot or restart services.

## Where to Buy

Here are the items that I used during this project.

- PiKVM - <https://pikvm.org>
- TESmart Switch - <https://amzn.to/3YV0Gsi>
- TESmart Switch (buy direct, usually cheaper) - <https://l.technotim.live/tesmart>
- HDMI Cables - <https://amzn.to/3SgJ34g>
- USB B Cables - <https://amzn.to/3Eel0wU>
- EDID emulator (the ones I use) - <https://amzn.to/3tQp04Z>
- EDID emulators (3 pack recommended by the community) - <https://amzn.to/47MUtCO>
- VGA to HDMI Adapter (great for connecting VGA devices to a PiKVM) - <https://amzn.to/491uAAo>
- Intel NUC 11 kit - <https://amzn.to/3vRDAJK>

(Affiliate links may be included. I may receive a small commission at no cost to you.)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">All the problems I had with the PiKVM and TESmart KVM switch were fixed with this one cheap little device.<a href="https://t.co/yOGjQTywYy">https://t.co/yOGjQTywYy</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1748480321060733110?ref_src=twsrc%5Etfw">January 19, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
