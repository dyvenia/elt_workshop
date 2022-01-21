# Load dotenv secrets into environment variables
if [ -f docker/.env ]; then
  export $(echo $(cat docker/.env | sed 's/#.*//g'| xargs) | envsubst)
fi

cd $0/../../docker && \
  docker-compose up -d && \
  docker exec elt_workshop_jupyter_lab sh -c "prefect auth login --key  $PREFECT_API_KEY" && \
  sh ../scripts/start_prefect_agent_sbx.sh