# How to Upgrade, Backup, and Restore Rancher 2

It use to be hard to back up Rancher, but with Rancher 2 it's super simple.  Upgrading, backing up, and restoring your Rancher server should be part of your regular routine.  Join me in this tutorial as we walk through backing up, upgrading, and restoring a single node Rancher Docker install in just a couple of minutes.  Trust me, you'll feel better after you do.

https://www.youtube.com/watch?v=YWqBxCIfxw4


Need to install Rancher?  See my guide https://www.youtube.com/watch?v=oILc0ywDVTk

See the full guide from Rancher https://rancher.com/docs/rancher/v2.x/en/upgrades/upgrades/single-node/

## Upgrade & Backup Outline

* Create a copy of the data from your Rancher server container
* Create a backup tarball
* Pull the new Docker image
* Start the new Rancher server container
* Verify the Upgrade
* Clean up your old Rancher server container


See all containers

`docker ps`


See all containers including stopped ones

`docker ps -a`


Stop the container

```
docker stop <RANCHER_CONTAINER_NAME>
```

Create a data container

```
docker create --volumes-from <RANCHER_CONTAINER_NAME> --name rancher-data rancher/rancher:<RANCHER_CONTAINER_TAG>
```

Create a backup tarball

```
docker run --volumes-from rancher-data -v $PWD:/backup busybox tar zcvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz /var/lib/rancher
```

Run `ls` and you should see your tarball

```
rancher-data-backup-v2.4.3-2020-06-21.tar.gz
```


Pull a new docker image

```
docker pull rancher/rancher:<RANCHER_VERSION_TAG>
```

Start your new rancher server container.

Use the command you used to create your initial container, it looks something like this.

```
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server rancher/<RANCHER_VERSION>
```

Check to see if it's running

```
docker ps
```

## Retoring Rancher from Backup

Use the command you used to create your initial container, it looks something like this.

```
docker run -d --restart=unless-stopped -p 9090:80 -p 9091:443 -v /opt/rancher:/var/lib/rancher --name=rancher_docker_server rancher/<RANCHER_VERSION>
```

Stop the container

```
docker stop <RANCHER_CONTAINER_NAME>
```

Delete state data and replce from backup

```
docker run  --volumes-from <RANCHER_CONTAINER_NAME> -v $PWD:/backup \
busybox sh -c "rm /var/lib/rancher/* -rf  && \
tar pzxvf /backup/rancher-data-backup-<RANCHER_VERSION>-<DATE>.tar.gz"
```

Start the container

```
docker start <RANCHER_CONTAINER_NAME>
```