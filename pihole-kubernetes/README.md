# PiHole on Docker and Kubernetes (I almost gave up)

[![PiHole on Docker and Kubernetes (I almost gave up)](http://img.youtube.com/vi/NRe2-vye3ik/0.jpg)](https://www.youtube.com/watch?v=NRe2-vye3ik "PiHole on Docker and Kubernetes (I almost gave up)")


We know you've heard of Pihole and we know you are probably aware of how to install it but... have you tried running it on Docker and Kubernetes using Rancher?  Have you configured it for pfSense?  Don't worry, I figured out all the hard stuff for you.  So let's consolidate some hardware and services.


Ubuntu Fix

`sudo apt-get update`

`sudo apt-get install resolvconf`

`sudo nano /etc/resolvconf/resolv.conf.d/head`

add your upstream DNS (I use Quad9)

```
nameserver 9.9.9.9
```

enabled & start service

`sudo systemctl enable resolvconf.service`

`sudo systemctl start resolvconf.service`

Set pi-hole password

`sudo pihole -a -p`
