# Note this can remove your non-ELT Workshop containers.

cd $0/../../docker

docker-compose down
docker system prune -f --volumes