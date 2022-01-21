# Load dotenv secrets into environment variables
if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

python3 -m pip install --user pipx
python3 -m pipx ensurepath
/home/$USER/.local/bin/pipx install prefect==$PREFECT_VERSION

# Authenticate to DockerHub
docker login registry-1.docker.io -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN

cd $PWD/../docker && \
  docker-compose up -d && \
  docker exec elt_workshop_jupyter_lab sh -c "prefect auth login --key  $PREFECT_API_KEY" && \
  sh ../scripts/start_prefect_agent_sbx.sh