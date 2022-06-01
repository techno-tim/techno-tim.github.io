---
layout: post
title: "Migrate Your Databases to Kubernetes and Docker"
date: 2020-10-17 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker self-hosted mysql database portainer
---

[![Migrate Your Databases to Kubernetes and Docker](https://img.youtube.com/vi/jZvnkf_HgcY/0.jpg)](https://www.youtube.com/watch?v=jZvnkf_HgcY "Migrate Your Databases to Kubernetes and Docker")

Have you been putting off migrating your database to Docker and Kubernetes like I have?  Well wait no longer.  It's simple using this step-by-step tutorial.  Today, we'll move a database that's on a virtual machine to a container that's running in kubernetes.  Oh yeah, this will also work if it's a bare metal server too, duh.  🙂

[Watch Video](https://www.youtube.com/watch?v=jZvnkf_HgcY)

See all the hardware I recommend at <https://l.technotim.live/gear>

Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files.

`mysql_backup.sh`

```shell
#! /bin/bash

BACKUP_DIR="/home"
MYSQL_USER="root"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="your my sql password"
MYSQLDUMP=/usr/bin/mysqldump
MYSQL_HOST="mysql"
MYSQL_PORT="3306"

databases=`$MYSQL --user=$MYSQL_USER --host $MYSQL_HOST --port $MYSQL_PORT -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  $MYSQLDUMP --host $MYSQL_HOST --port $MYSQL_PORT --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db.gz"
done
```
