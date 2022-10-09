---
layout: post
title: "Encrypt Your Sensitive Information Before Storing It - Encrypting with Mozilla SOPS and AGE"
date: 2022-10-01 09:00:00 -0500
categories: homelab
tags: git kubernetes secrets security sops age
---

[![Encrypt Your Sensitive Information Before Storing It - Encrypting with Mozilla SOPS and AGE](https://img.youtube.com/vi/1BquzE3Yb4I/0.jpg)](https://www.youtube.com/watch?v=1BquzE3Yb4I "Encrypt Your Sensitive Information Before Storing It - Encrypting with Mozilla SOPS and AGE")

Committing secrets to your Git Repo can expose information like passwords, access tokens, and other types of sensitive information.  Some might think that committing secrets to a private Git Repo is OK, but I am here to tell you it's not.  If you're going to commit secrets to a git repo, private or public, you should encrypt them first using Mozilla SOPS (Secret Operations) and AGE.  SOPS is an editor of encrypted files that supports YAML, JSON, ENV, INI and BINARY formats and encrypts with AWS KMS, GCP KMS, Azure Key Vault, age, and PGP.  Age is a simple, modern, and secure file encryption tool, format, and build using Go.  It can encrypt and decrypt your files making then safe enough to commit to your Git repos!

A HUGE thanks to Datree for sponsoring this video!  
Combat misconfigurations. Empower engineers.
<https://www.datree.io>

📺 [Watch Video](https://www.youtube.com/watch?v=1BquzE3Yb4I)

## Install SOPS

<https://github.com/mozilla/sops>

from releases page

<https://github.com/mozilla/sops/releases>

```bash
wget https://github.com/mozilla/sops/releases/download/v3.7.3/sops_3.7.3_amd64.deb
sudo dpkg -i ./sops_3.7.3_amd64.deb
rm ./sops_3.7.3_amd64.deb
```

test with

```bash
sops -v
```

should see

```bash
sops 3.7.3 (latest)
```

## Install Age

<https://github.com/FiloSottile/age>

```bash
sudo apt install age
```

or the manual way

get the file

```bash
wget -O age.tar.gz https://github.com/FiloSottile/age/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz
```

extract and move

```bash
tar xf age.tar.gz
sudo mv age/age /usr/local/bin
sudo mv age/age-keygen /usr/local/bin
```

clean up

```bash
rm -rm age
rm age.tar.gz
```

test `age` with

```bash
 age -version
```

should see

```console
v1.0.0
```

test `age-keygen` with

```bash
 age-keygen -version
```

should see

```console
v1.0.0
```

## configure keys

Now that we have `age` installed we need to create a public and private key

```bash
age-keygen -o key.txt
```

should see

```console
age-keygen: warning: writing secret key to a world-readable file
Public key: age1epzmwwzw8n09slh0c7z0z52x43nnga7lkksx3qrh07tqz5v7lcys45428t
```

let's look at the contents

```bash
cat key.txt
```

should see

```console
# created: 2022-09-26T21:55:47-05:00
# public key: age1epzmwwzw8n09slh0c7z0z52x43nnga7lkksx3qrh07tqz5v7lcys45428t
AGE-SECRET-KEY-1HJCRJVK7EE3A5N8CRP8YSDUGZKNW90Y5UR2RGYAS8L279LFP6LCQU5ADNR
```

> *Remember this is a secret so keep this safe!*  Do not commit this!
{: .prompt-info }

move the file and add to our shell

```bash
mkdir ~/.sops
mv ./key.txt ~/.sops
```

add it to our shell

```bash
nano ~/.zshrc 
# or nano ~/.bashrc
```

add to the end of file

```bash
export SOPS_AGE_KEY_FILE=$HOME/.sops/key.txt
```

source our shell

```bash
source ~/.zshrc 
# or source ~/.bashrc
```

## Now! Let's encrypt

A few ways you can do this.  You can encrypt in place or encrypt with an editor but we’re going to do an in place encryption.

## YAML

This can be kubernetes secrets, helm values, or just plain old yaml

create a secret with the following contents

`secret.yaml`

```yaml
---
apiVersion: v1
kind: Secret
metadata:
    name: mysql-secret
    namespace: default
stringData:
    MYSQL_USER: root
    MYSQL_PASSWORD: super-Secret-Password!!!!
```

to encrypt

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --encrypted-regex '^(data|stringData)$' --in-place ./secret.yaml
```

to decrypt

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --encrypted-regex '^(data|stringData)$' --in-place ./secret.yaml
```

## Kubernetes

If you want to decrypt this secret on the fly and apply to kubernetes

encrypt first

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --encrypted-regex '^(data|stringData)$' --in-place ./secret.yaml
```

decrypt and pipe to kubectl

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --encrypted-regex '^(data|stringData)$' ./secret.yaml | kubectl apply -f -
```

check it with

```bash
k describe secrets mysql-secret-test
```

then

```bash
 kubectl get secret mysql-secret-test -o jsonpath='{.data}'
```

then

```bash
kubectl get secret mysql-secret-test -o jsonpath='{.data.MYSQL_PASSWORD}'  | base64 --decode
```

## VSCode

install vscode extension

choose the beta for sops because that supports age + sops

don't forget to add `.decrypted~secret.yaml` to `.gitignore`

encrypt .env files

make sure extension is installed

## .ENV Files

create

`secret.env`

```env
MYSQL_USER=superroot
MYSQL_PASSWORD="super-Secret-Password!!!!############"
```

encrypt

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i .env
```

decrypt

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i .env
```

don't forget to add `.decrypted~secret.env` to your `.gitignore`

## JSON Files

`secret.json`

```json
{
    "mySqlUser": "superroot",
    "password": "super-Secret-Password!!!!#######"
}
```

encrypt

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i secret.json
```

decrypt

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i secret.json
```

don't forget to add `.decrypted~secret.json` to your `.gitignore`

## INI Files

`secret.ini`

```ini
[database]
user     = superroot
password = super-Secret-Password!!!!1223
```

encrypt

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i secret.ini
```

decrypt

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") -i secret.ini
```

don't forget to add `.decrypted~secret.ini` to you `.gitignore`

## Files

`secret.sql`

```sql
--- https://xkcd.com/327/
--- DO NOT USE
INSERT INTO Students VALUES ( 'Robert' );  DROP TABLE STUDENTS; --' )
```

encrypt

```bash
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --in-place ./secret.sql
```

decrypt

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --in-place ./secret.sql
```

## Flux

If you're thinking of doing GitOps with Flux, you can [check out my video on this topic](https://www.youtube.com/watch?v=PFLimPh5-wo) or see my [documentation](https://docs.technotim.live/posts/flux-devops-gitops/).  You can do cluster decryption and fully automate decryption of secrets.

In cluster decryption with Flux

<https://fluxcd.io/flux/guides/mozilla-sops/#configure-in-cluster-secrets-decryption>

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
