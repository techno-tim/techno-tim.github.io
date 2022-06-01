---
layout: post
title: "Automate EVERYTHING with Ansible!"
date: 2020-12-26 09:00:00 -0500
categories: homelab
tags: homelab ansible

---

[![Automate EVERYTHING with Ansible!](https://img.youtube.com/vi/w9eCU4bGgjQ/0.jpg)](https://www.youtube.com/watch?v=w9eCU4bGgjQ "Automate EVERYTHING with Ansible!")

Ansible. Need I say more?  Well, maybe, if you've never heard of it. Ansible is a simple IT automation that anyone can use.  You can Automate anything with an SSH conne

[Watch Video](https://www.youtube.com/watch?v=w9eCU4bGgjQ)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## install

```bash
sudo apt update
sudo apt install ansible
sudo apt install sshpass
```

`hosts`

```ini
[ubuntu]
server-01
server-02
192.168.0.100
192.168.0.1002
```

## commands

command with module

```bash
ansible -i ./inventory/hosts ubuntu -m ping --user someuser --ask-pass
```

command with playbook

```bash
ansible-playbook ./playbooks/apt.yml --user someuser --ask-pass --ask-become-pass -i ./inventory/hosts
```

## playbooks

`apt.yml`

```yml
- hosts: "*"
  become: yes
  tasks:
    - name: apt
      apt:
        update_cache: yes
        upgrade: 'yes'
```

`qemu-guest-agent.yml`

```yml
- name: install latest qemu-guest-agent
  hosts: "*"
  tasks:
    - name: install qemu-guest-agent
      apt:
        name: qemu-guest-agent
        state: present
        update_cache: true
      become: true
```

`zsh.yml`

```yml
- name: install latest zsh on all hosts
  hosts: "*"
  tasks:
    - name: install zsh
      apt:
        name: zsh
        state: present
        update_cache: true
      become: true
```

`timezone.yml`

```yml
- name: Set timezone and configure timesyncd
  hosts: "*"
  become: yes
  tasks:
  - name: set timezone
    shell: timedatectl set-timezone America/Chicago

  - name: Make sure timesyncd is stopped
    systemd:
      name: systemd-timesyncd.service
      state: stopped

  - name: Copy over the timesyncd config
    template: src=../templates/timesyncd.conf dest=/etc/systemd/timesyncd.conf

  - name: Make sure timesyncd is started
    systemd:
      name: systemd-timesyncd.service
      state: started
```

`timesyncd.conf`

```conf
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See timesyncd.conf(5) for details.

[Time]
NTP=192.168.0.4
FallbackNTP=time.cloudflare.com
#RootDistanceMaxSec=5
#PollIntervalMinSec=32
#PollIntervalMaxSec=2048
```
