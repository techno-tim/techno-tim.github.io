---
layout: post
title: "Migrate Your Databases to Kubernetes and Docker"
date: 2020-10-17 09:00:00 -0500
categories: self-hosted
tags: homelab rancher kubernetes docker self-hosted mysql database portainer
image:
  path: /assets/img/headers/library-floors.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APVPDCztB4psr67uJn0nxF8NrSG5sbm9spG1fxra6ncXOslbm71JVFtKVdtPGYblg7LLau0bRfIxpRq2UUo3dVXlFT0pPktypQi+ZbNptLR8+59FKXs0pSvONqPuRlKH8aM01zOU39q8rWUnfSNzrPFXwoudD8T+I9EtfHfjI2uj69rGl2x/4SjxrHmDT9QuLSH93H4vWOP93CvyRqqJ91AFAFc9Nc9OnNyd5wjJ2p4a15RTdr4du133ZbnKLcU5Wi7fxK3TT/n4f//Z

---
Have you been putting off migrating your database to Docker and Kubernetes like I have?  Well wait no longer.It's simple using this step-by-step tutorial.Today, we'll move a database that's on a virtual machine to a container that's running in kubernetes.Oh yeah, this will also work if it's a bare metal server too, duh.🙂

{% include embed/youtube.html id='jZvnkf_HgcY' %}

📺 [Watch Video](https://www.youtube.com/watch?v=jZvnkf_HgcY)

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

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
