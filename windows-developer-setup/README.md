# Setting Up Windows for JavaScript Development THE RIGHT WAY (WSL Terminal NVM Node Yarn VS Code ZSH)

[![Setting Up Windows for JavaScript Development THE RIGHT WAY (WSL Terminal NVM Node Yarn VS Code ZSH)](http://img.youtube.com/vi/kL8iGErULiw/0.jpg)](https://www.youtube.com/watch?v=kL8iGErULiw "Setting Up Windows for JavaScript Development THE RIGHT WAY (WSL Terminal NVM Node Yarn VS Code ZSH)")


You want to get started developing JavaScript with NodeJS, ReactJS, or AngularJS but you're not sure how to get started?  This is a complete, step by step guide on how to configure your Windows machines for JavaScript development the right way.  You'll learn how to install and configure Windows, the new Windows Terminal, WSL, Ubuntu, ZSH with Oh My ZSH, yarn, NPM,  NVM, NodeJS, and VS Code.  We'll also configure our git client for SSH access to GitHub.  This is the perfect beginner tutorial for anyone trying to develop software on a Windows PC.


## Ipdate Ubuntu
`sudo apt-get update`

`sudo apt-get upgrade`


## install zshell

`sudo apt-get install zsh`

## oh-my-zsh

Check this site for the command https://ohmyz.sh/#install


It should be something like this:

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`


## nvm

Be sure `zshell` and `oh-my-zsh` are working before continuing

Check this site for the command https://github.com/nvm-sh/nvm

It should be something like this, but be sure to use the version from the link above

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

If `nvm` doesn't work, check this https://youtu.be/kL8iGErULiw?t=507

Close all terminals and all VS Code instances after doing this step

## Install Node

`nvm install 12.16.1`

## Install yarn

Be sure `nvm` and `node` are working before continuing

Check this site for the latest command https://classic.yarnpkg.com/en/docs/install/#alternatives-stable

It should be something like this, but be sure to use the version from the link above

`curl -o- -L https://yarnpkg.com/install.sh | bash`

## Configure Git

You'll want to follow this guide for configuring git.  Be sure to follow the `LINUX` version

https://docs.github.com/en/github/using-git/getting-started-with-git-and-github


`git config --global user.name "Techno Tim"`

`git config --global user.email "your_email@example.com"`

`ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

`eval $(ssh-agent -s)`


## Cloning a repo

`mkdir code && cd code`

Be sure you choose the right repo before cloning, this is just an example

`git clone git@github.com:techno-tim/techno-boto-discord.git`

`cd techno-boto-discord`

`yarn`

## Continuing with the bot turotials

* Discord Bot https://www.youtube.com/watch?v=YSZcyz2-twQ
* Twitch Bot https://www.youtube.com/watch?v=7uSjKbAUHXg
* Slack Bot https://www.youtube.com/watch?v=AajBk59nOgw
