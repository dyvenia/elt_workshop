# Data platform workshop
Materials for the "Building a modern data platform with Python and open-source tools" workshop.

## Pre-workshop set up
We'll be using GitHub and `docker-compose` during the workshop. To save everyone's time, please make sure you have these two tools set up before we begin.

### 1. Set up Prefect Cloud
- go to https://cloud.prefect.io
- register for the "Starter" plan
- **Note: you will need to provide your card details** (they have 20,000 task runs/month free tier, which for personal and educational use is basically infinite)
- create an API key:
    - click on the face logo in top right corner, then Account Settings -> API Keys
    - click "CREATE AN API KEY"
    - choose a name, eg "dyvenia_elt_workshop"
    - choose an expiration date (for us a month is enough)
    - click "CREATE"
    - provide the token as the value of `auth_token` in .prefect/config.toml.EXAMPLE and rename the file to config.toml

### 2. Install Git
[LINK](https://git-scm.com/downloads)

### 3. Set up GitHub
a. set up an SSH key
- [LINK](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- basically: `ssh-keygen -t gh_dyvenia_workshops -C "your_email@example.com"` and paste the contents inside a new key in `Settings -> SSH and GPG keys` on GitHub

b. save the passphrase locally so we don't have to provide it every time:
`eval $(ssh-agent) && ssh-add ~/.ssh/gh_dyvenia_workshops`
On Mac:
`ssh-add -K`

### 4. Install Docker
TODO

### 5. Install docker-compose
TODO

### 6. Set up Airbyte
Run the following commands:
```
git clone https://github.com/airbytehq/airbyte.git
cd airbyte
docker-compose up
```

Once you see an Airbyte banner, the UI is ready at `localhost:8000`.