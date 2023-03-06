---
layout: post
title: "Rotating your AGE Encryption Key"
date: 2023-03-05 10:00:00 -0500
categories: utilities
tags: sops age flux kubernetes
image:
  path: /assets/img/headers/museum-hieroglyphics.jpg
---

## The Challenge

If you've been encrypting your secrets with SOPS and Age you know how useful it is to keep your secrets safe from prying eyes. If you're not familiar with encrypting your secrets with SOPS and Age, I highly recommend checking out a post I did a while back that shows you how easy it is to [encrypt your secrets](/posts/secret-encryption-sops) and even hide them in plain sight in a Git repo.  I am happy (and relieved) that I started doing this for all of my secrets.

This works great, until you need to rotate your encryption key that's used to encrypt your secrets. I use [FLUX for GitOps](/posts/flux-devops-gitops) which helps me deliver changes to my Kubernetes cluster via code and since I can commit my infrastructure, I can also commit my secrets as code too (SOPS, or Secrets Operations).  This means that all of my secret files (typically `secret.sops.yaml`) are all encrypted using my key.  But what happens when I need to change the key, either for good security hygiene or because it was compromised?  The short answer is, there's no easy way other than writing a little bit of code.

### Scripting it with Bash

First you'll need to generate a new `age` file with

```bash
age-keygen -o age.agekey
```

This will output a `age.agekey` file.  Take note of this location.

Then you'll want to execute this script in the folder where you have secrets that need to be updated.

This script isn't anything ground breaking but hopefully it will help you update all of your secrets without having to go and manually change them yourself.

```bash
#!/bin/bash

# Define the paths to the old/current and new age key files
SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
SOPS_AGE_KEY_FILE_NEW=~/.config/sops/age/age.agekey

# Define the commands to decrypt and encrypt the file
DECRYPT_COMMAND="sops --decrypt --age \$(cat $SOPS_AGE_KEY_FILE |grep -oP \"public key: \K(.*)\") --encrypted-regex '^(data|stringData)$' --in-place"
ENCRYPT_COMMAND="sops --encrypt --age \$(cat $SOPS_AGE_KEY_FILE_NEW |grep -oP \"public key: \K(.*)\") --encrypted-regex '^(data|stringData)$' --in-place"

# Find all the *.sops.yaml files recursively in the current directory and apply the decrypt and encrypt commands to them
find . -name "*.sops.yaml" -type f -print0 | while IFS= read -r -d '' file; do
  eval "$DECRYPT_COMMAND $file"
  eval "$ENCRYPT_COMMAND $file"
done
```
{: file="sops_rotate_key.sh" }

It works like this:

- `SOPS_AGE_KEY_FILE` is the path to your existing `keys.txt` or `age.agekey` file
- `SOPS_AGE_KEY_FILE_NEW` is the path to your new `age.agekey` file.
- It will look for files matching `*.sops.yaml` recursively and then decrypt the file using the old key, and encrypt it using the new key.

After running this script you should see all of your secrets now encrypted with the new key! You can now replace your old key file with your new one so that `SOPS_AGE_KEY_FILE` is referencing. You should test decrypting your secrets before saving them.

```bash
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE |grep -oP "public key: \K(.*)") --encrypted-regex '^(data|stringData)$' secret.sops.yaml
```

## Updating your FLUX Secret in Kubernetes

If you are able to see the decrypted secret, you are all set.  Another thing you'll need to do is delete your old secret in Kubernetes and replace it with this new one.

```bash
kubectl delete -n flux-system secrets sops-age
```

Then create new secret from the new file

```bash
cat age.agekey |
kubectl create secret generic sops-age \
--namespace=flux-system \
--from-file=age.agekey=/dev/stdin
```

Now you should be all set!  Be sure to keep your new `age.agekey` somewhere safe.

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
