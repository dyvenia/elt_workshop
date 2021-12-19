# Load dotenv secrets into environment variables
if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

pip install --user -r local-requirements.txt

# Authenticate to DockerHub
docker login -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN

docker build . -t prefect_with_jupyter -f docker/Dockerfile

cd docker && \
  docker-compose up -d && \
  sh start_prefect_agent.sh
