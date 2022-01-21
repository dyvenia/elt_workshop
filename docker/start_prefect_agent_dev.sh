# Load dotenv secrets into environment variables
if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi

# Authenticate to DockerHub
docker login -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN

# Authenticate to Prefect cloud
prefect auth login --key $PREFECT_API_KEY

# Pull the Prefect image and start a Docker Agent
prefect agent docker start --name elt_workshop_agent_dev --label dev --key $PREFECT_API_KEY
