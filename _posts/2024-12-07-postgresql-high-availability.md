---
layout: post
title: "PostgresSQL Clustering the hard way..."
date: 2024-12-07 08:00:00 -0500
categories: self-hosted
tags: postgresql homelab
image:
 path: /assets/img/headers/postgres-high-availability-hero.webp
 lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APwX+G3x7+GekfCm8064/ZK+BesT/YLITXeo618cGF80Nu9ldXF4kXxbS5hubyQ2d8w0a+0eygvLaRorHybp4Y/7HybJMXiOHKOKhxBmmHpewqRlhaWFyFwvFOouStVyepWUdJxkqk6s5Rl/ETV5fy5mOa4WjnE6U8ky+vUVaP7+pic4TkruDcqVPM4Uue7jNOEYRUov3LNcv5++KPEfh7WvEviLWdK8A6B4U0zVtd1bU9N8LaNqfiu60fw1YX9/cXVnoGlXOu69q+uXGm6Nbyx6dYz6zqup6rNa20Umo6he3bTXMv4/KnOEpRdaU3GTi5yhSUptOznJQhCCcmrtQhGKbtGMVZL9FjOEkpKjGCkk1CMqjjBNXUYuc5TajsnKUpNL3pN3Z//Z
---

Today is the day that you start running PostgresSQL in a cluster!  In this tutorial we'll be setting up a production ready Postgres cluster that's highly available and fault tolerant using PostgreSQL, etcd, Patroni, HA Proxy, and keepalived.  This resilient combination will ensure that you can always reach your database even when a node in the cluster goes down!

