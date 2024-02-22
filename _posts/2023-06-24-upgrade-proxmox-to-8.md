---
layout: post
title: "How to Upgrade Proxmox 7 to 8"
date: 2023-06-24 10:00:00 -0500
categories: proxmox
tags: homelab proxmox debian
image:
  path: /assets/img/headers/proxmox-8-upgrade.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5q7nx58ILP4x+P/Ctl+yj8DoPDnhTQI7jR4GvvjBLq0klo/g63Mmq6n/wtFLa9mvXvb66vXt9KsFM108NnHZaeq2NfqeFzPMsLmWIp4fFwpLDQqOnyYDLNU6kVyTc8HNzioycbTcm18Tack/xx4aniuHcqx2JnjquKx8sOsVNZxntOnKf1Svzzo0aeaRp0OepTU+SEXCLb5YqahOH0fafscfAPXbS11uLwJp2mRaxbw6rHptvq3jWeDT49QjW7SxhnufF73E0Noswgjlnd5pEjV5WZyxP0P1bCvWVOpKT1lJPDRUpdWorCWim9eVaLZaHxU+OeJoTlCNfAcsJSjG+FxjdotpXf9p6uy1fU/wD/2Q==
---

Proxmox 8.0 has been released (June, 22, 2023) and includes several new features and a Debian version upgrade. Among the changes are:

- Debian 12 "Bookworm", but using a newer Linux kernel 6.2
- QEMU 8.0.2, LXC 5.0.2, ZFS 2.1.12
- Optional Text mode installer (TUI)
- New default CPU type x86-64-v2-AES for VMs
- Ceph Quincy 17.2.6 and a new, stable Ceph Enterprise repository
- Authentication realm sync jobs
- ACL for network resources
- Resource mappings between PCI(e) or USB devices and nodes in a cluster
- and more....

Many have been asking how to upgrade, so I decided to put together an easy-to-follow post to get your Proxmox server upgraded to 8!

## Preparing the Upgrade to Proxmox 8

This might go without saying, but you'll want to be sure you back up your Proxmox server's configs as well as any virtual machines running on thi server. After you've done that, you'll need to check to be sure you are running at least 7.4.15 or newer (If you need to upgrade from 6 to 7, see my [post on how to do this](/posts/proxmox-7/)). If you aren't sure which version you are running, you can run this to check:

```bash
pveversion
```

This should output something similar to:

```bash
pve-manager/7.4-15/a5d2a31e (running kernel: 5.15.108-1-pve)
```

Next we'll want to run an upgrade script to check to if there are any potential issues during the upgrade process. Don't worry, this does not execute anything other than checks and is safe to run multiple times.

You can run it by executing:

```bash
pve7to8
```

You can also run it with _all_ checks enabled by executing:

```bash
 pve7to8 --full
```

You should see something similar to the following in the output:

