---
layout: post
title: "Thought I Ran Out of PCIe Lanes... I Was Wrong"
date: 2025-04-26 08:00:00 -0500
categories: homelab
tags: homelab hardware oculink nvme icy-dock
image:
 path: /assets/img/headers/oculink-nvme-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5PfgN4w0LVdQkttP8Ahn4J8Kz6d4V1W6udV0C88f3eo6slhpNwk1veR+LvHHirR4E1SeWC8vpdN0ixninsoE0yTT7aS8t7rWlNwkmu6XS3vNRvqntf5rTrcmNuXZK6a69brvf8TD+IOsy6r498b6pcxlrjUvF/iW/nZpN7NNeaze3EpZ/LXexeRiW2ruPOBnFbVW5VKkna8pzbslFXcm3aMUoxXZRSSWiSQQSjCEVe0YxSu3J2SSV5Ntt92223q3c//9k=
---

I thought I had no PCIe lanes left — but OCuLink opened a new path.

{% include embed/youtube.html id='6gKOi56npgQ' %}
📺 [Watch Video](https://www.youtube.com/watch?v=6gKOi56npgQ)

## Info

Today, I expand my home server with more NVMe storage, put a Samsung 990 Pro and Intel Optane head-to-head, and show just how much you can still get out of a packed system.

## Tests

I decided to test each drive to be sure that I wasn't being throttled and that I was getting the highest speeds my motherboard would support.

### Sequential Performance

Here is the command I ran to test sequential read and writes.  Keep in mind that although the drives and adapter support PCIe gen 4, my board only supports gen 3.

### Sequential Read/Write (Large Files, 1MiB Block Size)

```bash
fio --name=seqreadwrite \
    --filename=/dev/nvme3n1 \
    --ioengine=libaio \
    --direct=1 \
    --rw=readwrite \
    --bs=1M \
    --numjobs=2 \
    --iodepth=32 \
    --runtime=30 \
    --time_based \
    --group_reporting
```

| Drive                   | Read Speed | Write Speed |
|--------------------------|------------|-------------|
| **Samsung 990 Pro**       | 3041 MB/s  | 3042 MB/s   |
| **Intel Optane P1600X**   | 689 MB/s   | 694 MB/s    |

### Random 4K Performance

Random 4K tests were using 4k block size, random read/write (`randrw`).

### Random Read/Write 4KiB (IOPS/Small Files Test)

```bash
fio --name=random4k \
    --filename=/dev/nvme3n1 \
    --ioengine=libaio \
    --direct=1 \
    --rw=randrw \
    --bs=4k \
    --numjobs=4 \
    --iodepth=32 \
    --runtime=30 \
    --time_based \
    --group_reporting
```

| Drive                   | Read Speed | Write Speed |
|--------------------------|------------|-------------|
| **Samsung 990 Pro**       | 1940 MB/s  | 1939 MB/s   |
| **Intel Optane P1600X**   | 629 MB/s   | 629 MB/s    |

## Latency Comparison (4K Random Read, 1 Queue Depth)

I then wanted to test latency, since that's where Intel Optane drives are claimed to excel.

### Latency Focused Test (1 I/O at a Time, 4KiB Random Read)

```bash
fio --name=latency_test \
    --filename=/dev/nvme3n1 \
    --ioengine=sync \
    --direct=1 \
    --rw=randread \
    --bs=4k \
    --iodepth=1 \
    --numjobs=1 \
    --runtime=10 \
    --time_based \
    --group_reporting
```

| Drive                 | Avg Latency (µs) | IOPS     | Bandwidth (MB/s) |
|-----------------------|------------------|----------|------------------|
| Samsung 990 Pro       | 25.6 µs           | 37.3k    | 146 MB/s         |
| Intel Optane P1600X    | 9.1 µs            | 97.2k    | 380 MB/s         |

*Note: µs = microseconds (one millionth of a second)*

## Observations

Quick observations:

- Optane P1600X had almost 3x lower latency.
- Optane handled more than 2.5x the IOPS.
- Samsung 990 Pro crushes when it comes to raw transfer speeds

## 📦 Products in this video 📦

- ICY Dock NVMe to U2. Adapter: <https://amzn.to/3Yk882t>
- OCuLink to NVMe U.2 Cable: <https://amzn.to/432ArFa>
- Samsung NVMe: <https://amzn.to/4m6dfO7>
- Intel Optane: <https://amzn.to/4lO3zHL>

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark">I thought I had no PCIe lanes left — but OCuLink opened a new path.<a href="https://t.co/q6K6TUTXtr">https://t.co/q6K6TUTXtr</a> <a href="https://t.co/4Prk054Jic">pic.twitter.com/4Prk054Jic</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1916146585295114703?ref_src=twsrc%5Etfw">April 26, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
