---
layout: post
title: "Meet Renovate - Your Update Automation Bot for Kubernetes and More!"
date: 2023-07-01 08:00:00 -0500
categories: kubernetes
tags: renovate kubernetes docker github gitlab gitops devops automation
image:
  path: /assets/img/headers/renovate-paint-fence.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APlv4R/tB6ZoPwK+Ivw2vfhvp2t3fxKstMtLvxdc6xFHqfh6DSJG1G0Tw/ZyaBdWqG5vYrVtRn1RtTuoobdh4cuPDV3eX99dfGxVOkqsFBSdWpFc7s3Dl99ct4vrve/eLi9T/I6PFMMFkHEfD9bLKeMnntJ0Z5lUrQWIwEMEp4il9TpywlWPNUnGKryryrSUU3hJYOpUqVJ/B15qchu7olCSbmck+Z3Mrf7FCvZarbqr/jc8zCZPCphMLUeIqXqYejN6S3lTjJ/8vO7P/9k=
---

Keeping track of container image updates is hard. I started using Renovate Bot to to track these for me and I now get pull requests from a bot for my Docker and Kubernetes container images. It's a game changer.

A HUGE thanks to Datree for sponsoring this video!

Secure Your Kubernetes, Prevent Misconfigurations

<https://www.datree.io>