```bash
➜  ~  pve7to8 --full
= CHECKING VERSION INFORMATION FOR PVE PACKAGES =

Checking for package updates..
PASS: all packages up-to-date

Checking proxmox-ve package version..
PASS: proxmox-ve package has version >= 7.4-1

Checking running kernel version..
PASS: running kernel '5.15.108-1-pve' is considered suitable for upgrade.

= CHECKING CLUSTER HEALTH/SETTINGS =

PASS: systemd unit 'pve-cluster.service' is in state 'active'
PASS: systemd unit 'corosync.service' is in state 'active'
PASS: Cluster Filesystem is quorate.

Analzying quorum settings and state..
INFO: configured votes - nodes: 3
INFO: configured votes - qdevice: 0
INFO: current expected votes: 3
INFO: current total votes: 3

Checking nodelist entries..
PASS: nodelist settings OK

Checking totem settings..
PASS: totem settings OK

INFO: run 'pvecm status' to get detailed cluster status..

= CHECKING HYPER-CONVERGED CEPH STATUS =

SKIP: no hyper-converged ceph setup detected!

= CHECKING CONFIGURED STORAGES =

PASS: storage 'backups' enabled and active.
PASS: storage 'fast10' enabled and active.
PASS: storage 'local' enabled and active.
INFO: Checking storage content type configuration..
PASS: no storage content problems found
PASS: no storage re-uses a directory for multiple content types.

= MISCELLANEOUS CHECKS =

INFO: Checking common daemon services..
PASS: systemd unit 'pveproxy.service' is in state 'active'
PASS: systemd unit 'pvedaemon.service' is in state 'active'
PASS: systemd unit 'pvescheduler.service' is in state 'active'
PASS: systemd unit 'pvestatd.service' is in state 'active'
INFO: Checking for supported & active NTP service..
WARN: systemd-timesyncd is not the best choice for time-keeping on servers, due to only applying updates on boot.
  While not necessary for the upgrade it's recommended to use one of:
    * chrony (Default in new Proxmox VE installations)
    * ntpsec
    * openntpd

INFO: Checking for running guests..
WARN: 6 running guest(s) detected - consider migrating or stopping them.
INFO: Checking if the local node's hostname 'draco' is resolvable..
INFO: Checking if resolved IP is configured on local node..
PASS: Resolved node IP '192.168.0.11' configured and active on single interface.
INFO: Check node certificate's RSA key size
PASS: Certificate 'pve-root-ca.pem' passed Debian Busters (and newer) security level for TLS connections (4096 >= 2048)
PASS: Certificate 'pve-ssl.pem' passed Debian Busters (and newer) security level for TLS connections (2048 >= 2048)
INFO: Checking backup retention settings..
PASS: no backup retention problems found.
INFO: checking CIFS credential location..
PASS: no CIFS credentials at outdated location found.
INFO: Checking permission system changes..
INFO: Checking custom role IDs for clashes with new 'PVE' namespace..
PASS: no custom roles defined, so no clash with 'PVE' role ID namespace enforced in Proxmox VE 8
INFO: Checking if LXCFS is running with FUSE3 library, if already upgraded..
SKIP: not yet upgraded, no need to check the FUSE library version LXCFS uses
INFO: Checking node and guest description/note length..
PASS: All node config descriptions fit in the new limit of 64 KiB
PASS: All guest config descriptions fit in the new limit of 8 KiB
INFO: Checking container configs for deprecated lxc.cgroup entries
PASS: No legacy 'lxc.cgroup' keys found.
INFO: Checking if the suite for the Debian security repository is correct..
INFO: Checking for existence of NVIDIA vGPU Manager..
PASS: No NVIDIA vGPU Service found.
INFO: Checking bootloader configuration...
SKIP: not yet upgraded, no need to check the presence of systemd-boot
SKIP: No containers on node detected.

= SUMMARY =

TOTAL:    33
PASSED:   27
SKIPPED:  4
WARNINGS: 2
FAILURES: 0

ATTENTION: Please check the output for detailed information!
```

As you can see there are a few warnings but nothing failing. The warnings I have listed are ones related to time packages (which I am going to ignore) and one related to machines still running. To resolve the second warning I will shutdown all the machines before I upgrade.

## Upgrade APT Packages

We'll want to be sure that we've applied all updates to our current installation before upgrading to 8. You can do this by running:

```bash
apt update
apt dist-upgrade
```

If there are updates, I recommend applying them all, rebooting, and upgrading again if needed. Repeat this until there aren't any up updates to apply.

```bash
➜  ~ apt update
Hit:1 http://security.debian.org bullseye-security InRelease
Hit:2 http://download.proxmox.com/debian/pve bullseye InRelease
Hit:3 http://ftp.us.debian.org/debian bullseye InRelease
Hit:4 http://ftp.us.debian.org/debian bullseye-updates InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.

➜  ~ apt dist-upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
```

## Updating APT Repositories

Well need to update our Debian and Proxmox apt repositories to Bookworm:

```bash
sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list
```

If you're also using the "no-subscription" repository, you'll also want to update those too:

```bash
sed -i -e 's/bullseye/bookworm/g' /etc/apt/sources.list.d/pve-install-repo.list
```

