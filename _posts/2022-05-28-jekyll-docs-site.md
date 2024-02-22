---
layout: post
title: "Meet Jekyll - The Static Site Generator"
date: 2022-05-28 10:00:00 -0500
categories: self-hosted
tags: jekyll website github gitlab docker
image:
  path: /assets/img/headers/journal-blue.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAUACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APHfEnxW+JNh+2JYaPq/jvxb4msdF+OmteBYbDV9cu20aTRNR8SX3ghoxokbDTYHgsL6S6h8uHC3cNq42+SGb+9eL+D+GYeD7zfL8kyzLMZUyPh3OPrGGwsHjPrNf6nWxEKmNqOWJq0qsMRUpckpqMXL2lpNJL1vDjxc8R39K7D8OZzxnxFn+UYXjzjDhOOW4/M60MreApVs3yvDVY5Th+TLqVfD+xw+JjUhh+dzoxhzpNyP0QntoRPMNg4lkHQdnPtX8hH+sR//2Q==

---

Jekyll is a static site generator that transforms your plain text into beautiful static web sites and blogs.It can be use for a documentation site, a blog, an event site, or really any web site you like. It's fast, secure, easy, and open source.It's also the same site generator I use to maintain my open source documentation.Today, we'll be installing and configuring Jekyll using the Chirpy theme.We configure the site, create some pages with markdown, automatically build it with a GitHub action and even host it for FREE on GitHub pages.If you don't want to host in the cloud, I show how to host it on your own server or even in Docker.

A HUGE THANK YOU to Micro Center for Sponsoring this video!

[New Customers Exclusive – Get a Free 256 GB SSD at Micro Center](https://micro.center/de2e28)

[Browse Micro Center’s 30,000 products in stock](https://micro.center/776d9e)

Be sure to ⭐ the [jekyll repo](https://github.com/jekyll/jekyll) and the [Chrirpy theme repo](https://github.com/cotes2020/jekyll-theme-chirpy)

{% include embed/youtube.html id='F8iOU1ci19Q' %}
📺 [Watch Video](https://www.youtube.com/watch?v=F8iOU1ci19Q)

## Terminal Setup

If you need help setting up your terminal on Windows, check out these two posts which will help you configure your terminal with WSL like mine

- [Windows Terminal and WSL Config Fast, Simple, and Easy Guide](/posts/windows-terminal-wsl/)
- [Setting Up Windows for JavaScript Development THE RIGHT WAY (WSL Terminal NVM Node Yarn VS Code ZSH)](/posts/windows-developer-setup/)
  - You can follow this guide up until installing NodeJS (You don't need NodeJS for Jekyll)

## Install Dependencies

```bash
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev git
```

To avoid installing RubyGems packages as the root user:

If you are using `bash` (usually the default for most)

```bash
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

If you are using `zsh` (you know if you are)

```bash
echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Install Jekyll `bundler`

```bash
gem install jekyll bundler

```

## Creating a site based on Chirpy Starter

Visit <https://github.com/cotes2020/jekyll-theme-chirpy#quick-start>

After creating a site based on the template, clone your repo

```bash
git clone git@<YOUR-USER-NAME>/<YOUR-REPO-NAME>.git
```

then install your dependencies

```bash
cd repo-name
bundle
```

After making changes to your site, commit and push then up to git

```bash
git add .
git commit -m "made some changes"
git push
```

## Jekyll Commands

serving your site

```bash
bundle exec jekyll s
```

Building your site in production mode

```bash
JEKYLL_ENV=production bundle exec jekyll b
```

This will output the production site to `_site`

## Building Site in CI

This site already works with GitHub actions, just push it up and check the actions Tab.,

For GitLab you can see the [pipeline I built for my own docs site here](https://github.com/techno-tim/techno-tim.github.io/blob/master/.gitlab-ci.yml#L18)

## Building with Docker

Create a `Dockerfile` with the following

```Dockerfile
FROM nginx:stable-alpine
COPY _site /usr/share/nginx/html
```

Build site in production mode

```bash
JEKYLL_ENV=production bundle exec jekyll b
```

Then build your image:

`docker build .`

## Creating a Post

### Naming Conventions

Jekyll uses a naming [convention for pages and posts](https://jekyllrb.com/docs/posts/)

Create a file in `_posts` with the format

```file
YEAR-MONTH-DAY-title.md
```

For example:

```file
2022-05-23-homelab-docs.md
2022-05-34-hardware-specs.md
```

> Jekyll can delay posts which have the date/time set for a point in the future determined by the "front matter" section at the top of your post file. Check the date & time as well as time zone if you don't see a post appear shortly after re-build.
{: .prompt-tip }

### Local Linking of Files

Image from asset:

```markdown
... which is shown in the screenshot below:
![A screenshot](/assets/screenshot.webp)
```

Linking to a file

```markdown
... you can [download the PDF](/assets/diagram.pdf) here.
```

See more post formatting rules on the [Jekyll site](https://jekyllrb.com/docs/posts/)

### Markdown Examples

If you need some help with markdown, check out the [markdown cheat sheet](https://www.markdownguide.org/cheat-sheet/)

I have lots of examples in my [documentation site repo](https://github.com/techno-tim/techno-tim.github.io/tree/master/_posts).Just click on the Raw button to see the code behind the page.

For more neat syntax for the Chirpy theme check their demo page on making posts <https://chirpy.cotes.page/posts/write-a-new-post/>

## Links

See [reference repo](https://l.technotim.live/quick-start) for files

🛍️ Check out the new Merch Shop at <https://l.technotim.live/shop>

⚙️ See all the hardware I recommend at <https://l.technotim.live/gear>

🚀 Don't forget to check out the [🚀Launchpad repo](https://l.technotim.live/quick-start) with all of the quick start source files
