#!/bin/sh

echo initializing docker daemon

dockerd &> dockerd-logfile &

sleep 5

echo "Checking if Swarm is already initialized"

if ! docker node ls &> /dev/null; then
    echo "Initializing Swarm"
    docker swarm init --advertise-addr $(hostname -i)

    echo "Collecting worker token"
    docker swarm join-token worker -q > /scripts/worker_token

    echo "Swarm initialization complete"
else
    echo "Swarm is already initialized"
fi

docker stack deploy --compose-file /nginx/compose.yml --resolve-image never -d nginx \
&& tail -f /dev/null