{% include embed/youtube.html id='RHwglGf_z40' %}
📺 [Watch Video](https://www.youtube.com/watch?v=RHwglGf_z40)

## Nodes

```bash
# ha proxy
192.168.60.100 # haproxy-01
192.168.60.101 # haproxy-02
192.168.60.102 # haproxy-03

# postgres
192.168.60.103 # postgres-01
192.168.60.104 # postgres-02
192.168.60.105 # postgres-03
```

## PostgreSQL

On postgres nodes install latest postgres.

Install updated postgres repositories.

```bash
sudo apt update
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

Install postgres and additional modules.

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
```

We'll configure postgres later.

Stop and disable the service because Patroni will handle the lifecycle of postgres

```bash
sudo systemctl stop postgresql
sudo systemctl disable postgresql
```

## etcd

### Install

This should be installed on the postgres servers.

Make sure you have `wget` and `curl`

```bash
sudo apt update
sudo apt-get install -y wget curl
```

Find latest release.

<https://github.com/etcd-io/etcd/releases>

```bash
wget https://github.com/etcd-io/etcd/releases/download/v3.5.17/etcd-v3.5.17-linux-amd64.tar.gz
```

Uncompress and rename.

```bash
tar xvf etcd-v3.5.17-linux-amd64.tar.gz
mv etcd-v3.5.17-linux-amd64 etcd
```

Move all binaries into `/usr/local/bin/` for later use.

```bash
sudo mv etcd/etcd* /usr/local/bin/
```

Check `etcd` version

```bash
etcd --version
```

Should see something like:

```log
etcd Version: 3.5.17
Git SHA: 507c0deß
Go Version: go1.22.9obs
Go OS/Arch: linux/amd64
```

```bash
etcdctl version
```

Should see something like:

```log
etcdctl version: 3.5.17
API version: 3.5
```

Let's create a user for `etcd` service.

```bash
sudo useradd --system --home /var/lib/etcd --shell /bin/false etcd
```

Before configuring `etcd`, we need to repeat all of these steps for the other 2 nodes.

Let's configure `etcd`.

Make dir and edit file.

```bash
sudo mkdir -p /etc/etcd
sudo mkdir -p /etc/etcd/ssl
```

### Certificates

We'll be securing the communication between `etcd` nodes and postgres.

On our own machine (not servers!)

Make sure `openssl` is installed

Windows

```powershell
winget install -e --id FireDaemon.OpenSSL
```

macOS

```bash
brew install openssl
```

Linux

```bash
sudo apt install openssl
```

Verify it's installed and working

```bash
openssl version
```

Should see something like:

```bash
OpenSSL 3.4.0 22 Oct 2024 (Library: OpenSSL 3.4.0 22 Oct 2024)
```

Now let's generate and configure certs

```bash
mkdir certs
cd certs
```

Generate cert authority

```bash
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=etcd-ca" -days 7300 -out ca.crt
```

Generate certificate each node. Note, pay attention to SANS, I am using IP, update with your IP and oh DNS/hostname.

node1

```bash
# Generate a private key
openssl genrsa -out etcd-node1.key 2048

# Create temp file for config
cat > temp.cnf <<EOF
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
[ req_distinguished_name ]
[ v3_req ]
subjectAltName = @alt_names
[ alt_names ]
IP.1 = 192.168.60.103
IP.2 = 127.0.0.1
EOF

# Create a csr
openssl req -new -key etcd-node1.key -out etcd-node1.csr \
  -subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/OU=YourUnit/CN=etcd-node1" \
  -config temp.cnf

# Sign the cert
openssl x509 -req -in etcd-node1.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out etcd-node1.crt -days 7300 -sha256 -extensions v3_req -extfile temp.cnf

# Verify the cert and be sure you see Subject Name Alternative

openssl x509 -in etcd-node1.crt -text -noout | grep -A1 "Subject Alternative Name"

# Remove temp file

rm temp.cnf
```

node 2

```bash
# Generate a private key
openssl genrsa -out etcd-node2.key 2048

# Create temp file for config
cat > temp.cnf <<EOF
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
[ req_distinguished_name ]
[ v3_req ]
subjectAltName = @alt_names
[ alt_names ]
IP.1 = 192.168.60.104
IP.2 = 127.0.0.1
EOF

# Create a csr
openssl req -new -key etcd-node2.key -out etcd-node2.csr \
  -subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/OU=YourUnit/CN=etcd-node2" \
  -config temp.cnf

# Sign the cert
openssl x509 -req -in etcd-node2.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out etcd-node2.crt -days 7300 -sha256 -extensions v3_req -extfile temp.cnf

# Verify the cert and be sure you see Subject Name Alternative
openssl x509 -in etcd-node2.crt -text -noout | grep -A1 "Subject Alternative Name"

# Remove temp file
rm temp.cnf
```

node3

```bash
# Generate a private key
openssl genrsa -out etcd-node3.key 2048

# Create temp file for config
cat > temp.cnf <<EOF
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
[ req_distinguished_name ]
[ v3_req ]
subjectAltName = @alt_names
[ alt_names ]
IP.1 = 192.168.60.105
IP.2 = 127.0.0.1
EOF

# Create a csr
openssl req -new -key etcd-node3.key -out etcd-node3.csr \
  -subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/OU=YourUnit/CN=etcd-node3" \
  -config temp.cnf

#Sign the cert
openssl x509 -req -in etcd-node3.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out etcd-node3.crt -days 7300 -sha256 -extensions v3_req -extfile temp.cnf

# Verify the cert and be sure you see Subject Name Alternative
openssl x509 -in etcd-node3.crt -text -noout | grep -A1 "Subject Alternative Name"

# Remove temp file
rm temp.cnf
```

List all files

```bash
ls
```

Should see:

```bash
ca.crt
ca.key
ca.srl
etcd-node1.crt
etcd-node1.csr
etcd-node2.crt
etcd-node2.csr
etcd-node2.key
etcd-node3.crt
etcd-node3.csr
etcd-node3.key
```

Secure copy (`scp`) the certs to each node:

```bash
scp ca.crt etcd-node1.crt etcd-node1.key serveradmin@192.168.60.103:/tmp/
scp ca.crt etcd-node2.crt etcd-node2.key serveradmin@192.168.60.104:/tmp/
scp ca.crt etcd-node3.crt etcd-node3.key serveradmin@192.168.60.105:/tmp/
```

Should see:

`ssh` into each node

We need to move certs from `/tmp` to ssl location (`/etc/etcd/ssl`)

```bash
sudo mkdir -p /etc/etcd/ssl
sudo mv /tmp/etcd-node*.crt /etc/etcd/ssl/
sudo mv /tmp/etcd-node*.key /etc/etcd/ssl/
sudo mv /tmp/ca.crt /etc/etcd/ssl/
sudo chown -R etcd:etcd /etc/etcd/
sudo chmod 600 /etc/etcd/ssl/etcd-node*.key
sudo chmod 644 /etc/etcd/ssl/etcd-node*.crt /etc/etcd/ssl/ca.crt
```

### Configure

Create our config

```bash
sudo nano /etc/etcd/etcd.env
```

node1

```bash
ETCD_NAME="postgresql-01"
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_INITIAL_CLUSTER="postgresql-01=https://192.168.60.103:2380,postgresql-02=https://192.168.60.104:2380,postgresql-03=https://192.168.60.105:2380"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.60.103:2380"
ETCD_LISTEN_PEER_URLS="https://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="https://0.0.0.0:2379"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.60.103:2379"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_CERT_FILE="/etc/etcd/ssl/etcd-node1.crt"
ETCD_KEY_FILE="/etc/etcd/ssl/etcd-node1.key"
ETCD_PEER_CLIENT_CERT_AUTH="true"
ETCD_PEER_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_PEER_CERT_FILE="/etc/etcd/ssl/etcd-node1.crt"
ETCD_PEER_KEY_FILE="/etc/etcd/ssl/etcd-node1.key"
```

node2

```bash
ETCD_NAME="postgresql-02"
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_INITIAL_CLUSTER="postgresql-01=https://192.168.60.103:2380,postgresql-02=https://192.168.60.104:2380,postgresql-03=https://192.168.60.105:2380"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.60.104:2380"
ETCD_LISTEN_PEER_URLS="https://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="https://0.0.0.0:2379"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.60.104:2379"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_CERT_FILE="/etc/etcd/ssl/etcd-node2.crt"
ETCD_KEY_FILE="/etc/etcd/ssl/etcd-node2.key"
ETCD_PEER_CLIENT_CERT_AUTH="true"
ETCD_PEER_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_PEER_CERT_FILE="/etc/etcd/ssl/etcd-node2.crt"
ETCD_PEER_KEY_FILE="/etc/etcd/ssl/etcd-node2.key"
```

node 3

```bash
ETCD_NAME="postgresql-03"
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_INITIAL_CLUSTER="postgresql-01=https://192.168.60.103:2380,postgresql-02=https://192.168.60.104:2380,postgresql-03=https://192.168.60.105:2380"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.60.105:2380"
ETCD_LISTEN_PEER_URLS="https://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="https://0.0.0.0:2379"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.60.105:2379"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_CERT_FILE="/etc/etcd/ssl/etcd-node3.crt"
ETCD_KEY_FILE="/etc/etcd/ssl/etcd-node3.key"
ETCD_PEER_CLIENT_CERT_AUTH="true"
ETCD_PEER_TRUSTED_CA_FILE="/etc/etcd/ssl/ca.crt"
ETCD_PEER_CERT_FILE="/etc/etcd/ssl/etcd-node3.crt"
ETCD_PEER_KEY_FILE="/etc/etcd/ssl/etcd-node3.key"
```

Now let's create a service for etcd on all 3 nodes

```bash
sudo nano /etc/systemd/system/etcd.service
```

Contents of service file, same for all 3 nodes

```bash
[Unit]
Description=etcd key-value store
Documentation=https://github.com/etcd-io/etcd
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
WorkingDirectory=/var/lib/etcd
EnvironmentFile=/etc/etcd/etcd.env
ExecStart=/usr/local/bin/etcd
Restart=always
RestartSec=10s
LimitNOFILE=40000
User=etcd
Group=etcd

[Install]
WantedBy=multi-user.target
```

We need to create a directory for `etcd` `ETCD_DATA_DIR` defined in service file.

```bash
sudo mkdir -p /var/lib/etcd 
sudo chown -R etcd:etcd /var/lib/etcd
```

### Running etcd

Reload daemon and enable the service

```bash
sudo systemctl daemon-reload
sudo systemctl enable etcd
```

Start etcd and check status

this looks like it's hanging on the first node but once you add another node it will complete

```bash
sudo systemctl start etcd
sudo systemctl status etcd
```

Should see something like:

```log
● etcd.service - etcd key-value store
     Loaded: loaded (/etc/systemd/system/etcd.service; enabled; preset: enabled)
     Active: active (running) since Mon 2024-12-02 14:09:30 CST; 2s ago
       Docs: https://github.com/etcd-io/etcd
   Main PID: 7266 (etcd)
      Tasks: 9 (limit: 4612)
     Memory: 29.3M (peak: 30.0M)
        CPU: 246ms
     CGroup: /system.slice/etcd.service
             └─7266 /usr/local/bin/etcd
```

You can also check the logs for `etcd` by running:

```bash
journalctl -xeu etcd.service
```

Should see something like:

```log
░░ Subject: A start job for unit etcd.service has finished successfully
░░ Defined-By: systemd
░░ Support: http://www.ubuntu.com/support
░░
░░ A start job for unit etcd.service has finished successfully.
░░
░░ The job identifier is 5757.
Dec 02 14:09:30 postgres-01 etcd[7266]: {"level":"info","ts":"2024-12-02T14:09:30.862122-0600","caller":"v3rpc/health.go:61","msg":"grpc service status changed","service":"","status":"SERVING"}
Dec 02 14:09:30 postgres-01 etcd[7266]: {"level":"info","ts":"2024-12-02T14:09:30.862347-0600","caller":"embed/serve.go:187","msg":"serving client traffic insecurely; this is strongly discouraged!","traffic":"grpc+http","address":"[::]:2379"}
```

### Verification

Once cluster is running, we should verify it's working on each by running

```bash
etcdctl endpoint health
etcdctl member list
```

Should see something like on node1:

```log
127.0.0.1:2379 is healthy: successfully committed proposal: took = 1.786976ms
eb8ee14ab5150b4, started, postgresql-01, http://192.168.60.103:2380, http://192.168.60.103:2379, false
34e89b244664f02d, started, postgresql-02, http://192.168.60.104:2380, http://192.168.60.104:2379, false
8ee2a9473a41c400, started, postgresql-03, http://192.168.60.105:2380, http://192.168.60.105:2379, false
```

Do this for all 3 nodes

Now we should now edit the variables since the cluster is bootstrapped

Then restart etcd and verify the cluster is still working

```bash
sudo systemctl restart etcd
```

If you want to run the following commands without sudo, you can run:

```bash
sudo usermod -aG etcd $USER
```

```bash
 sudo etcdctl \
--endpoints=https://127.0.0.1:2379 \
--cacert=/etc/etcd/ssl/ca.crt \
--cert=/etc/etcd/ssl/etcd-node1.crt \
--key=/etc/etcd/ssl/etcd-node1.key \
endpoint health

sudo etcdctl \
--endpoints=https://127.0.0.1:2379 \
--cacert=/etc/etcd/ssl/ca.crt \
--cert=/etc/etcd/ssl/etcd-node1.crt \
--key=/etc/etcd/ssl/etcd-node1.key \
member list
```

Should see something like

```log
https://127.0.0.1:2379 is healthy: successfully committed proposal: took = 4.611121ms
59afb19d7cb2565d, started, postgresql-01, https://192.168.60.103:2380, https://192.168.60.103:2379, false
6338565ebcb76aa2, started, postgresql-02, https://192.168.60.104:2380, https://192.168.60.104:2379, false
9d74b3125c745c74, started, postgresql-03, https://192.168.60.105:2380, https://192.168.60.105:2379, false
```

You can check to see who is leader by running

```bash
sudo etcdctl \
  --endpoints=https://192.168.60.103:2379,https://192.168.60.104:2379,https://192.168.60.105:2379 \
  --cacert=/etc/etcd/ssl/ca.crt \
  --cert=/etc/etcd/ssl/etcd-node1.crt \
  --key=/etc/etcd/ssl/etcd-node1.key \
  endpoint status --write-out=table
```

You should see something like this, specifically one of the nodes `IS LEADER = true`

```bash
+-----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
|          ENDPOINT           |        ID        | VERSION | DB SIZE | IS LEADER | IS LEARNER | RAFT TERM | RAFT INDEX | RAFT APPLIED INDEX | ERRORS |
+-----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
| https://192.168.60.103:2379 | 59afb19d7cb2565d |  3.5.17 |   20 kB |      true |      false |         2 |         12 |                 12 |        |
| https://192.168.60.104:2379 | 6338565ebcb76aa2 |  3.5.17 |   20 kB |     false |      false |         2 |         12 |                 12 |        |
| https://192.168.60.105:2379 | 9d74b3125c745c74 |  3.5.17 |   20 kB |     false |      false |         2 |         12 |                 12 |        |
+-----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
```

## PostgreSQL and Patroni

## PostgreSQL Certificates

Once this is all set up and working, we can now configure `postgres` and `patroni`.

We need to create some dirs for `postgres`

```bash
sudo mkdir -p /var/lib/postgresql/data
sudo mkdir -p /var/lib/postgresql/ssl
```

Notice we are using ssl, we need to generate a certificate

Generate a self-signed certificate

(this will last 20 years)

```bash
openssl genrsa -out server.key 2048 # private key
```

```bash
openssl req -new -key server.key -out server.req # csr
```

```bash
openssl req -x509 -key server.key -in server.req -out server.crt -days 7300 # generate cert, valid for 20 years
```

Update permissions

```bash
chmod 600 server.key
```

Move files to cert location

```bash
sudo mv server.crt server.key server.req /var/lib/postgresql/ssl
```

After doing this, we need to copy this to our other servers

Copy files locally from (your local machine!) to node1, node2, node3 using `scp`

`scp` them to node1, node2, and node3

```bash
scp server.crt server.key server.req serveradmin@192.168.60.103:/tmp
scp server.crt server.key server.req serveradmin@192.168.60.104:/tmp
scp server.crt server.key server.req serveradmin@192.168.60.105:/tmp
```

On the servers (not your local machine) move files

```bash
cd /tmp
sudo mv server.crt server.key server.req /var/lib/postgresql/ssl
```

Update permissions on certificate

```bash
sudo chmod 600 /var/lib/postgresql/ssl/server.key
sudo chmod 644 /var/lib/postgresql/ssl/server.crt
sudo chmod 600 /var/lib/postgresql/ssl/server.req
sudo chown postgres:postgres /var/lib/postgresql/data
sudo chown postgres:postgres /var/lib/postgresql/ssl/server.*
```

We will need to give the postgres user read access to the etcd certificates using acls

```bash
sudo apt update
sudo apt install -y acl
```

node1

```bash
sudo setfacl -m u:postgres:r /etc/etcd/ssl/ca.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node1.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node1.key
```

node2

```bash
sudo setfacl -m u:postgres:r /etc/etcd/ssl/ca.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node2.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node2.key
```

node3

```bash
sudo setfacl -m u:postgres:r /etc/etcd/ssl/ca.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node3.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node3.key
```

Now that we have postgres certs configured, it's now time to configure patroni to operate or drive postgres

## Patroni

### Installing Patroni

```bash
sudo apt install -y patroni
```

`ssh` into node1

Make a dir for `patroni`

```bash
sudo mkdir -p /etc/patroni/
```

### Configuring Patroni

Create a config file and edit

```bash
sudo nano /etc/patroni/config.yml
```

node1

```yaml
scope: postgresql-cluster
namespace: /service/
name: postgresql-01  # node1

etcd3:
  hosts: 192.168.60.103:2379,192.168.60.104:2379,192.168.60.105:2379  # etcd cluster nodes
  protocol: https
  cacert: /etc/etcd/ssl/ca.crt
  cert: /etc/etcd/ssl/etcd-node1.crt  # node1's etcd certificate
  key: /etc/etcd/ssl/etcd-node1.key  # node1's etcd key

restapi:
  listen: 0.0.0.0:8008
  connect_address: 192.168.60.103:8008  # IP for node1's REST API
  certfile: /var/lib/postgresql/ssl/server.pem

bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 10
    maximum_lag_on_failover: 1048576  # Failover parameters
    postgresql:
        parameters:
            ssl: 'on'  # Enable SSL
            ssl_cert_file: /var/lib/postgresql/ssl/server.crt  # PostgreSQL server certificate
            ssl_key_file: /var/lib/postgresql/ssl/server.key  # PostgreSQL server key
        pg_hba:  # Access rules
        - hostssl replication replicator 127.0.0.1/32 md5
        - hostssl replication replicator 192.168.60.103/32 md5
        - hostssl replication replicator 192.168.60.104/32 md5
        - hostssl replication replicator 192.168.60.105/32 md5
        - hostssl all all 127.0.0.1/32 md5
        - hostssl all all 0.0.0.0/0 md5
  initdb:
    - encoding: UTF8
    - data-checksums

postgresql:
  listen: 0.0.0.0:5432
  connect_address: 192.168.60.103:5432  # IP for node1's PostgreSQL
  data_dir: /var/lib/postgresql/data
  bin_dir: /usr/lib/postgresql/17/bin  # Binary directory for PostgreSQL 17
  authentication:
    superuser:
      username: postgres
      password: cnV2abjbDpbh64e12987wR4mj5kQ3456Y0Qf  # Superuser password - be sure to change
    replication:
      username: replicator
      password: sad9a23jga8jsuedrwtsskj74567suiuwe23  # Replication password - be sure to change
  parameters:
    max_connections: 100
    shared_buffers: 256MB

tags:
  nofailover: false
  noloadbalance: false
  clonefrom: false
```

node2

```yaml
scope: postgresql-cluster
namespace: /service/
name: postgresql-02  # Unique name for Node 2

etcd3:
  hosts: 192.168.60.103:2379,192.168.60.104:2379,192.168.60.105:2379  # etcd cluster nodes
  protocol: https
  cacert: /etc/etcd/ssl/ca.crt
  cert: /etc/etcd/ssl/etcd-node2.crt  # Node 2's etcd certificate
  key: /etc/etcd/ssl/etcd-node2.key  # Node 2's etcd key

restapi:
  listen: 0.0.0.0:8008
  connect_address: 192.168.60.104:8008  # IP for Node 2's REST API
  certfile: /var/lib/postgresql/ssl/server.pem

bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 10
    maximum_lag_on_failover: 1048576
    postgresql:
        parameters:
        ssl: 'on'
        ssl_cert_file: /var/lib/postgresql/ssl/server.crt
        ssl_key_file: /var/lib/postgresql/ssl/server.key
        pg_hba:
        - hostssl replication replicator 127.0.0.1/32 md5
        - hostssl replication replicator 192.168.60.103/32 md5
        - hostssl replication replicator 192.168.60.104/32 md5
        - hostssl replication replicator 192.168.60.105/32 md5
        - hostssl all all 127.0.0.1/32 md5
        - hostssl all all 0.0.0.0/0 md5
  initdb:
    - encoding: UTF8
    - data-checksums

postgresql:
  listen: 0.0.0.0:5432
  connect_address: 192.168.60.104:5432  # IP for Node 2's PostgreSQL
  data_dir: /var/lib/postgresql/data
  bin_dir: /usr/lib/postgresql/17/bin
  authentication:
    superuser:
      username: postgres
      password: cnV2abjbDpbh64e12987wR4mj5kQ3456Y0Qf  # Superuser password (provided)
    replication:
      username: replicator
      password: sad9a23jga8jsuedrwtsskj74567suiuwe23  # Replication password (provided)
  parameters:
    max_connections: 100
    shared_buffers: 256MB

tags:
  nofailover: false
  noloadbalance: false
  clonefrom: false
```

node3

```yaml
scope: postgresql-cluster
namespace: /service/
name: postgresql-03  # Unique name for Node 3

etcd3:
  hosts: 192.168.60.103:2379,192.168.60.104:2379,192.168.60.105:2379 #etcd cluster nodes
  protocol: https
  cacert: /etc/etcd/ssl/ca.crt
  cert: /etc/etcd/ssl/etcd-node3.crt  # Node 3's etcd certificate
  key: /etc/etcd/ssl/etcd-node3.key  # Node 3's etcd key

restapi:
  listen: 0.0.0.0:8008
  connect_address: 192.168.60.105:8008  # IP for Node 3's REST API
  certfile: /var/lib/postgresql/ssl/server.pem

bootstrap:
  dcs:
    ttl: 30
    loop_wait: 10
    retry_timeout: 10
    maximum_lag_on_failover: 1048576
    postgresql:
        parameters:
        ssl: 'on'
        ssl_cert_file: /var/lib/postgresql/ssl/server.crt
        ssl_key_file: /var/lib/postgresql/ssl/server.key
        pg_hba:
        - hostssl replication replicator 127.0.0.1/32 md5
        - hostssl replication replicator 192.168.60.103/32 md5
        - hostssl replication replicator 192.168.60.104/32 md5
        - hostssl replication replicator 192.168.60.105/32 md5
        - hostssl all all 127.0.0.1/32 md5
        - hostssl all all 0.0.0.0/0 md5
  initdb:
    - encoding: UTF8
    - data-checksums

postgresql:
  listen: 0.0.0.0:5432
  connect_address: 192.168.60.105:5432  # IP for Node 3's PostgreSQL
  data_dir: /var/lib/postgresql/data
  bin_dir: /usr/lib/postgresql/17/bin
  authentication:
    superuser:
      username: postgres
      password: "cnV2abjbDpbh64e12987wR4mj5kQ3456Y0Qf"  # Superuser password (provided)
    replication:
      username: replicator
      password: sad9a23jga8jsuedrwtsskj74567suiuwe23  # Replication password (provided)
  parameters:
    max_connections: 100
    shared_buffers: 256MB

tags:
  nofailover: false
  noloadbalance: false
  clonefrom: false

```

### Patroni Certificates

Let's also use a certificate for this, requires a pem

```bash
sudo sh -c 'cat /var/lib/postgresql/ssl/server.crt /var/lib/postgresql/ssl/server.key > /var/lib/postgresql/ssl/server.pem'
sudo chown postgres:postgres /var/lib/postgresql/ssl/server.pem
sudo chmod 600 /var/lib/postgresql/ssl/server.pem
```

We can verify with:

```bash
sudo openssl x509 -in /var/lib/postgresql/ssl/server.pem -text -noout

```

### Starting Patroni and HA Cluster

Restart the service

```bash
 sudo systemctl restart patroni
```

Check logs

```bash
journalctl -u patroni -f
```

Should see something like:

```log
Dec 03 22:16:05 postgres-01 patroni[770]: 2024-12-03 22:16:05,399 INFO: no action. I am (postgresql-01), the leader with the lock
Dec 03 22:16:15 postgres-01 patroni[770]: 2024-12-03 22:16:15,399 INFO: no action. I am (postgresql-01), the leader with the lock
```

and

```log
Dec 03 22:16:21 postgres-02 patroni[768]: 2024-12-03 22:16:21,780 INFO: Lock owner: postgresql-01; I am postgresql-02
Dec 03 22:16:21 postgres-02 patroni[768]: 2024-12-03 22:16:21,823 INFO: bootstrap from leader 'postgresql-01' in progress
```

### Reconfiguring our etcd Cluster

```bash
sudo nano /etc/etcd/etcd.env
```

Change

```bash
ETCD_INITIAL_CLUSTER_STATE="new"
```

to

```bash
ETCD_INITIAL_CLUSTER_STATE="existing"
```

Do this on all 3 nodes!

### Verifying Our Postgres Cluster

We now have a ha postgres cluster!

However we don't always know who the leader is so we can't use an IP

We can test the patroni endpoint to see who is leader

```bash
curl -k https://192.168.60.103:8008/primary
curl -k https://192.168.60.104:8008/primary
curl -k https://192.168.60.105:8008/primary
```

### Editing your pg_hba after bootstrapping

If you ever want to see your global config you can with

```bash
sudo patronictl -c /etc/patroni/config.yml show-config
```

If you ever want to edit it, you can with:

```bash
sudo patronictl -c /etc/patroni/config.yml edit-config
```

After saving these will be replicated to all nodes, note you might want to update your boostrap config at some pouint

## HA Proxy

### Installing HA Proxy

this is where ha proxy comes in

switch nodes

install ha proxy

```bash
sudo apt -y install haproxy
```

Once installed we need to add some config

```bash
sudo nano /etc/haproxy/haproxy.cfg
```

```conf
frontend postgres_frontend
    bind *:5432
    mode tcp
    default_backend postgres_backend

backend postgres_backend
    mode tcp
    option tcp-check
    option httpchk GET /primary  # patroni provides an endpoint to check node roles
    http-check expect status 200  # expect 200 for the primary node
    timeout connect 5s
    timeout client 30s
    timeout server 30s
    server postgresql-01 192.168.60.103:5432 port 8008 check check-ssl verify none
    server postgresql-02 192.168.60.104:5432 port 8008 check check-ssl verify none
    server postgresql-03 192.168.60.105:5432 port 8008 check check-ssl verify none
```

Do this for all 3 nodes

### Starting HA Proxy

restart

```bash
sudo systemctl reload haproxy
```

check logs

```bash
sudo tail -f /var/log/syslog | grep haproxy
```

## keepalived

### Installing keepalived

Now we need to install keepalived to create a VIP

```bash
sudo apt update
sudo apt install keepalived -y
```

### Confuring keepalived

Now we need to apply a configuration file

```bash
sudo nano /etc/keepalived/keepalived.conf
```

haproxy1

```conf
global_defs {
    enable_script_security
    script_user keepalived_script
}

vrrp_script check_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    fall 3
    rise 2
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0 # update with your nic
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass tDHjh7by # change
    }
    virtual_ipaddress {
        192.168.60.110
    }
    track_script {
        check_haproxy
    }
}

```

haproxy2

```conf
global_defs {
    enable_script_security
    script_user keepalived_script
}

vrrp_script check_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    fall 3
    rise 2
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0 # update with your nic
    virtual_router_id 51
    priority 90
    advert_int 1
    authentication {
        auth_type PASS # change
        auth_pass tDHjh7by # change
    }
    virtual_ipaddress {
        192.168.60.110
    }
    track_script {
        check_haproxy
    }
}
```

haproxy3

```conf
global_defs {
    enable_script_security
    script_user keepalived_script
}

vrrp_script check_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 2
    fall 3
    rise 2
}

vrrp_instance VI_1 {
    state BACKUP
    interface eth0 # update with your nic
    virtual_router_id 51
    priority 80
    advert_int 1
    authentication {
        auth_type PASS # change
        auth_pass tDHjh7by # change
    }
    virtual_ipaddress {
        192.168.60.110
    }
    track_script {
        check_haproxy
    }
}
```

Create a check script on each

```bash
sudo nano /etc/keepalived/check_haproxy.sh
```

```bash
#!/bin/bash

# Define the port to check (e.g., HAProxy frontend port)
PORT=5432

# Check if HAProxy is running
if ! pidof haproxy > /dev/null; then
    echo "HAProxy is not running"
    exit 1
fi

# Check if HAProxy is listening on the expected port
if ! ss -ltn | grep -q ":${PORT}"; then
    echo "HAProxy is not listening on port ${PORT}"
    exit 2
fi

# All checks passed
exit 0
```

we need to add a user to execute these scripts

```bash
sudo useradd -r -s /bin/false keepalived_script
```

```bash
sudo chmod +x /etc/keepalived/check_haproxy.sh
sudo chown keepalived_script:keepalived_script /etc/keepalived/check_haproxy.sh
sudo chmod 700 /etc/keepalived/check_haproxy.sh
```

### Starting keepalived

```bash
sudo systemctl restart keepalived
```

### Verifying keepalived

Check logs

```bash
sudo journalctl -u keepalived -f
```

we should not be able to ping the VIP

```bash
ping 192.168.60.110
```

## PGAdmin

### Connecting with PGAdmin

Connected with a client

<https://www.pgadmin.org/>

Connect to your VIP `192.168.60.110` and use the `postgres` user and password.

### Adding Data

Create a table with data

```sql
-- Create a table for Nintendo characters
CREATE TABLE nintendo_characters (
    character_id SERIAL PRIMARY KEY, -- Unique identifier for each character
    name VARCHAR(50) NOT NULL,       -- Name of the character
    game_series VARCHAR(50),         -- Game series the character belongs to
    debut_year INT,                  -- Year the character debuted
    description TEXT,                -- Brief description of the character
    is_playable BOOLEAN DEFAULT TRUE -- Whether the character is playable
);

-- Insert some example characters
INSERT INTO nintendo_characters (name, game_series, debut_year, description, is_playable)
VALUES
    ('Mario', 'Super Mario', 1981, 'The iconic plumber and hero of the Mushroom Kingdom.', TRUE),
    ('Link', 'The Legend of Zelda', 1986, 'A courageous hero tasked with saving Hyrule.', TRUE),
    ('Samus Aran', 'Metroid', 1986, 'A bounty hunter equipped with a powerful Power Suit.', TRUE),
    ('Donkey Kong', 'Donkey Kong', 1981, 'A powerful gorilla and protector of the jungle.', TRUE),
    ('Princess Zelda', 'The Legend of Zelda', 1986, 'The princess of Hyrule and possessor of the Triforce of Wisdom.', FALSE),
    ('Bowser', 'Super Mario', 1985, 'The King of the Koopas and Marios arch-nemesis.', FALSE),
    ('Kirby', 'Kirby', 1992, 'A pink puffball with the ability to inhale enemies and copy their powers.', TRUE),
    ('Pikachu', 'Pokémon', 1996, 'An Electric-type Pokémon and mascot of the Pokémon series.', TRUE),
    ('Fox McCloud', 'Star Fox', 1993, 'A skilled pilot and leader of the Star Fox team.', TRUE),
    ('Captain Falcon', 'F-Zero', 1990, 'A bounty hunter and expert racer known for his Falcon Punch.', TRUE);

-- Select all rows to verify the table creation and data insertion
SELECT * FROM nintendo_characters;

```

```sql
SELECT * FROM nintendo_characters;
```

insert more characters

```sql
-- Insert additional Nintendo characters into the table
INSERT INTO nintendo_characters (name, game_series, debut_year, description, is_playable)
VALUES
    ('Yoshi', 'Super Mario', 1990, 'A friendly green dinosaur and Marios trusted companion.', TRUE),
    ('Luigi', 'Super Mario', 1983, 'Marios younger brother and a skilled ghost hunter.', TRUE),
    ('King Dedede', 'Kirby', 1992, 'The self-proclaimed king of Dream Land and occasional ally of Kirby.', TRUE),
    ('Meta Knight', 'Kirby', 1993, 'A mysterious swordsman who often challenges Kirby.', TRUE),
    ('Marth', 'Fire Emblem', 1990, 'A legendary hero and prince from the Fire Emblem series.', TRUE),
    ('Ness', 'EarthBound', 1994, 'A young boy with psychic powers and a bat-wielding hero.', TRUE),
    ('Jigglypuff', 'Pokémon', 1996, 'A Balloon Pokémon known for its singing abilities.', TRUE),
    ('Villager', 'Animal Crossing', 2001, 'A customizable character from the Animal Crossing series.', TRUE),
    ('Isabelle', 'Animal Crossing', 2012, 'A cheerful assistant who helps manage your town.', TRUE),
    ('Ganondorf', 'The Legend of Zelda', 1998, 'The King of Evil and nemesis of Link.', TRUE);

```

```sql
SELECT * FROM nintendo_characters;
```

If you want to clean this data up, you can `DROP` the table

```sql
-- Drop the nintendo_characters table if it exists
DROP TABLE IF EXISTS nintendo_characters;
```

## Troubleshooting

Reset all data but certs and start over

```bash
sudo systemctl stop patroni
sudo systemctl stop etcd
sudo rm -rf /var/lib/etcd/
sudo rm -rf /var/lib/postgresql/data/
sudo mkdir -p /var/lib/postgresql/data
sudo mkdir -p /var/lib/etcd/
sudo chown etcd:etcd /var/lib/etcd/
sudo setfacl -m u:postgres:r /etc/etcd/ssl/ca.crt
sudo setfacl -m u:postgres:r /etc/etcd/ssl/etcd-node*
```

```bash
sudo systemctl start etcd
sudo systemctl start patroni
```

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Today, I teach you how you can self-host a production-ready PostgreSQL cluster. I&#39;ve even included all of the copy pasta commands!<a href="https://t.co/OGHUGfDEs2">https://t.co/OGHUGfDEs2</a> <a href="https://t.co/9NWtYcWcO6">pic.twitter.com/9NWtYcWcO6</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1865482821151736011?ref_src=twsrc%5Etfw">December 7, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files

🤝 Support me and [help keep this site ad-free!](/sponsor)
