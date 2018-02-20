#!/bin/bash

mkdir /etc/docker
cat <<EOT | sudo tee /etc/docker/daemon.json
{
  "bip": "172.22.16.5/22",
  "fixed-cidr": "172.22.16.5/24"
}
EOT
systemctl restart docker
