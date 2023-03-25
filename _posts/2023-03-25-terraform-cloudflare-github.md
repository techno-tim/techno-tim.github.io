---
layout: post
title: "Automate Cloudflare with Terraform and GitHub Actions! - Terraform Tutorial for Beginners"
date: 2023-03-25 10:00:00 -0500
categories: cloud
tags: terraform hashicorp cloudflare github cloud homelab
image:
  path: /assets/img/headers/terraform-mars.jpg
---

## What is Terraform and how does it help?

Terraform is a powerful infrastructure as code tool to help you create and manage infrastructure  across multiple public or private clouds. It can help you provision, configure, and manage infrastructure using their simple and human readable configuration language. Using Terraform helps you automate your infrastructure and your DevOps workflow, do it consistently, and allows you to collaborate with teams in Git.

Today, we're going to set up and configure Terraform on your machine so we can start using Terraform.  Then we'll configure `cf-terraforming` to import our Cloudflare state and configuration into Terraform.  After that we'll set up a GitHub report and configure GitHub actions so you have CI and CD for deploying your Infrastructure automatically using a Git Flow.  If you're new to Terraform, that's fine!  This is a beginner tutorial for Terraform and by the end of this, you will feel like an expert!

{% include embed/youtube.html id='FmYvrxYvBP0' %}
📺 [Watch Video](https://www.youtube.com/watch?v=FmYvrxYvBP0)

## Installing Terraform

This will work on Ubuntu and Windows + WSL

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

[Install `terraform` for other platforms](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

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

```editorconfig
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

Initialize terraform and cloudflare

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

Check cloudflare's site.

if we run plan again, we can see there's no work to do

```bash
terraform apply
```

Should see that there isn't any work to do.

## Importing Cloudflare State

An important point to understand about Terraform is that it can only manage configuration it created or was explicitly told about after the fact. The reason for this limitation is that Terraform expects to be authoritative for the resources it manages. It relies on two types of files to understand what resources it controls and what state they are in. Terraform determines when and how to make changes from the following:

<https://developers.cloudflare.com/terraform/advanced-topics/import-cloudflare-resources/>

- A configuration file (ending in .tf) that defines the configuration of resources for Terraform to manage. This is what you worked with in the tutorial steps.
- A local state file that maps the resource names defined in your configuration file — for example, cloudflare_load_balancer.www-lb — to the resources that exist in Cloudflare.

So this means that we need to sync the remote state of cloudflare, down to our local state.

This is where `cf-terraforming` can help

Check for the latest version here:
<https://github.com/cloudflare/cf-terraforming/tags>

Update this command with the latest tag

```bash
curl -L https://github.com/cloudflare/cf-terraforming/releases/download/v0.10.0/cf-terraforming_0.10.0_linux_amd64.tar.gz -o cf-terraforming.tar.gz

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

<https://developer.hashicorp.com/terraform/language/state/remote>

Be sure to sign up for an account and then get add your `CLOUDFLARE_API_TOKEN` and an ENV variable in Terraform Cloud.  Mark it as seneitive.

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

Then run

```bash
terraform init
```

This will prompt you to sign in and then import your local state into Terraform cloud.

## CI / CD with GitHub Actions

If you want oo create a Ci / CD pipeline with GitHub actions, you'll need to create a new repo at <https://github.com/>

Here is my `.gitignore`

```gitignore
.terraform/
terraform.tfstate*
```
{: file=".gitignore" }

Convert your local folder into a git repo:

first, `cd` into your folder

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
      uses: hashicorp/setup-terraform@v1
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

At this point you should be able to run terraform and have your Cloudflare state sync'd with Terraform cloud and GitHub actions running in CI / CD so you can start deploying your infrastructure using code!

## Links

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
