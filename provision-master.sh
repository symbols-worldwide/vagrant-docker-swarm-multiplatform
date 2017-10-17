#!/bin/bash

if [ "x$SWARM" == "x" ]; then
  SWARM=vagrant-local
fi
echo "Found swarm name: $SWARM"

docker swarm init --advertise-addr $MASTER_IP
docker swarm join-token worker -q > /vagrant/tmp/swarm-worker.token

docker service create \
  --name portainer \
  --publish 9000:9000 \
  --replicas=1 \
  --constraint 'node.role == manager' \
  --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
  portainer/portainer \
  -H unix:///var/run/docker.sock

