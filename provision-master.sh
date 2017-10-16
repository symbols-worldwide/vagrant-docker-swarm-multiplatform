#!/bin/bash

if [ "x$SWARM" == "x" ]; then
  SWARM=vagrant-local
fi
echo "Found swarm name: $SWARM"

docker swarm init --advertise-addr $MASTER_IP
docker swarm join-token worker -q > /vagrant/tmp/swarm-worker.token

