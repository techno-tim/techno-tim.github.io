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

## Finding Your Drives

First install the `nvme` utility

```console
sudo apt update
sudo apt install nvme-cli
```

Then we can list all of our NVMe drives

```console
nvme list
```

You should see something like this

```console
Node                  Generic               SN                   Model                                    Namespace Usage                      Format           FW Rev
--------------------- --------------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme2n1          /dev/ng2n1            PHOC331301K11111     INTEL SSDPEK1A118GA                      1         118.41  GB / 118.41  GB    512   B +  0 B   U5110550
/dev/nvme1n1          /dev/ng1n1            1846E1D22222         CT500P1SSD8                              1         500.11  GB / 500.11  GB    512   B +  0 B   P3CR013
/dev/nvme0n1          /dev/ng0n1            S3EWNX0JA0YYYYY      Samsung SSD 960 PRO 512GB                1         512.11  GB / 512.11  GB    512   B +  0 B   4B6QCXP7
```

From there you can also check to see which lane it's in

```console
lspci | grep -i nvme
```

You should see something like this

```console
01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961/SM963
04:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe PCIe SSD (rev 03)
69:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME SSD P1600X Series
```

## Checking PCIe Speeds

Then you can check to see what each drive is negotiated at (update with your lane assignment)

```console
lspci -s 68:00.0 -vv | grep -iE 'LnkCap|LnkSta'
```

You should see something like this (keep in mind, mine shows PCIe Gen 3 speeds)

```console
  LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 unlimited
  LnkSta: Speed 8GT/s, Width x4
  LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
  LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
```

## Checking Drive Temps and Throttling

If you want to see the SMART log to check for throttling and temps you can run (updated with your drive path)

```console
nvme smart-log /dev/ng0n1
```

You should see something like this

```bash
Smart Log for NVME device:ng0n1 namespace-id:ffffffff
critical_warning			: 0
temperature				: 32°C (305 Kelvin)
available_spare				: 100%
available_spare_threshold		: 10%
percentage_used				: 8%
endurance group critical warning summary: 0
Data Units Read				: 127385723 (65.22 TB)
Data Units Written			: 186302952 (95.39 TB)
host_read_commands			: 1823391462
host_write_commands			: 3042922234
controller_busy_time			: 8341
power_cycles				: 4402
power_on_hours				: 11430
unsafe_shutdowns			: 348
media_errors				: 0
num_err_log_entries			: 13652
Warning Temperature Time		: 0
Critical Composite Temperature Time	: 0
Temperature Sensor 1           : 32°C (305 Kelvin)
Temperature Sensor 2           : 37°C (310 Kelvin)
Thermal Management T1 Trans Count	: 0
Thermal Management T2 Trans Count	: 0
Thermal Management T1 Total Time	: 0
Thermal Management T2 Total Time	: 0
```

### Sequential Performance

Here is the command I ran to test sequential read and writes.  Keep in mind that although the drives and adapter support PCIe gen 4, my board only supports gen 3.

### Sequential Read/Write (Large Files, 1MiB Block Size)

```console
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

```console
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

```console
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