Mine is actually at `/etc/apt/sources.list.d/pve-no-enterprise.list` so I will run instead:

```bash
sed -i -e 's/bullseye/bookworm/g' /etc/apt/sources.list.d/pve-no-enterprise.list
```

You can verify these files by checking to be sure they were updated with `bookworm`:

```bash
cat /etc/apt/sources.list
```

```bash
cat /etc/apt/sources.list.d/pve-install-repo.list
```

or for me personally:

```bash
cat /etc/apt/sources.list.d/pve-no-enterprise.list
```

You should see something like this:

```bash
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
```

Remember, you are just verifying the `sed` replaced `bullseye` with `bookworm` in each file.

## Upgrading Ceph

If you're running `ceph` you'll want to check the [Proxmox 7 to 8 Upgrade Wiki](https://pve.proxmox.com/wiki/Upgrade_from_7_to_8#Update_the_Ceph_Package_Repository) for a few additional steps. I am not running `ceph` so I will skip this part.

## Upgrade the system to Debian Bookworm and Proxmox VE 8.0

Now all that's left is updating the system! If you've made it this far it's now time to upgrade! I would recommend stopping or migrating any virtual machines and LXC containers before proceeding.

```bash
apt update
apt dist-upgrade
```

This step may take some time depending on your internet speed and server resources.

The upgrade might ask you to approve changes to configurations files. I am going to defer to the [Proxmox documentation](https://pve.proxmox.com/wiki/Upgrade_from_7_to_8#Upgrade_the_system_to_Debian_Bookworm_and_Proxmox_VE_8.0) for this step, which is shown below:

> It's suggested to check the difference for each file in question and choose the answer accordingly to what's most appropriate for your setup.
> Common configuration files with changes, and the recommended choices are:
>
> - /etc/issue -> Proxmox VE will auto-generate this file on boot, and it has only cosmetic effects on the login console.
>   - Using the default "No" (keep your currently-installed version) is safe here.
> - /etc/lvm/lvm.conf -> Changes relevant for Proxmox VE will be updated, and a newer config version might be useful.
>   - If you did not make extra changes yourself and are unsure it's suggested to choose "Yes" (install the package maintainer's version) here.
> - /etc/default/grub -> Here you may want to take special care, as this is normally only asked for if you changed it manually, e.g., for adding some kernel command line option.
>   - It's recommended to check the difference for any relevant change, note that changes in comments (lines starting with #) are not relevant.
>   - If unsure, we suggested to selected "No" (keep your currently-installed version)

## Verifying the Upgrade

After upgrading all packages you can verify the upgrade by running:

```bash
pve7to8
```

If all went well, you should see everything pass (or with minimal warnings).

You can now reboot your system.

After rebooting and logging into the system for the first time, you'll want to clear your browser's cache for pve web, or just hard reload:

- Windows (CTRL + SHIFT + R)
- macOS (⌘ + Alt + R)

If you have more servers in your cluster, repeat this for each server!

Enjoy Proxmox 8!

![Proxmox upgraded!](/assets/img/posts/proxmox-8-upgrade-screen-shot.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5+vCvwH1Hxv4c/4S5/E1nBFdHV4P7Mu9KmuyY9L1bVLQs99FfWs8cskluXVrdYtquoOTH83yOccXYjBZpPAvL4YpQ9iniamPlSqSdWnTqXdNYGtfl9o1eVZt8qd1e0eZYnD4aUqcqMpWaaUPcjG6vZJTStaWq5Vqlbrfx19HvUdk+w6KNjMuBe6ywG0kYDM24jjq3J6nmvppYmEW4tTum07JdHb+Y7FiMO0n9X3SetSfX5n//Z" }
_Check to be sure you see Proxmox 8 here!_

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">If you were looking to upgrade to Proxmox 8 today, I wrote a quick guide to help! I&#39;ve already tested it on my production cluster and it works great!<a href="https://t.co/NFqv0XXyWB">https://t.co/NFqv0XXyWB</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1672967891397013508?ref_src=twsrc%5Etfw">June 25, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
