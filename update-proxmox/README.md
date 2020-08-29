# How to Update Proxmox VE (No subscription required)

[![How to Update Proxmox VE (No subscription required)](http://img.youtube.com/vi/rfK8fc-ccoQ/0.jpg)](https://www.youtube.com/watch?v=rfK8fc-ccoQ "How to Update Proxmox VE (No subscription required)")


Have you been thinking about updating your Proxmox VE server?  Well, what are you waiting for?  Upgrade your Proxmox server in your home lab in just a few minutes with this step-by-step tutorial!


Edit `/etc/apt/sources.list`

```
deb http://ftp.us.debian.org/debian buster main contrib

deb http://ftp.us.debian.org/debian buster-updates main contrib

# security updates
deb http://security.debian.org buster/updates main contrib

# not for production use
deb http://download.proxmox.com/debian buster pve-no-subscription
```

Run

`apt-get update`

`apt dist-upgrade`