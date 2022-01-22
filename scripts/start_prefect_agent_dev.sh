# Load dotenv secrets into environment variables
cd $0/../..

if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

# Authenticate to DockerHub
docker login -u=$DOCKERHUB_USER -p=$DOCKERHUB_TOKEN

# Authenticate to Prefect cloud
prefect auth login --key $PREFECT_API_KEY

# Pull the Prefect image and start a Docker Agent
prefect agent docker start --name elt_workshop_agent_dev --label dev --key $PREFECT_API_KEY
