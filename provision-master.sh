#!/bin/bash

cat <<EOT | sudo tee /etc/docker/daemon.json
{
  "bip": "172.22.16.5/24",
  "fixed-cidr": "172.19.55.0/24",
  "iptables": false
}
EOT
systemctl restart docker

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

