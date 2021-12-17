#!/bin/bash
# Generic Docker Compose

# Run a compose file in the background (detached).
function docker-compose-up {
    local DOCKER_FILE=$1
    docker compose -f $DOCKER_FILE up --detach
}

# Follo the logs of the given container running in the background.
function docker-compose-logs {
    local CONTAINER_NAME=$1
    docker compose logs --follow $CONTAINER_NAME
}