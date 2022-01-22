# Load dotenv secrets into environment variables
cd $0/../..

if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

python3 -m pip install --user pipx
/home/$USER/.local/bin/pipx ensurepath
/home/$USER/.local/bin/pipx install prefect==$PREFECT_VERSION

# Authenticate to DockerHub
docker login registry-1.docker.io -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN