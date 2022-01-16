# Load dotenv secrets into environment variables
if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install prefect==$PREFECT_VERSION

# Authenticate to DockerHub
docker login -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN

docker build . -t local/prefect_with_jupyter -f docker/Dockerfile --build-arg PREFECT_VERSION=$PREFECT_VERSION-python3.9

cd docker && \
  docker-compose up -d && \
  docker exec elt_jupyter_lab sh -c "prefect auth login --key  $PREFECT_API_KEY" && \
  sh start_prefect_agent.sh
