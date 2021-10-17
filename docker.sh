#!/bin/bash
# Generic Docker

# Aliases
alias docker-prune="docker container prune"
alias docker-down-v="docker-compose down -v"
alias docker-down-rmi="docker-compose down --rmi"

function docker-attach(){
  docker exec -it $1 /bin/sh;
}

# Tail the logs of a specific container
function docker-logs(){
  local CONTAINER_NAME=$1
  docker logs -f --tail 100 $CONTAINER_NAME;
}

# Build a docker iamge
function docker-build {
  local IMAGE_NAME=$1
  docker build . -t $IMAGE_NAME;
}

# Force remove all iamges matching the given expression.
function docker-image-rm-all {
  local IMAGE_NAME=$1
  docker image rm $(docker image ls | grep $IMAGE_NAME | cut -d' ' -f1) -f
}