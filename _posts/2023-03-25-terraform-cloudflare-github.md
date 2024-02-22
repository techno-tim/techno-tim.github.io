---
layout: post
title: "Automate Cloudflare with Terraform and GitHub Actions! - Terraform Tutorial for Beginners"
date: 2023-03-25 10:00:00 -0500
categories: cloud
tags: terraform hashicorp cloudflare github cloud homelab
image:
  path: /assets/img/headers/terraform-mars.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP41tP8AF+r+CvAV/oGhQ6LFDHb6frsmtzaDpT+NIr5Nev8AQ7OLRvG8VtB4m0DTVtr6WTU9N03UI7XWXWOO7RYF8o/YxzHEZrk/CnEmCxOZ5DxDwrlWaRp5hlGdZxh6GYU83zXL8FL67lUMbDLMTWwcJVJ4HE47DY6tgp1qs8DLCVJzqS+/z7g/LchxvHfCklDN+Fswlk2YYzJM2wuGxNCrjMBiK6w2IpzVOLw9T2UqdHEqhGFPFQp2qwcJOC/bD4P/AAt8Q+J/hJ8LfEt3r/gGe78Q/DnwRrl1PqvwottV1Sa41bwzpl/NLqWqHxbaHUr+SS4Z7y/NrbG8uDJcG3h8zy1/pTK+JMVicsy7EYrH8T1cVXwGErYmrDibEUoVK9XD051qkaUcHKNKM6kpSjTUmoJqKbSufy9W8Jcodaq8PT4ew+HdWo6GH/1Ty+r7Ci5v2VH2ssSpVPZQ5Ye0klKfLzNJs//Z

---


Today, we're going to set up and configure Terraform on your machine so we can start using Terraform.Then we'll configure `cf-terraforming` to import our Cloudflare state and configuration into Terraform.After that we'll set up a GitHub report and configure GitHub actions so you have CI and CD for deploying your Infrastructure automatically using a Git Flow.If you're new to Terraform, that's fine!  This is a beginner tutorial for Terraform and by the end of this, you will feel like an expert!

