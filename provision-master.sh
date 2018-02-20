#!/bin/bash

docker swarm init
docker swarm join-token worker -q > /vagrant/tmp/swarm-worker.token

ifconfig eth0 | grep 'inet ' | awk '{print $2}' > /vagrant/tmp/master.ip

docker network create \
  --subnet=172.22.32.5/22 \
  -o com.docker.network.bridge.enable_icc=false \
  -o com.docker.network.bridge.name=docker_gwbridge \
  docker_gwbridge

docker service create \
  --name portainer \
  --publish 9000:9000 \
  --replicas=1 \
  --constraint 'node.role == manager' \
  --constraint 'node.platform.os == linux' \
  --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
  portainer/portainer \
  -H unix:///var/run/docker.sock