{% include embed/youtube.html id='5CkCr9U_Q1Y' %}
📺 [Watch Video](https://www.youtube.com/watch?v=5CkCr9U_Q1Y)

## Why use Renovate?

How much time do you spend looking for updated container images for services you have running in your Kubernetes cluster?  5 minutes, 5 hours?  Never?  I used to spend hours a week checking for new container images, reading up on the changes, and not really knowing if it was going to break my cluster or not. It was super tedious doing this to the point where I almost stopped doing it. That’s when I discovered Renovate Bot. [Renovate](https://github.com/renovatebot/renovate) is a dependency update automation tool that scans your software, discovers dependencies, and checks to see if an update exists, and if there is one, it will automatically help you out by submitting a pull request on your code base. It works out of the box and supports a wide variety of languages and technologies, it’s highly configurable putting you in control of what gets updated and when, and it’s pretty smart too and can automatically detect dependencies and suggest ideas for improvement.

Here’s the cool thing about it too, not only can it scan for all sorts of dependencies, it also gives you your [choice of how you want to run it](https://docs.renovatebot.com/getting-started/running/). Want to run it locally as a node module or from a CLI? Or in a Docker container? Or ever self host it in your Kubernetes cluster?  No problem!  Want to scan dependencies in GitHub, GitLab, AWS CodeCommit or other Git providers?  No problem at all. One of the  great things about Renovate is that because it’s open source, it puts you in control of how you want to run it, where you want to run it, and when you want to run it. So today we’ll be setting up Renovate bot to give us a helping hand with our Kubernetes resources. We’ll create a GitHub repo to house our Kubernetes deployments, add the Renovate bot to our repo, and then let it help us out by opening pull requests when it sees updates to any of the container images we’re using. Yeah… I feel like I just hired a devops engineer for free.

Renovate works with many different source control providers like GitHub, GitLab, CodeCommit, and many others. You also have your choice of how you want to manage Renovate, meaning you can self-host it with Docker or Kubernetes, or run it as a GitHub app for free that’s hosted by Renovate’s parent company Mend.

## Create GitHub Repo

We’re going to go with GitHub and the GitHub app because it’s super simple to set up. First we need to create a github repo, this is as simple as going to GitHub and well, [creating a new repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository). After naming your repo you’ll want to choose whether to make this public or private. The choice is up to you and Renovate will work either way.

> *Note: if you want to see the repo I created in this post and video, you can check it out here [technotim-k8s-renovate](https://github.com/techno-tim/k8s-renovate)*
{: .prompt-info }

![GitHub Repo!](/assets/img/posts/github-create-repo.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4g3hg/se3YwQs7XV0xfyUDjiJTuchvMD78kMqsu35ZMMyn6FK6dre6k/ldK34/1sea371nfVf0+6e+3z6Wydif3F/75H+FIu77v7z/AP/Z" }
_Create a repo in GitHub_

After creating the repo you’ll want to [clone it to your machine](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository). Now, I know that it’s empty, but we’ll be adding some things here shortly. After cloning it, I am going to open it up with a [VSCode](https://code.visualstudio.com/) but any editor will do.

Now that our repo is cloned, we’re going to add some Kubernetes resources so that Renovate can start analyzing our resources for updates. We’re going to create a simple nginx deployment and service.

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.24-alpine
          ports:
            - containerPort: 80
```
{: file="nginx/deployment.yml" }

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
  type: LoadBalancer
```
{: file="nginx/service.yml" }

For this deployment we’re going to use an older nginx container image tag because we want to see the Renovate bot actually work, so we’ll go out to [Docker Hub](https://hub.docker.com/_/nginx/tags) and choose an older tag. We’ll then put that image tag in our deployment. Now that we have this manifest, let’s commit this code and push it up.

## Add Renovate Bot

Now that we have a simple Kubernetes deployment committed to our repo, we should add the Renovate bot to start analyzing our code. We can do this by going out to GitHub, [finding the Renovate app](https://github.com/marketplace/renovate), and installing it in our repo. You need to authorize this app for your repo or org. Once you authorize this app and choose which repos it has access to you are all set!

If you ever decide to change your mind and remove this app for your repo, you can go to the repo settings and remove this app at any time.

Once the Renovate bot is authorized and installed, it won’t actually do anything until you merge a Pull Request that will be opened by the bot on your repo!  [This pull request](https://github.com/techno-tim/k8s-renovate/pull/1) is a special “onboarding” pull request that will show you what the bot has detected along with adding a default config for the bot. Renovate won’t take any further actions until you accept and merge this pull request. Once you have reviewed this PR, you can merge it in and it will activate the bot on your repo.

![Renovate in GitHub Marketplace!](/assets/img/posts/github-marketplace-renovate.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP5+vCvwH1Hxv4c/4S5/E1nBFdHV4P7Mu9KmuyY9L1bVLQs99FfWs8cskluXVrdYtquoOTH83yOccXYjBZpPAvL4YpQ9iniamPlSqSdWnTqXdNYGtfl9o1eVZt8qd1e0eZYnD4aUqcqMpWaaUPcjG6vZJTStaWq5Vqlbrfx19HvUdk+w6KNjMuBe6ywG0kYDM24jjq3J6nmvppYmEW4tTum07JdHb+Y7FiMO0n9X3SetSfX5n//Z" }
_Add the Renovate app to your repo_

## Our First (Real) Pull Request

After merging the onboarding PR, we can go and take a look at the logs for the bot on [Mend’s bot page](https://developer.mend.io/). Here we can see that it is trying to auto detect all of the various dependencies that the bot supports. It’s checking for `ansible`, `docker-compose`, `flux`, `gradle`, `helm`, and many other dependencies. But it doesn’t know how to handle Kubernetes files out of the box because Kubernetes files don’t really have a naming convention because there really isn’t one. So we’ll need to tell Renovate how to check for Kubernetes files in our config.

![Renovate logs!](/assets/img/posts/renovate-pr-logs.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APxR/aH/AGn/AIo2fiLxTaeEfiX8dvDWpReNtdtp9Q/4Xp43vbSS3tr++ja3ttIgk022s43bYYmWSWS3iijhQlck/p2c5nwniMtw+FyXhfHZXmlOdN4zNcVxFUzKGJ5YSjWjTwCy3B0qEatRqpF+0qSpRioXneUj5bJ8DntLF1q2ZZzhMdgZQl9WwNDJ4YOVHmlF0nPFPGYipVdOCcGuSEajk5NRtGK/Rf4UfGL4vXnwt+G15d/FX4kXV3deAPB1zdXNx448Sz3FxcT+HdOlmnnml1NpJpppGaSWWRmeR2Z3YsSa+Su+7+9n0LirvRbvoj//2Q==" }
_Here you can see Renovate trying to scan our repo and automatically detect dependencies_

So we’ll need to `git pull` to get latest and we should see our Renovate config file. We’ll need to add the file match for Kubernetes files. You’ll want to be sure that you use the right extension here, whether that be `yml` or `yaml`, both are acceptable but I typically use `yml` so that’s what I am going to use here.

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base"
  ],
  "kubernetes": {
    "fileMatch": ["\\.yml$"]
  }
}
```
{: file="renovate.json" }

If you're using FluxCD ([as shown here](/posts/flux-devops-gitops)) you also want add the `flux` extension and filematch. This will allow Renovate to scan your FluxCD manifests as well as creating Pull Requests for your Helm chart versions.

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base"
  ],
  "flux": {
    "fileMatch": ["\\.yml$"]
  },
  "kubernetes": {
    "fileMatch": ["\\.yml$"]
  }
}
```
{: file="renovate.json" }

Once we’ve made that change to our config locally, we’ll then commit that change and push it up.

Once we push this change up and it scans our repo, we can see a new [issue that was created](https://github.com/techno-tim/k8s-renovate/issues/2)!  This is a special type of issue that Renovate creates for us and it is kind of like a dashboard for all of our dependencies.

If we look at this issue, it’s telling us that it detected a new dependency that’s related to Kubernetes and that it detected not only our nginx tag but also our Kubernetes API version for the deployment. Super awesome. If you like you can choose to disable this dashboard issue in your config, but I would recommend keeping it.

If we look at the logs again from Renovate, we can also see that it detected our nginx deployment and that it created a PR for us to review. Now for the actual PR. We should see a new PR that was opened from the Renovate bot!

If we [look at this PR](https://github.com/techno-tim/k8s-renovate/pull/3) we can see the proposed changes, it's suggesting that we change  our nginx container image from `1.24` to `1.25` which is the current latest tag. If we’re happy with the change we can merge it into our code with just a click.

## How to Handle “latest” tag

Now our code base is up to date with the latest container image. What happens if a container you are using only has one tag, say like the “latest” tag?  Well, let’s find out.

Let’s say for instance we’re running Wordpress in our cluster, and we create a `deployment.yml` and in our `deployment.yml` we specify the “latest” tag vs. a versioned tag.

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
  replicas: 1
  template:
    metadata:
      labels:
        app: wordpress
    spec:
      containers:
        - name: wordpress
          image: wordpress:latest
          ports:
            - containerPort: 80
```
{: file="wordpress/deployment.yml" }

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: wordpress
spec:
  selector:
    app: wordpress
  ports:
    - port: 80
      targetPort: 80
  type: LoadBalancer
```
{: file="wordpress/service.yml" }

After we commit and push this up, we can wait for Renovate to check our repository again for new dependencies, or we can manually trigger one by going back to the dependency dashboard issue and check this box to trigger it to run again.

Now, if we look at the logs again we should see that it detected Wordpress, however it is unversioned. The `latest` tag is nondeterministic, meaning that it is not deterministic, or simply put, it can mean more than one thing. Renovate can’t use this because it can’t determine what the current version is and what the next possible version is. So,  instead of pinning this version to “latest”, we can actually pin it to a digest.

So if we look at the current `latest` tag in Docker Hub and inspect the digest, we can see it [here](https://hub.docker.com/_/wordpress).

It’s this long string of characters:

`DIGEST:sha256:75ba772cce073ec2aa6cec95c5ca229dfde9029c49874350a971499d567adae7`

 The digest is an immutable identifier for a container image and it is deterministic, meaning it can’t be changed and it only references one image. We can use that for Renovate. Once we have that, we can then pin our Wordpress container to this digest by using the like this, it’s:

`container image @ sha256 : digest`

Now if we make this change, commit this and push it up, we are now pinned to the digest which is also the same as  “latest”. Again, if we want to force a scan instead of waiting, we can go back to this Dashboard issue, check the check box and then go look at the logs. We can now see that it detected our Wordpress container image along with the digest and it can now compare this to the current digest and open a PR if it needs to. If we take a look at the issue Dependency dashboard, we can now see that it detected Wordpress pinned to the digest. We won’t see a PR now because this digest is the latest digest, however if Wordpress releases a new container image with a new digest we will get a pull request to replace the digest. Awesome, so that solves the “latest” problem.

## Working with Helm Charts

So that’s awesome, we have ways to work with Kubernetes manifests whether they are pinned to a versioned tag or an unversioned tag, but what about [helm charts](https://helm.sh/)?  Well, helm charts are just as easy. Let’s say we wanted to source control our mysql helm deployment, all we have to do is create a our helm values file and include the version as well as the repository.

```yaml
---
image:
  repository: bitnamicharts/mysql
  version: 9.9.0
persistence:
  enabled: true
  size: 10Gi
architecture: replication
auth:
  existingSecret: mysql-secret
primary:
  replicaCount: 1
```
{: file="mysql/values.yml" }

If you don’t specify the repository it will default to Docker hub, but as you can see here I am getting this chart from Bitnami. After we commit and push this up, we should now see a new dependency type of helm and since it detected an update we should also see a [pull request](https://github.com/techno-tim/k8s-renovate/pull/4) to update this file!

![Renovate helm charts!](/assets/img/posts/renovate-github-helm-mysql.webp){: lqip="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP4qLrUNHl0bTbB/CXhiW/ntILGfVJLPV47+R0UW/wBtNxF4gFobraBuY6V5MzfvZYDJuL/RpQ1tBWT5tdXffS9+vRNK1kkkkjx/ZV/aqosfi1BS5vYWwvsrX+C7wrr8nS/tlNJ2UkebSRRiRwY4hh2GFRQowTwoAAC+gwMDtWnLHsvuOrnl/NL73/mf/9k=" }
_updating helm charts with Renovate are just as easy!_

## Wrapping Up

So now with Renovate bot we can keep track and upgrade our Kubernetes deployment and even helm charts but I bet you are wondering how you can deploy them?  There are quite a few ways to deploy these resources using GitOps tools like Flux and ArgoCD, or even just a simple CI task that runs kubectl and or helm. [I have a few videos on this topic](https://technotim.live/posts/flux-devops-gitops/). What about Docker deployments?  Well if you’re interested in how to automate deployments with Docker and Renovate let me know in the comments below.

Well, I learned a ton about Renovate Bot, how to add it to your Git Repository and how to automate Pull Requests when there are updates available, and I hope you learned something too!  And remember if you found anything in this post helpful, don’t forget to share. Thanks for Reading!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Keeping track of container image updates is hard. I started using Renovate Bot to to track these for me and I now get pull requests from a bot for my Docker and Kubernetes container images. Automation is awesome. It&#39;s a game changer.<br><br> Check it out!<br>👉<a href="https://t.co/2ku5EayOIO">https://t.co/2ku5EayOIO</a> <a href="https://t.co/uLF1PC7Swi">pic.twitter.com/uLF1PC7Swi</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1675173605687033858?ref_src=twsrc%5Etfw">July 1, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
