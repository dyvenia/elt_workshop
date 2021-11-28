# Data platform workshop
Materials for the "Building a modern data platform with Python and open-source tools" workshop.

## Pre-workshop set up
We'll be using GitHub and `docker-compose` during the workshop. To save everyone's time, please make sure you have these two tools set up before we begin.

### 1. Install Git
[LINK](https://git-scm.com/downloads)

### 2. Set up GitHub
a. set up an SSH key
- [LINK](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- basically: `ssh-keygen -t gh_dyvenia_workshops -C "your_email@example.com"` and paste the contents inside a new key in `Settings -> SSH and GPG keys` on GitHub

b. save the passphrase locally so we don't have to provide it every time:
`eval $(ssh-agent) && ssh-add ~/.ssh/gh_dyvenia_workshops`
On Mac:
`ssh-add -K`

### 3. Install Docker
TODO

### 4. Install docker-compose
TODO
