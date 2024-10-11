#!/bin/sh

echo "Starting dockerd"

dockerd &> dockerd-logfile &

sleep 5

echo "Checking if already part of a Swarm"

if docker info --format '{{.Swarm.LocalNodeState}}' | grep -q 'inactive'; then
    echo "Node is not part of a Swarm, joining now"

    while [ ! -s /scripts/worker_token ]; do
        echo "Waiting for token"
        sleep 10
    done

    TOKEN=$(cat /scripts/worker_token)
    docker swarm join --token $TOKEN manager:2377
else
    echo "Node is already part of a Swarm"
fi

tail -f /dev/null