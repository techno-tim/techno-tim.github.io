---
layout: post
title: "Boost ZFS Performance with a Special VDEV in TrueNAS"
date: 2025-05-10 08:00:00 -0500
categories: homelab
tags: homelab zsf truenas
image:
 path: /assets/img/headers/special-vdev-truenas-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOR+DfwF+Gfwb+GvhG10vwh4S8SXeoLLKbvxd4S0DxHbS3dvpPw+19Tqmka3Z6lpmp6ek2vzwRWBt7VpII2ttTu9U066uNPbw/8AWOpZ2wsEk3y/vHvaLXM+TVau6XLe+59VS4c5qjUsZ+7irOKwyUpNydnzus0rJNWcHq01bl1+H/H/AOwZ8KT478am1t9Hs7Y+LfEn2ezh0LUBDaQf2ze+VbRD/hKRiKCPbFHwPkUcDpXR/bSev1Onrr/En11/lIlw9BNr61LRtfwl0f8A18P/2Q==
---

Curious about how a special metadata VDEV can boost ZFS performance, especially with spinning disks? In this video, I walk through what it is, why it matters, and how to set it up in TrueNAS and some from the terminal. I’ll also share real-world benchmarks comparing pools with and without a special VDEV, so you can see the difference for yourself.

{% include embed/youtube.html id='2PdLHsSRHto' %}
📺 [Watch Video](https://www.youtube.com/watch?v=2PdLHsSRHto)

## Testing

I created a test script that you can find here: <https://github.com/techno-tim/zfs-tools>

The test script will try to create a pool based on 3 drives. `HDD1`, `HDD2`, and `NVME_SPECIAL`.  You can modify these to match your disk Ids.

You can find your disk Ids by running:

```shell
ls -l /dev/disk/by-id/
```

You can also adjust the test files by changing `TEST_COUNT` however I found that `100,000` is a good number to get consistent results.  

Update the script with your disk Ids.

You can then run the script:

```shell
chmod +x zfs-metadata.sh # make it executable
./zfs-metadata.sh # run the script
```

It will create 2 pools, `test-1` and `test-2`, `test-2` has the special vdeb.

This will take a long time to run depending on your system, disks, and `TEST_COUNT`.

When it's done, you will find the results in `/mnt/test-results/`

If you want to check the small blocks values for your pool:

List pool

```shell
zpool list -v test-1 # change based on your pool name
```

## Setting Small Blocks & Record Size

To change your small blocks value you can do so like this, however it's a good idea to check your record size first

```console
zfs get recordsize test-1
```

You should see something like:

```console
NAME    PROPERTY    VALUE    SOURCE
test-1  recordsize  128K     default
```

You always want to be sure that your record size > small blocks size, otherwise all blocks will be written

Get value

```shell
zfs get special_small_blocks test-1 -r # change based on your pool name
```

Set value

```shell
zfs set special_small_blocks=64k test-1 # change based on your pool name and the small block value you want to use
```

If you want to use something higher than 128K you would do something like this

```console
zfs set recordsize=256K test-1/yourdataset
zfs set special_small_blocks=128K test-1/yourdataset
```

## My Test results

### Random Read (4K, iodepth=1)

Here are my results from the video.  

- `test-1` pool was a single 14TB EXOS drive
- `test-2` pool was a single 14TB EXOS drive + a Samsung 990 Pro NVMe

| Metric                   | test-1 (HDD only) | test-2 (Special VDEV) | Improvement     |
|--------------------------|------------------|------------------------|-----------------|
| **IOPS**                 | 4,331            | 57,200                 | +1,220%         |
| **Bandwidth**            | 16.9 MiB/s       | 223 MiB/s              | +1,220%         |
| **Avg Latency**          | 865.88 µs        | 66.35 µs               | −92%            |
| **99% Latency**          | 8.0 µs           | 2.8 µs                 | −65%            |
| **Read IO Completed**    | 2.0 GiB          | 26.2 GiB               | +1,210%         |

### Random Write (4K, iodepth=1)

| Metric                   | test-1 (HDD only) | test-2 (Special VDEV) | Change          |
|--------------------------|------------------|------------------------|-----------------|
| **IOPS**                 | 209              | 195                    | −6.7%           |
| **Bandwidth**            | 838 KiB/s        | 782 KiB/s              | −6.7%           |
| **Avg Latency**          | 18.8 ms          | 20.2 ms                | +7.4% (worse)   |
| **99% Latency**          | 10.18 µs         | 10.82 µs               | Slightly worse  |

### Random Write (4K, iodepth=16)

| Metric                   | test-1 (HDD only) | test-2 (Special VDEV) | Improvement     |
|--------------------------|------------------|------------------------|-----------------|
| **IOPS**                 | 210              | 229                    | +9%             |
| **Bandwidth**            | 840 KiB/s        | 919 KiB/s              | +9%             |
| **Avg Latency**          | 303.8 ms         | 277.4 ms               | −8.7%           |
| **99% Latency**          | 701 ms           | 376 ms                 | −46.4%          |
| **99.95% Latency**       | 776 ms           | 443 ms                 | −43%            |
| **Max Latency**          | 842 ms           | 516 ms                 | −38.7%          |

### Random Read/Write (4K, iodepth=16)

| Metric                   | test-1 (HDD only) | test-2 (Special VDEV) | Improvement     |
|--------------------------|------------------|------------------------|-----------------|
| **Read IOPS**            | 196              | 247                    | +26%            |
| **Write IOPS**           | 196              | 246                    | +25%            |
| **Read Bandwidth**       | 788 KiB/s        | 989 KiB/s              | +25.5%          |
| **Write Bandwidth**      | 786 KiB/s        | 986 KiB/s              | +25.5%          |
| **Avg Read Latency**     | 160.15 ms        | 127.45 ms              | −20%            |
| **Avg Write Latency**    | 163.93 ms        | 130.24 ms              | −20.5%          |
| **99% Read Latency**     | 502 ms           | 207 ms                 | −58.8%          |
| **99% Write Latency**    | 506 ms           | 209 ms                 | −58.7%          |

### Metadata – Random Access (20,000 files)

| Pool     | Duration (s) | Improvement     |
|----------|--------------|-----------------|
| test-1   | 71.91 s      | —               |
| test-2   | 65.73 s      | +8.6% faster     |

### Metadata – Sequential Access (20,000 files)

| Pool     | Duration (s) | Improvement     |
|----------|--------------|-----------------|
| test-1   | 139.80 s     | —               |
| test-2   | 81.62 s      | +41.6% faster    |

## 📦 Products in this video 📦

While enterprise gear is great for businesses, I have found that if you have a good warranty, redundancy, and understand the trade-offs, consumer gear works great for home.

- Samsung 990 Pro NVMe: <https://amzn.to/4d9JKXk> (affiliate link)

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark">I tested how much a special metadata VDEV can actually speed up ZFS. Turns out it makes directory browsing faster, snappier containers, and a smart use of NVMe. I built a test script, ran benchmarks, and walk through it all in <a href="https://twitter.com/TrueNAS?ref_src=twsrc%5Etfw">@TrueNAS</a> <a href="https://t.co/czyXEFkSd3">https://t.co/czyXEFkSd3</a> <a href="https://t.co/6hpIve8HR9">pic.twitter.com/6hpIve8HR9</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1921242653628199171?ref_src=twsrc%5Etfw">May 10, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