{% include embed/youtube.html id='FmYvrxYvBP0' %}
📺 [Watch Video](https://www.youtube.com/watch?v=FmYvrxYvBP0)

## What is Terraform and how does it help?

Terraform is a powerful infrastructure as code tool to help you create and manage infrastructure  across multiple public or private clouds. It can help you provision, configure, and manage infrastructure using their simple and human readable configuration language. Using Terraform helps you automate your infrastructure and your DevOps workflow, do it consistently, and allows you to collaborate with teams in Git.

There are 7 key areas where Terraform shines:

- Automation: Terraform enables automation of infrastructure provisioning, configuration, and management, which reduces human error and saves time.

- Consistency: Terraform ensures that your infrastructure is consistent across all environments, from development to production.

- Collaboration: Terraform allows multiple teams to work together on infrastructure changes, using version control systems like Git.

- Cloud-agnostic: Terraform supports various cloud providers, including AWS, Google Cloud, and Microsoft Azure, allowing you to use the same tool to manage resources across different clouds.

- Scalability: Terraform is designed to handle large-scale infrastructure deployments and can easily manage thousands of resources.

- Reusability: Terraform modules enable you to reuse code and infrastructure components across multiple projects, making it easier to manage infrastructure at scale.

- Flexibility: Terraform is highly flexible and can be extended through plugins to integrate with other tools and services.

## Installing Terraform

This will work on Ubuntu and Windows + WSL

[Install `terraform` for other platforms](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Install dependencies

```bash
sudo apt update
sudo apt install  software-properties-common gnupg2 curl
```

Import the gpg key

```bash
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
```

Add hashicorp repository

```bash
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Install `terraform`

```bash
sudo apt install terraform
```

Check the version

```bash
terraform --version
Terraform v1.4.0
on linux_amd64
```

## Create your Terraform Cloudflare config

First create a simple terraform config:

```hcl
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Create a record
resource "cloudflare_record" "www" {
  # ...
}

# Create a page rule
resource "cloudflare_page_rule" "www" {
  # ...
}
```
{: file="cloudflare.tf" }

Here is my `.editorconfig`:

```bash
# http://editorconfig.org
root = true

[*]
indent_style = space
indent_size = 2
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false
```
{: file=".editorconfig" }

Initialize terraform and Cloudflare

```bash
terraform init
```

We should see  that it installed plugins, and it should have created a lock file.

## Terraform Plan and Apply

Next we'll want to review our plan, we can see our proposed changes

```bash
terraform plan
```

Next we'll apply our changes.

```bash
terraform apply
```

Verify on the dashboard.

After applying we can verify the results.

we can also test with `nslookup`

```bash
nslookup yoursite.example.com
```

Check Cloudflare's site.

if we run plan again, we can see there's no work to do

```bash
terraform apply
```

Should see that there isn't any work to do.

## Importing Cloudflare State

We will need to import our Cloudflare state into our local Terraform state.

> An important point to understand about Terraform is that it can only manage configuration it created or was explicitly told about after the fact. The reason for this limitation is that Terraform expects to be authoritative for the resources it manages. It relies on two types of files to understand what resources it controls and what state they are in. Terraform determines when and how to make changes from the following:
>- A configuration file (ending in .tf) that defines the configuration of resources for Terraform to manage. This is what you worked with in the tutorial steps.
>- A local state file that maps the resource names defined in your configuration file — for example, cloudflare_load_balancer.www-lb — to the resources that exist in Cloudflare.

<https://developers.cloudflare.com/terraform/advanced-topics/import-cloudflare-resources/>

So this means that we need to sync the remote state of Cloudflare, down to our local state.

This is where `cf-terraforming` can help

Check for the latest version here:
<https://github.com/cloudflare/cf-terraforming/tags>

Update this command with the latest tag

```bash
curl -L https://github.com/cloudflare/cf-terraforming/releases/download/v0.11.0/cf-terraforming_0.11.0_linux_amd64.tar.gz -o cf-terraforming.tar.gz

tar -xzf cf-terraforming.tar.gz

rm cf-terraforming.tar.gz

sudo mv ./cf-terraforming /usr/local/bin

sudo chmod +x /usr/local/bin/cf-terraforming
```

Then we need to updated our `.zshrc` or `.bashrc` with our variables

```bash
nano ~/.zshrc
```

```bash
export CLOUDFLARE_API_TOKEN='12345'
export CLOUDFLARE_ZONE_ID='abcde'
```
{: file="~/.zshrc" }

The source your shell

```bash
source ~/.zshrc
```

Now let's export Cloudflare state

(Be sure you have copied your variables into your shell, or ran the export commands above )

```bash
cf-terraforming generate \
  --resource-type "cloudflare_record" \
  --zone $CLOUDFLARE_ZONE_ID > imported.tf
```

Look at the file and copy  the contents into your `cloudflare.tf`

then run

```bash
terraform plan
```

Terraform thinks that we need to apply all of these resources, even though they exist.

We need to import them into our local state.

```bash
cf-terraforming import \
  --resource-type "cloudflare_record" \
  --zone $CLOUDFLARE_ZONE_ID
```

This will export a lot of commands, we now need to run them to import them into our state.

All you need to do it copy and paste the commands into your terminal.

This will import your local state, you can see it in `terraform.tfstate`

If we run `terraform plan` now, we can see that there aren't any changes.

## Remote State with Terraform Cloud

[Terraform Cloud](https://app.terraform.io/)

Be sure to sign up for an account and then get add your `CLOUDFLARE_API_TOKEN` and an ENV variable in Terraform Cloud.Mark it as seneitive.

Then you'll want to updated your `cloudflare.tf`

It should look like this

```hcl
  cloud {
    hostname = "app.terraform.io"
    organization = "your org"

    workspaces {
      name = "Cloudflare"
    }
  }
```

Your `cloudflare.tf` file should now look like:

```hcl
terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "your org"

    workspaces {
      name = "Cloudflare"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Create a record
resource "cloudflare_record" "www" {
  # ...
}

# Create a page rule
resource "cloudflare_page_rule" "www" {
  # ...
}
```
{: file="cloudflare.tf" }

Then run

```bash
terraform init
```

This will prompt you to sign in and then import your local state into Terraform cloud.

## CI / CD with GitHub Actions

If you want to create a CI / CD pipeline with GitHub actions, you'll need to create a new repo at [GitHub](https://github.com/)

Here is my `.gitignore`

```gitignore
.terraform/
terraform.tfstate*
```
{: file=".gitignore" }

Convert your local folder into a git repo:

first, `cd` into your folder

> *Note: Be sure not to commit any of your secrets to git! This includes API tokens, terraform state, and any other files that might include sensitive information*  
{: .prompt-danger }

```bash
git init
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:username/your-repo-name.git
git push -u origin main
```

To create a branch, add files, commit, and push

```bash
git checkout -b my-new-branch
git add .
git commit -m "fix(terraform): made some changes"
git push --set-upstream origin my-new-branch
```

Be sure you have created a secret `TF_API_TOKEN` with your Terraform API token.

For reference, here is the terraform GitHub Action (with my bug fix)

```yaml
name: 'Terraform'

on:
  push:
    branches: [ "main" ]
  pull_request:

permissions:
  contents: read

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest
    environment: production

    # Use the Bash shell regardless whether the GitHub Actions runner is ubuntu-latest, macos-latest, or windows-latest
    defaults:
      run:
        shell: bash

    steps:
    # Checkout the repository to the GitHub Actions runner
    - name: Checkout
      uses: actions/checkout@v3

    # Install the latest version of Terraform CLI and configure the Terraform CLI configuration file with a Terraform Cloud user API token
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}

    # Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
    - name: Terraform Init
      run: terraform init

    # Checks that all Terraform configuration files adhere to a canonical format
    - name: Terraform Format
      run: terraform fmt -check

    # Generates an execution plan for Terraform
    - name: Terraform Plan
      run: terraform plan -input=false

      # On push to "main", build or change infrastructure according to Terraform configuration files
      # Note: It is recommended to set up a required "strict" status check in your repository for "Terraform Cloud". See the documentation on "strict" required status checks for more information: https://help.github.com/en/github/administering-a-repository/types-of-required-status-checks
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: terraform apply -auto-approve -input=false
```
{: file=".github/workflows/terraform.yml" }

## Wrapping up

At this point you should be able to run terraform and have your Cloudflare state sync'd with Terraform Cloud and GitHub actions running in CI / CD so you can start deploying your infrastructure using code!

## Join the conversation

<blockquote class="twitter-tweet" data-dnt="true" data-theme="dark"><p lang="en" dir="ltr">Over the past few weeks I learned all about Terraform and it&#39;s awesome! I converted my Cloudflare settings to code and deploy it with CI / CD using GitHub Actions!<br><br>You can check it out here:<br><br>👉 <a href="https://t.co/vUnvV8m3Mh">https://t.co/vUnvV8m3Mh</a><a href="https://twitter.com/hashtag/terraform?src=hash&amp;ref_src=twsrc%5Etfw">#terraform</a> <a href="https://twitter.com/hashtag/cloudflare?src=hash&amp;ref_src=twsrc%5Etfw">#cloudflare</a> <a href="https://twitter.com/hashtag/github?src=hash&amp;ref_src=twsrc%5Etfw">#github</a> <a href="https://twitter.com/hashtag/homelab?src=hash&amp;ref_src=twsrc%5Etfw">#homelab</a> <a href="https://t.co/2oWkhtZshu">pic.twitter.com/2oWkhtZshu</a></p>&mdash; Techno Tim (@TechnoTimLive) <a href="https://twitter.com/TechnoTimLive/status/1639660262818021376?ref_src=twsrc%5Etfw">March 25, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Links

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
