---
layout: post
title: "How to Upgrade, Backup, and Restore Rancher 2"
date: 2020-06-27 09:00:00 -0500
categories: kubernetes rancher
tags: homelab rancher kubernetes
---

[![How to Upgrade, Backup, and Restore Rancher 2](https://img.youtube.com/vi/YWqBxCIfxw4/0.jpg)](https://www.youtube.com/watch?v=YWqBxCIfxw4 "How to Upgrade, Backup, and Restore Rancher 2")

It use to be hard to back up Rancher, but with Rancher 2 it's super simple.  Upgrading, backing up, and restoring your Rancher server should be part of your regular routine.  Join me in this tutorial as we walk through backing up, upgrading, and restoring a single node Rancher Docker install in just a couple of minutes.  Trust me, you'll feel better after you do.

[Watch Video](https://www.youtube.com/watch?v=YWqBxCIfxw4)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

* Need to install Rancher?  See my guide https://www.youtube.com/watch?v=YWqBxCIfxw4

* See the full guide from Rancher https://rancher.com/docs/rancher/v2.x/en/upgrades/upgrades/single-node/

## Upgrade & Backup Outline

* Create a copy of the data from your Rancher server container
* Create a backup tarball
* Pull the new Docker image
* Start the new Rancher server container
* Verify the Upgrade
* Clean up your old Rancher server container


See all containers

```bash
docker ps
```


See all containers including stopped ones

```bash
docker ps -a
```


Stop the container

```bash
docker stop <RANCHER_CONTAINER_NAME>
```

Create a data container

```bash
docker create --volumes-from <RANCHER_CONTAINER_NAME> --name rancher-data-<DATE> rancher/rancher:<RANCHER_CONTAINER_TAG>
```

Create a backup tarball

```bash
docker run  --volumes-from rancher-data-<DATE> -v $PWD:/backup:z busybox tar pzcvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz /var/lib/rancher

```

Run `ls` and you should see your tarball

```bash
rancher-data-backup-v2.4.3-2020-06-21.tar.gz
```


Pull a new docker image

```bash
docker pull rancher/rancher:<RANCHER_VERSION_TAG>
```

Start your new rancher server container.

Use the command you used to create your initial container, it looks something like this.

```bash
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 --privileged -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server rancher/rancher:<RANCHER_VERSION>
```

Check to see if it's running

```bash
docker ps
```

## Restoring Rancher from Backup

Use the command you used to create your initial container, it looks something like this.

```bash
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 --privileged -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server rancher/rancher:<RANCHER_VERSION>
```

Stop the container

```bash
docker stop <RANCHER_CONTAINER_NAME>
```

Delete state data and replace from backup

```bash
docker run  --volumes-from <RANCHER_CONTAINER_NAME> -v $PWD:/backup \
busybox sh -c "rm /var/lib/rancher/* -rf  && \
tar pzxvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz"
```

Start the container

```bash
docker start <RANCHER_CONTAINER_NAME>
```





## Unofficial Way


### Backup

```bash
cd /opt
```

```bash
docker stop rancher_docker_server
```

if this fails it means you named your container something else, find it by running `docker ps`

```bash
sudo tar czpf rancher-data-backup-VERSION-DATE-unofficial.tar.gz rancher
```

```bash
sudo mv rancher-data-backup-VERSION-DATE-unofficial.tar.gz ~/
```

```bash
 docker start rancher_docker_server
```

### Restore


```bash
cd /opt
```

```bash
docker stop rancher_docker_server
```

if this fails it means you named your container something else, find it by running `docker ps`

```bash
sudo tar xzpf rancher-data-backup-VERSION-DATE-unofficial.tar.gz 
```

```bash
 docker start rancher_docker_server
```


### Backup script

Your rancher server must be named similar to `rancher_docker_server_v2.4.5` otherwise you'll need to modify this.
This will not work with `latest` tag, so be sure to pin your version.

It will need to be run with `sudo` or scheduled in `sudo crontab -e`

`rancher_backup.sh`

```bash
# go to rancher dir
cd /opt

# get current rancher tag
RANCHER_TAG=$(docker ps | grep rancher/rancher | grep -Eio 'rancher/rancher:.{0,6}' | sed 's/rancher\/rancher://g')

# date format
TODAY=`date -I`

# stop docker container
docker stop rancher_docker_server_$RANCHER_TAG

# create tar
tar czpf rancher-data-backup-$RANCHER_TAG-$TODAY-unofficial.tar.gz rancher

# move tar
mv rancher-data-backup-$RANCHER_TAG-$TODAY-unofficial.tar.gz /home/USERNAME/backups/rancher_backups/

# start server
docker start rancher_docker_server_$RANCHER_TAG

```


### upgrading to a new version

```bash
NEW_VERSION_TAG=v2.4.8
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 --privileged -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server_$NEW_VERSION_TAG rancher/rancher:$NEW_VERSION_TAG
```