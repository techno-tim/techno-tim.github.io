# Before I do anything on Linux, I do these first...


[![Before I do anything on Linux, I do these first...](http://img.youtube.com/vi/ZsjK4VDopiE/0.jpg)](https://www.youtube.com/watch?v=ZsjK4VDopiE "Before I do anything on Linux, I do these first...")

After setting up my Linux servers, there are a few things I do before I use them for their intended purpose.  This ranges from security, to tools, to config.  Join me as we set up our first Linux server in this tutorial and walk through setting it up proper (and maybe some bonus items sprinkled in).



## Update

```
sudo apt-get update

sudo apt-get upgrade
```

Reconfigure unattended-upgrades

`sudo dpkg-reconfigure --priority=low unattended-upgrades`

Verify unattended upgrades configuration file in your text editor of choice

`/etc/apt/apt.conf.d/20auto-upgrades`

To disable automatic reboots by the automatic upgrades configuration edit the following file:

`/etc/apt/apt.conf.d/50-unattended-upgrades`

and uncomment the following line by removing the leading slashes:

`//Unattended-Upgrade::Automatic-Reboot "false";`


## Account

add user

`sudo adduser someuser`

add to sudoers

`sudo usermod -aG sudo someuser`

## SSH Server

install
`sudo apt-get istall openssh-server`

copy key from client to server

`ssh-copy-id someuser@192.168.0.100`

switch to key based auth

`sudo nano /etc/ssh/sshd_config`

Add these attributes

```
PasswordAuthentication no
ChallengeResponseAuthentication no
```


## Networking

static IP

`sudo nano /etc/netplan/01-netcfg.yaml`

```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens18:
     dhcp4: no
     addresses: 
        - 192.168.0.222/24
     gateway4: 192.168.0.1
     nameservers:
       addresses: [192.168.0.4]

```




## Install `oh-my-zsh`


```
sudo apt-get update
sudo apt-get install zsh
sudo apt-get install powerline fonts-powerline

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Fix LVM

`sudo lvm`


`lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv`

`exit`

`sudo resize2fs /dev/ubuntu-vg/ubuntu-lv`

## hostname

`sudo hostnamectl set-hostname`

`sudo nano /etc/hosts`

## Time Zone

Check time zone: 

`timedatectl`

Change time zone: 

`sudo timedatectl set-timezone`

You can also use if you want a menu.

`sudo dpkg-reconfigure tzdata `



##  NTP Time

`sudo nano /etc/systemd/timesyncd.conf`

```
NTP=192.168.0.4
```

`sudo timedatectl set-net off`

`sudo timedatectl set-ntp on`


## install kvm agent

`sudo apt-get install qemu-guest-agent`


## firewall

`sudo  ufw default deny incoming`

`sudo ufw allow ssh`

`sudo ufw enable`

## fail2ban

`sudo apt-get install fail2ban`

`sudo cp /etc/fail2ban/fail2ban.{conf,local}`

`sudo cp /etc/fail2ban/jail.{conf,local}`

`sudo nano /etc/fail2ban/jail.local`

```
backend = systemd
```

check status

`sudo fail2ban-client status`


`sudo fail2ban-client status sshd`
