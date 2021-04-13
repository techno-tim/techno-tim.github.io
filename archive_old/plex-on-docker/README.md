# 4 Ways to Install Plex (one is unexpected)

[![4 Ways to Install Plex (one is unexpected)](https://img.youtube.com/vi/MG_1XQxWns0/0.jpg)](https://www.youtube.com/watch?v=MG_1XQxWns0 "4 Ways to Install Plex (one is unexpected)")


I'm a huge fan of virtualization and containerization (if you couldn't tell already)!  Today, we'll walk though the various ways to install Plex step-by-step.  We also see how easy it is to get Plex running on Docker and Kubernetes using Rancher.



## Id for Container

Get Id and Group Id

`id yourusername`

Should see something like this:

`uid=1001(technotim) gid=1001(technotim) groups=1001(technotim),27(sudo),999(docker)`


## Mount Shares During Boot

Install `cifs-utils`

`sudo apt-get install cifs-utils`

Create credentials files for share

`sudo nano /home/technotim/.smbcredentials`


Set permissions

`chmod 600 ~/.smbcredentials`


```
username=yourUsyourusernameername  
password=yourPassword
```

Edit `/etc/fstab`

```
//192.168.0.22/plex_media/movies /mnt/movies cifs credentials=/home/technotim/.smbcredentials 0 0
//192.168.0.22/plex_media/music /mnt/music cifs credentials=/home/technotim/.smbcredentials 0 0
```
Then reboot or
`sudo mount -a` to mount
