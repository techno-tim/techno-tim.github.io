---
layout: post
title: "Rotating your Encryption Keys and Updating your Secrets with SOPS"
date: 2023-03-05 10:00:00 -0500
categories: utilities
tags: sops age flux kubernetes
image:
  path: /assets/img/headers/museum-hieroglyphics.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APyS1v8AaHutK/Zk8MaBpfgfwzYrP8PfD1veajHb2zanNeaFNHdaZqkF8+nm7s7yK5mmllMVwwn37Xwq8/5gZZ4X0q3ibm+ZV+IMzq1XxLj6mHpt1lSw1HGSqU8Xho01jPZyp1qUYUr8kXGEbWdz/VbF8Y1qPB+WuGAoxhTyai501OKVWdKhSdGbl7BuLpVL1Vu+d3TRSsf+Cwf7XOlWNnpdlqfhqKz021t7C0jOjQMY7azhS3gQttG4pFGi5xzjNfa/8S0cLPVcQ8SQT1UIYiioQT2jFOm2oxWkbtuyV23qfBy8X8a5ScuHsolJybcpSxDlJt6ttNK7erslr0R//9k=

---

If you've been encrypting your secrets with SOPS and Age you know how useful it is to keep your secrets safe from prying eyes. If you're not familiar with encrypting your secrets with SOPS and Age, I highly recommend checking out a post I did a while back that shows you how easy it is to [encrypt your secrets](/posts/secret-encryption-sops) and even hide them in plain sight in a Git repo.I am happy (and relieved) that I started doing this for all of my secrets.

This works great, until you need to rotate your encryption key that's used to encrypt your secrets. I use [FLUX for GitOps](/posts/flux-devops-gitops) which helps me deliver changes to my Kubernetes cluster via code and since I can commit my infrastructure, I can also commit my secrets as code too (SOPS, or Secrets Operations).This means that all of my secret files (typically `secret.sops.yaml`) are all encrypted using my key.But what happens when I need to change the key, either for good security hygiene or because it was compromised?  The short answer is, there's no easy way other than writing a little bit of code.

### Scripting it with Bash

First you'll need to generate a new `age` file with

```bash
age-keygen -o age.agekey
```

This will output a `age.agekey` file.Take note of this location.

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

If you are able to see the decrypted secret, you are all set as far as the ket goes.Another thing you'll need to do is delete your old secret in Kubernetes and replace it with this new one so that your secrets can be decrypted in your cluster!

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

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">I wrote up a quick post on how to rotate your SOPS encryption key and update all of your secrets at once! <br><br>Great if you&#39;re using SOPS with Kubernetes.<a href="https://t.co/iME1iS4Kpl">https://t.co/iME1iS4Kpl</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1632596441293103106?ref_src=twsrc%5Etfw">March 6, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
