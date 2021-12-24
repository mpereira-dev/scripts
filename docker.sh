#!/bin/bash
# Generic Docker

# Aliases
alias docker-prune="docker container prune"
alias docker-down-v="docker-compose down -v"
alias docker-down-rmi="docker-compose down --rmi"

# Open an terminal session to the container with sh.
function docker-attach(){
  docker exec -it $1 /bin/sh;
}

# Open an terminal session to the container with bash.
function docker-bash(){
  docker exec -it $1 /bin/bash;
}

# Tail the logs of a specific container
function docker-logs(){
  local CONTAINER_NAME=$1;
  docker logs -f --tail 100 $CONTAINER_NAME;
}

# Build a docker iamge
function docker-build {
  local IMAGE_NAME=$1;
  docker build . -t $IMAGE_NAME;
}

# Execute the command against the list of matching images.
function docker-image-all {
  local COMMAND=$1;
  local IMAGE_NAME=$2;
  docker image $COMMAND $(docker image ls | grep $IMAGE_NAME | cut -d' ' -f1) -f;
}

# Execute the command against the list of matching containers.
function docker-container-all {
  local COMMAND=$1;
  local CONTAINER_NAME=$2;
  docker container $COMMAND $(docker container ls -a | grep $CONTAINER_NAME | cut -d' ' -f1);
}

# Removed orphaned containers
function docker-container-prune {
  docker container prune
}