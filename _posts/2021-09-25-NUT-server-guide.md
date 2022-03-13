---
layout: post
title: "Network UPS Tools (NUT) Ultimate Guide"
date: 2021-09-25 10:00:00 -0500
categories: homelab
tags: homelab nut self-hosted docker ups pdu open-source
---

[![Network UPS Tools (NUT) Ultimate Guide](https://img.youtube.com/vi/vyBP7wpN72c/0.jpg)](https://www.youtube.com/watch?v=vyBP7wpN72c "Network UPS Tools (NUT) Ultimate Guide")

Meet NUT Server, or Network UPS Tools.  It's an open UPS networking monitoring tool that runs on many different operating systems and processors.  This means you can run the server on Linux, MacOS, or BSD and run the client on Windows, MacOS, Linux, and more.  It' perfect for your Pi, server, or desktop.  It works with hundreds of UPS devices, PDUs, and many other power management systems.

This is the ultimate guide to configuring Network UPS Tools (NUT).  We cover everything from installing and configuring the server on as Raspberry Pi, configuring the client on Windows and Linux, configure a charting and graphing website to visualize NUT data, spin up an additional web site use Docker, and finally set up monitoring and alerting to automate shutdowns of your machine.

[https://networkupstools.org/](https://networkupstools.org)

Also, note to self, don't eat a salad before you record a video....

[Watch Video](https://www.youtube.com/watch?v=vyBP7wpN72c)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

## NUT UPS Server

plug in ups

`lsusb`

should see something like

```log
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 019: ID 09ae:2012 Tripp Lite
Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

```bash
sudo apt update
sudo apt install nut nut-client nut-server
```

```bash
sudo nut-scanner -U
```

should see something like

tripp lite

```conf
[nutdev1]
        driver = "usbhid-ups"
        port = "auto"
        vendorid = "09AE"
        productid = "2012"
        product = "Tripp Lite UPS"
        vendor = "Tripp Lite"
        bus = "001"
```

apc 1500

```conf
[nutdev1]
        driver = "usbhid-ups"
        port = "auto"
        vendorid = "051D"
        productid = "0002"
        product = "Back-UPS XS 1500M FW:947.d10 .D USB FW:d10"
        serial = "3xxxxxxxxxxx"
        vendor = "Tripp Lite"
        bus = "001"
```

apc 850

```conf
[nutdev3]
        driver = "usbhid-ups"
        port = "auto"
        vendorid = "051D"
        productid = "0002"
        product = "Back-UPS ES 850G2 FW:931.a10.D USB FW:a"
        serial = "3xxxxxxxxxxx"
        vendor = "American Power Conversion"
        bus = "001"
```

`sudo nano /etc/nut/ups.conf`

```conf
pollinterval = 1
maxretry = 3

[tripplite]
    driver = usbhid-ups
    port = auto
    desc = "Tripp Lite 1500VA SmartUPS"
    vendorid = 09ae
    productid = 2012

[apc-network]
    driver = usbhid-ups
    port = auto
    desc = "APC Back-UPS XS 1500"
    vendorid = 051d
    productid = 0002
    serial = 3xxxxxxxxx

[apc-modem]
    driver = usbhid-ups
    port = auto
    desc = "APC 850 VA"
    vendorid = 051d
    productid = 0002
    serial = 3xxxxxxxxx
```

`sudo nano /etc/nut/upsmon.conf`

```log
MONITOR tripplite@localhost 1 admin secret master
MONITOR apc-modem@localhost 1 admin secret master
MONITOR apc-network@localhost 1 admin secret master
```

`sudo nano /etc/nut/upsd.conf`

local host

```log
LISTEN 127.0.0.1 3493 
```

all interface

```log
LISTEN 0.0.0.0 3493 
```

`sudo nano /etc/nut/nut.conf`

```conf
MODE=netserver
```

`sudo nano /etc/nut/upsd.users`

```conf
[monuser]
  password = secret
  admin master
```

`sudo nano /etc/udev/rules.d/99-nut-ups.rules`

```conf
SUBSYSTEM!="usb", GOTO="nut-usbups_rules_end"

# TrippLite
#  e.g. TrippLite SMART1500LCD - usbhid-ups
ACTION=="add|change", SUBSYSTEM=="usb|usb_device", SUBSYSTEMS=="usb|usb_device", ATTR{idVendor}=="09ae", ATTR{idProduct}=="2012", MODE="664", GROUP="nut", RUN+="/sbin/upsdrvctl stop; /sbin/upsdrvctl start"

LABEL="nut-usbups_rules_end"
```

reboot (because it's easy)

or

```bash
sudo service nut-server restart
sudo service nut-client restart
sudo systemctl restart nut-monitor
sudo upsdrvctl stop
sudo upsdrvctl start
```

APC UPS 950 va

query device by USB bus

`lsusb -D /dev/bus/usb/001/057`

```log
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x051d American Power Conversion
  idProduct          0x0002 Uninterruptible Power Supply
  bcdDevice            0.90
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0022
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                2mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode           33 US
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength    1049
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval             100
```

## NUT CGI Server

`sudo apt install apache2 nut-cgi`

`sudo nano /etc/nut/hosts.conf`

```log
MONITOR tripplite@localhost "Tripp Lite 1500VA SmartUPS - Rack"
MONITOR apc-modem@localhost "APC 850 VA - Wall"
MONITOR apc-network@localhost "APC Back-UPS XS 1500 - Rack"

```

`sudo a2enmod cgi`

`sudo systemctl restart apache2`

`sudo nano /etc/nut/upsset.conf`

```conf
I_HAVE_SECURED_MY_CGI_DIRECTORY
```

visit

[http://your.ip.adddress/cgi-bin/nut/upsstats.cgi](http://your.ip.adddress/cgi-bin/nut/upsstats.cgi)

## Webnut Docker Container

```bash
mkdir webnut
cd webnut
nano docker-compose.yml
```

paste contents and save

```conf
version: "3.1"
services:
  nut:
    image: teknologist/webnut
    container_name: webnut
    environment:
      - UPS_HOST=ip.address.of.nut.server
      - UPS_PORT=3493
      - UPS_USER=admin
      - UPS_PASSWORD=secret
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    networks:
      - proxy
    ports:
      - 6543:6543
networks:
  proxy:
    external: true
```

`docker-compose up -d --force-recreate`

## Linux NUT Client (remote)

`sudo apt install nut-client`

then run

`upsc` to verify

verify you can connect

`upsc tripplite@ip.address.of.server`

`sudo nano /etc/nut/upsmon.conf`

```conf
RUN_AS_USER root

MONITOR apc-modem@ip.address.of.nut.server 1 admin secret slave

MINSUPPLIES 1
SHUTDOWNCMD "/sbin/shutdown -h"
NOTIFYCMD /usr/sbin/upssched
POLLFREQ 2
POLLFREQALERT 1
HOSTSYNC 15
DEADTIME 15
POWERDOWNFLAG /etc/killpower

NOTIFYMSG ONLINE    "UPS %s on line power"
NOTIFYMSG ONBATT    "UPS %s on battery"
NOTIFYMSG LOWBATT   "UPS %s battery is low"
NOTIFYMSG FSD       "UPS %s: forced shutdown in progress"
NOTIFYMSG COMMOK    "Communications with UPS %s established"
NOTIFYMSG COMMBAD   "Communications with UPS %s lost"
NOTIFYMSG SHUTDOWN  "Auto logout and shutdown proceeding"
NOTIFYMSG REPLBATT  "UPS %s battery needs to be replaced"
NOTIFYMSG NOCOMM    "UPS %s is unavailable"
NOTIFYMSG NOPARENT  "upsmon parent process died - shutdown impossible"

NOTIFYFLAG ONLINE   SYSLOG+WALL+EXEC
NOTIFYFLAG ONBATT   SYSLOG+WALL+EXEC
NOTIFYFLAG LOWBATT  SYSLOG+WALL
NOTIFYFLAG FSD      SYSLOG+WALL+EXEC
NOTIFYFLAG COMMOK   SYSLOG+WALL+EXEC
NOTIFYFLAG COMMBAD  SYSLOG+WALL+EXEC
NOTIFYFLAG SHUTDOWN SYSLOG+WALL+EXEC
NOTIFYFLAG REPLBATT SYSLOG+WALL
NOTIFYFLAG NOCOMM   SYSLOG+WALL+EXEC
NOTIFYFLAG NOPARENT SYSLOG+WALL

RBWARNTIME 43200

NOCOMMWARNTIME 600

FINALDELAY 5
```

set net client
`sudo nano /etc/nut/nut.conf`

`MODE=netclient`

restart service

`systemctl restart nut-client`

check status

`systemctl status user-client`

## Windows NUT Client

[https://github.com/gawindx/WinNUT-Client/releases](https://github.com/gawindx/WinNUT-Client/releases)

scheduling on the remote system

`sudo nano /etc/nut/upssched.conf`

```conf
CMDSCRIPT /etc/nut/upssched-cmd
PIPEFN /etc/nut/upssched.pipe
LOCKFN /etc/nut/upssched.lock

AT ONBATT * START-TIMER onbatt 30
AT ONLINE * CANCEL-TIMER onbatt online
AT ONBATT * START-TIMER earlyshutdown 30
AT LOWBATT * EXECUTE onbatt
AT COMMBAD * START-TIMER commbad 30
AT COMMOK * CANCEL-TIMER commbad commok
AT NOCOMM * EXECUTE commbad
AT SHUTDOWN * EXECUTE powerdown
AT SHUTDOWN * EXECUTE powerdown
```

`sudo nano /etc/nut/upssched-cmd`

```bash
#!/bin/sh
 case $1 in
       onbatt)
          logger -t upssched-cmd "UPS running on battery"
          ;;
       earlyshutdown)
          logger -t upssched-cmd "UPS on battery too long, early shutdown"
          /usr/sbin/upsmon -c fsd
          ;;
       shutdowncritical)
          logger -t upssched-cmd "UPS on battery critical, forced shutdown"
          /usr/sbin/upsmon -c fsd
          ;;
       upsgone)
          logger -t upssched-cmd "UPS has been gone too long, can't reach"
          ;;
       *)
          logger -t upssched-cmd "Unrecognized command: $1"
          ;;
 esac
```

make it executable (should already be)

`chmod +x /etc/nut/upssched-cmd`

Be sure PIPEFN and LOCKFN point to a folder that esists, I've seen it point to `/etc/nut/upssched/` instead of `/etc/nut`  If it does, create the folder or update these variables.
`mkdir /etc/nut/upssched/`

test

`systemctl restart nut-client`

then pull the plug on the ups connected to the master, check syslogs

`tail /var/log/syslog`

should see the logs

machine should shutdown
