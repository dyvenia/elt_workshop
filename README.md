# Data platform workshop
Materials for the "Building a modern data platform with Python and open-source tools" workshop.

## Agenda
1. Intro + set up - 1hr
2. Intro to Prefect - 1.5hr
3. Break - 15min
4. Airbyte - existing source - 1hr
5. Airbyte - new source 1hr (bonus)
6. Wrap up - 15min

## Pre-workshop set up
We'll be using GitHub, Docker, Prefect Cloud, and Airbyte during the workshop. To save everyone's time, please make sure you have at minimum Git + Docker with Airbyte images set up before we begin (as it needs to download quite a lot of data).

### 0. Don't use a Macbook with M1 chip
Great for many things, but not yet for local data engineering development. 

### 0b. [Windows only] Use WSL if possible
Run `wsl --install` from an administrator Powershell or CMD to install it (you may need to [install it manually](https://docs.microsoft.com/en-us/windows/wsl/install-manual) on some Windows versions). This method will get the image and set the WSL version to two. You may still need to enable Docker integration as per below instruction (bullet point 3).

If you've already installed WSL when installing Docker, you have to:
- download and install the `Ubuntu` [image](https://www.microsoft.com/store/productId/9NBLGGH4MSV6) from Microsoft store
- set the WSL version to 2: `wsl --set-version Ubuntu 2`
- enable DOcker in this Ubuntu image by checking the box next to `Ubuntu` in `Docker -> Settings -> Resources -> WSL integration`

I recommend using [Windows Terminal](https://aka.ms/terminal) to run all commands in WSL. You can find my settings [here](https://gist.github.com/Trymzet/0e59608c6ed85f4d7808ee2cf57b67b7). Once set up, you can open WSL shell like this:

![image](https://user-images.githubusercontent.com/23084949/150587554-a7bc4412-914d-4496-bb36-2398f1456009.png)

Once in the shell, type `sudo apt update && sudo apt install python3-pip`.


### 1. Install Git
[LINK](https://git-scm.com/downloads)

### 2. Set up GitHub
- create a Personal Access Token: [LINK](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)  
Select "Repo" as the scope.
- make GitHub remember the credentials: `git config --global credential.helper store`

### 3. Install Docker
- Windows/Mac: [LINK](https://docs.docker.com/get-docker/)
- Linux: [LINK](https://docs.docker.com/engine/install/#server)

### 4. Authenticate with Docker Hub
- run `docker login`
- Docker will ask you to provide your DockerHub username and password.  
Provide your username and access token, which you can generate in `hub.docker.com -> fingerprint icon -> Account Settings -> Security -> New Access Token`.  
Make sure to save that token for step 7.

### 5. Install docker-compose
> **NOTE** Linux-only (it's built into Docker on other systems)
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### 6. Set up Airbyte
Run the following commands:
```
git clone https://github.com/airbytehq/airbyte.git
cd airbyte
docker-compose up
```

Once you see an Airbyte banner, the UI is ready at `localhost:8000`.

This concludes the set up. Hit `CTRL`+`C` to spin down Airbyte.


## Workshop set up
### 1. Set up Prefect Cloud
- go to https://cloud.prefect.io
- if needed, register for the "Starter" plan
- **Note: you might need to provide your credit card details** (they have 20,000 task runs/month free tier, which for personal and educational use is basically infinite. It's also very easy to delete the account after the workshop.)
- create an API key:
    - click on the face logo in top right corner, then Account Settings -> API Keys
    - click "CREATE AN API KEY"
    - choose a name, eg "dyvenia_elt_workshop"
    - choose an expiration date (for us a month is enough)
    - click "CREATE"
- add the key to `elt_workshop/docker/.env` as `PREFECT_API_KEY`

### 2. Set up VSCode
- download: [LINK](https://code.visualstudio.com/download)
- install extensions:
```
code --install-extension ms-python.python && \
code --install-extension ms-vscode-remote.vscode-remote-extensionpack && \
code --install-extension MS-vsliveshare.vsliveshare-pack && \
code --install-extension njpwerner.autodocstring
```


### 3. Set up repo
- pull the [ELT workshop](https://github.com/dyvenia/elt_workshop) repo (provide your personal access token as password if required): `git clone https://github.com/dyvenia/elt_workshop.git`

### 7. Check that everything is running:
- open the repo in VSCode (eg. in WSL, run `cd elt_workshop && code .`)
- cretae a `.env` file in the `docker` folder (you can also just remove the `.EXAMPLE` from the example `.env` file)
- provide values for the two variables at the top (`DOCKERHUB_USER`, `DOCKERHUB_TOKEN`)
- run `sh setup.sh`
