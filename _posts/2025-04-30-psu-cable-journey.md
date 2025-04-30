---
layout: post
title: "Swapping PSUs: From Corsair to Seasonic (and the Molex Mayhem That Followed)"
date: 2025-04-30 08:00:00 -0500
categories: homelab
tags: homelab hardware hl15 45drives seasonic noctua
image:
 path: /assets/img/headers/psu-cable-journey-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APB2/ZX+Euga1c3TX3xR/wCEj/aAm8Wf8JzLovj9NE8IahrGkaD4n1+W91Twq3h7U9T1rTNffV4bTxFo134tT7Xa6bBbabqGkWEstjXzePwUMVi061SXNhsTXq0XCFJctWvjVWnJc9OpKNpVJ8vJKDXM3zOXK48OQTp5RldVqhTxLmsLTryqOcHXpt4mChU5ZOMlas+dTjOD5eWEKdNuB8vWH/BILXvsNn9m/bF+Iul2/wBkt/s+maX4F0uPTNOh8lPKsdOTUfFWqaglhaR7bezS/wBT1G8W3jjF1fXc4e4k4ZQxylJe0y2Vm1zVMBjeeVnbmn7LOKNLne8vZ0aVO9+SnCNor6GXE0uaXLh60I8z5YKvhJqEb6RU62WVaslFaKVWpUqSSvOc5Nyf/9k=
---

