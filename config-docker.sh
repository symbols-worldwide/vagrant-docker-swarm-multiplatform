#!/bin/bash

cat <<EOT | sudo tee /etc/docker/daemon.json
{
  "bip": "172.22.16.5/24",
  "fixed-cidr": "172.19.55.0/24"
}
EOT
systemctl restart docker