When I first got my [HL15](https://45homelab.com/) from 45Drives, I knew it was going to be a long-term part of my homelab. What I didn’t expect was how tricky it would be to swap out the PSU — specifically replacing the stock Corsair one with the [Seasonic TX-1600 Noctua Edition](https://seasonic.com/product/prime-tx-1600-noctua-edition/). Spoiler: the PSU swap itself was the easy part.

## The Power Breakout Board

The HL15 includes a breakout board that distributes power to the fans and the backplane using four 4-pin Molex connectors, but here's the catch - the 6-pin-to-Molex power cables that 45Drives includes are **custom-made for Corsair PSUs**. They don’t work with Seasonic’s modular pin-out or any other brand for that matter.  This is common practice among all power supply makers and something I didn't even think about when starting this swap.

![HL15 Power Breakout Board](/assets/img/posts/45drives-power-breakout.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APdtT+K123iqKXw/rPw7v/BzfY4ZpbzVdLTUoIHitnv7+xuB4w0uQXccpuoY4b7SLu2Cxq4huN6bfzvIqnCawWMnnlfF/wBo16eJp4WnSw2IlSwkuRfVsTGrQxFGE6jquXPTrU69KNNXdOUpNR4uPcZ9I6hx7haPAXD3CuO8O6ayWVXEY7GZfRzXETdZPO6deWMzOjVpUFRk6VD6rgXWpun7aE8Q5vDv1UeO/AcgDr4x8KsHAcN/bWn/ADBuQf8AXdwc188sXGy1jst27/PzP394en/Kf//Z" }
_HL15 power breakout board_

Since I had already replaced all the fans and wired them directly to my SuperMicro motherboard (which gave me full PWM control), I figured I could skip the breakout board and wire the backplane directly.

## The Molex Nightmare

Seasonic only includes **one** 6-pin to 4-pin Molex cable, and I needed four. Worse, the backplane is powered entirely via Molex, the same old 4-pin IDE-style connectors that IDE drive used (which no one has by the way). I wonder why they have not switched SATA power. It’s more available, and the cables are far more suited for the tight spacing underneath the HL15's backplane.  I'm assuming it's just a design that dates back to when it was first designed for servers.  Also, since they own the design for the backplane they can also design any cables they want.

![HL15 Power Breakout Cables](/assets/img/posts/45drives-power-breakout-cables.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAA0ACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APBf2QP2o/h34H/aGGk3fwm/Zn8D2uo+BxBbeMvhVfa3rcEF1fJZmOe/8fx6JFb6Dpd1rMy+Fda0G48MQarDrHM93LZ6TuuPhc+xOIrZNUxmXYvGRqVcVSpUaGbV8RKkpU5VFiFJUliuRezjUxFGpGDpqnTgqk4xnKrD7nJMiq1s3eX1cGpSw+Gr4rETwMMPGrGk/ZLDcn1p4BSc6tSlQ5JVVUrVK0VQpSqezpVfSdb079v2PWdXjv5fhNeXyapfpe3cXxK8OJHdXa3cq3FzGln4wsLREnmDyotrY2VsqsBBaW0QWFPIlmfDdOUoVMdWp1IScJw9lip8k4u0oc8cBOMuWSa5ozmpWupSTu+6OQ5pJKUacJRkk4ylTdOUotXTlTlWjKDa1cJRjKL0cU1Y8U/Zy/ZS8M/Fz4feML++vNC8L6e/gfSvFlnpnhfwgLRoJdE8T/2k2n31xea/e22tQXVla3umJe6lps2q2TXdtqkN82o6eJrr9Px+HoYvLM0hVpRj9Ww7rUZUVGnKlPlmnKnLlcoz5ZSUZtylFyctbtH41wFieI8PmWAz2pxDUr0sxrcryn6hhqOBhShWo1IUq0qcliMbGXs4xrrE1ZxmrOhHCyUWvqXS/jodH0zTtIk+HvgXWJNKsLTTZNX1jQ9LvtX1R7G3jtW1HVb2XTTLealfNEbm+upCZLi5lllclnNfzbiuH6c8TiJ/W63vV60tYxb96pJ6tOKb11ajFdktj+1aHEFqFFPLsK2qVNNqVXVqCV9ZSf3yk+7b1P8A/9k=" }
_HL15 power breakout cables for fans and backplane_

## The Cable Search

I searched for Seasonic compatible 6-pin to Molex cables. No luck.

- **Seasonic** pointed me to [BTOS Integration](https://btosinte.com/), who doesn't make or sell these cables.
- **Noctua**, despite collaborating on the PSU, had no cable leads (pun intended).
- **[CableMod](https://cablemod.com/)** couldn’t offer right-angle Molex ends that would clear the space under the backplane.
- **[ModDIY](https://www.moddiy.com/)** *could* make custom right-angle Molex cables but at ~$30 each after customizing the length. I needed 8 cables (2 servers), which would run nearly **$300** with shipping. Not the end of the world, but I wanted to shop around before shelling out this kind of money for cables.

I then contact **45Drives** directly since they made the original cables for Corsair PSUs, I hoped they’d offer ones for Seasonic too. I thought they might be interested since they have partnered with Noctua on fans and might sell this PSU at some point. Unfortunately they could not make them. They suggested I contact CableMod, which I already did, so the cable hunt continues.

At this point I was running [SATA-to-Molex adapters](https://amzn.to/3Yo2UTr) (affiliate link) as a temporary workaround, creating a rat's nest of cables.

## A Needle in the Haystack

After scouring eBay, Amazon, and finally AliExpress, I found a set of cables that looked promising,  a 6-pin power to 3x 4-pin Molex (IDE) right-angle power cable that is supposedly compatible with Seasonic power supplies. The listing is now gone, but [here’s the archived product](https://www.aliexpress.com/item/3256803054611474.html?spm=a2g0o.order_list.order_list_main.5.69481802JPp5Jo).

I ordered **9 cables** ($3.56 each—one spare) and waited.

!["Seasonic Compatible 6-pin to Molex Cables](/assets/img/posts/seasonic-6pin-4pin-molex.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAA0ACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APgvx38TP2gfgz41+O2o+CfiR8S/DHi2K81ux8J6N4A8d6xa3kWjwW1n4gk8F/E/wxD4bv8A+2NCksfsulz3d9PoEdn4ku5xJJHBDIJfjY53lmY46P8AZdeU8JmFOslWqKUaFb6xisRRo/VZyxFLkqJqMlehVnVoun7JL2kL/dvgPivI8rqT4gw0cNi8tryqYvAxTnisFChh8PiY08bCjTxCqP6tW9jVqQrU8PSxdPERxFSM4Tp0+hh/bp0eKGKK68aftxQXUcUcdzBY6hr6WMM6IFmis0j+JqxraxyBkt1jVUWEIEUKAK+uhQyiEIQlhcNJxjGLlKnRcpOKSbk5Pmcm1duWrer1PiqtTM6lSpUUpQVSc5qFOm404qcnJRhGCcIwje0YwbiopKLtY/Wj4v8AwD0C61Ga90vVr3Q3+IHxo8N6T4yENnY6vJrN54s0DT75dQju/EMerXmi22lafY2WlR6L4fn0rTtQW0hvNRSeddp/GfB7IqOKyjBcQY2vUxOLw9Stg8vpcsaVHBYWFWtVceWm08VXlWxdeX1nEupUhSdOjS9nGm3L+g/pWZ7nFbPcXwXkmYYjh3B4mngM6z/H4KpOtmHEGZfV8PCisVWrS/2XLKNHAYSE8pwSo4TFzVevjViKtSjLDfmVqn7LWrahqeo37fELwwGvr67vGFx8EPh5fzhrm4kmImvrxZby9mBf95d3UslzcPumnkeV2Y/p8nHmlpP4n/y9l39D+ZaeS5vyQvxLipPkjdvBYbV2V38XV6n/2Q==" }
_"Seasonic compatible" 6-pin to Molex cables_

## Safety First

When the cables arrived, I didn’t plug them in immediately. I needed to make sure the pin-outs matched. I almost fried my PSU and backplane once by using the Corsair cables, I didn't want to do that again.

I posted this question on X:

> "What are the odds that these “Seasonic compatible” power cables fry my server"  

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">What are the odds that these “Seasonic compatible” power cables fry my server <a href="https://t.co/XaDUCvz0dS">pic.twitter.com/XaDUCvz0dS</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1917394681832366267?ref_src=twsrc%5Etfw">April 30, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[*Digital Spaceport*](https://x.com/gospaceport) chimed in with video on how to test cables using a multimeter (thank you!), and five minutes later I had verified the new cable's pin-outs match the OEM Seasonic cables!

!["Toning out the Cables"](/assets/img/posts/toning-out-the-cables.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP2A/Zj/AOFBXn7N/gPTvj/4g1j+0tQ/4qVfBeo+HfFWhPpFrNDax6NBrHhzwvBf28euW6WlnrVuL2ae/wDDOry7PD6aHHY2VrZfAZDmOEyvJ8twyx+Cpf7JSr1lLE0U1icUvrOKbVWSrp+3rVbKulWUWo1f3ik399xvleLnxVneGjTrZhDLMwxeVYfG4B1cdg8Thsvr1MJh6mDxdCk8PiMNKjTgqVbCf7JVivbYZRoVII4y70RrK6ubLwr8U/D8fhi0uJrXw5HqvhXxpc6omg28jRaOmpXI8V2ouNQXT0t1vJxa2wluBJILeHd5a/fUuMMAqVJPN8luqcE+bH4G+kVv+/37+Z+fT4Yx0pzksqzZqU5NWweMSs23ovY7dj//2Q==" }
_Toning out the cables_

## The Final Install

With the pin-outs verified, I tore the HL15 apart again, removed the breakout board, ditched all the adapter cables, and installed the new ones. Each backplane Molex connector now had its own dedicated cable and power lane to the PSU.

!["New Molex Cables"](/assets/img/posts/hl15-new-molex-cables.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APlL9qT9mzxb4/8AjV4n1/Q/Hmhtd6pp/ga0fxx4h8SfB/ULyLxh4It9P8N69qOlXl949uNe0mx1rxPB/YUQTwxFp2qaPfrp1zp8XhrT2v3+SjisFh1l/wBazfB054HCwp4hrE4enSxOIjhoOUq9OL5m414TrQtGCjKzsldPvq1uIHm2a0sv4IzmrluPxsp4bMJVMGqOGwlSU3GGChUxv1qypVY4Sq6uFcpyhdSUZOqfsF4Q+L/idvCfhdr34ay6veN4d0Q3erTfG62il1S5Om2xn1GWKx157GKS9l33Lx2bvao0pW3doQhP5fiuF+E6uJxFV18ki6lerNxed1abTnUlJp01i0oNXtyJJR2SSVj9QoZ3xJToUafscz9ylThpkuEqL3YJaVJYZymtNJyblL4m7s//2Q==" }
_New Molex cables_

I hit the power button… and it worked. No sparks. No dead drives. Just clean direct power.

## Final Thoughts

This whole adventure reaffirmed two things:

1. **Always test your modular cables.** Even if they look the same, they aren’t.
2. **Power supplies should use standardized modular connectors—or none at all.** This halfway point of using identical-looking connectors with proprietary pin-outs is a recipe for disaster.  I feel like it's in everyone's best interest for power supply makers to standardize this.

If you’re planning to swap PSUs in your HL15 or PC/server that has parts made for a different PSU, be ready to go deep into the rabbit hole of custom cables. And yes those old Molex connectors are still around, like it or not.

The HL15 is finally back in the rack, and it's running great. Clean cables, quiet fans, and solid power delivery.

!["Done Wiring (for now)"](/assets/img/posts/hl15-final-wiring.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APj7wLrPxj+HHib9orUdS8dfH3VtX8QeG/DNp4U8E+DPEPiG5i1Sx8X6hfweNvDkUlhpfiHSdCfwdpsljrPh+30HXPC2rWkcQ0q5MmpTW2nx8GJxfLnuAw9CjRngK1XE/XcS60HHDwhSjPDzhGFSXNKrV5oym4t6x5L2cY9mV4DHSwuKxGMxNWnWoVMPLC4N4ejKlioTqOlWVStUorEU/Z0oqq6cJ04KVS1pxhGpPrZtU+Il9LLexSfH2zivJHuo7SfT/iXFPax3DGVLeaKOKaOKWBXEUkcc0qI6lUkdQGPvRngeVf7VhNlvGo3t1fs9X3fc55YPETlKUlFSlJykudRtJu7XKnaNm9lotkf/2Q==" }
_Done wiring (for now)_

!["The PSU and backplane are all cleaned up"](/assets/img/posts/hl15-backplane.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APP/AB3+zZ8CfFnji81PxGfFvxD8U6v4Y8L6Bq3xb034k/CWOO8vrLwsum6pqWm2HijxjDfabfGDUrm08QCHR7LT7q2t4rOexj0pIWm8aNfA0p4dLMsLD6tTlDkp1YqjVapQU41VKqpT9lJXjzyvCV5O7ZFTEZvRr4+nT4YznEUsRNTp4mLwbjyy5nL6tGeIpSw/tI1XTnegk+RuPuuN/pu5t/ifpVzcaZ4autE1Hw5ps8thoGoXt9/aF5f6JZyNb6Ve3d/F4niivbm6sY4J57uOOOO5ld5kRFcKPy3HcKSq47GVcLPIpYapisRUw7cIa0J1pypPSslrTcXorH6fhMywUcJhY4iGcxrxw9GNZJzSVVU4qokvq7slPmSV3ZdWf//Z" }
_The PSU and backplane are all cleaned up_

If you're curious, I ranted about this whole issue with modular power cables and PSU manufacturers here:  
[I Rebuilt My Home Server — Quieter, Faster, and Ready for 2025](https://www.youtube.com/watch?v=NOaLlOAIWUU)

Also, if you're interested in this PSU it's hard to find right now.  Noctua said the demand for this PSU is much greater than they anticipated but more stock is on the way.  

You can find it here:

- Seasonic Prime TX-1600 Noctua Edition PSU: <https://amzn.to/3EjEAeA> (affiliate link)

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
