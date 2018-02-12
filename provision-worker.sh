#!/bin/bash

TOKEN=`cat /vagrant/tmp/swarm-worker.token`
MASTER_IP=`cat /vagrant/tmp/master.ip`

docker swarm join --token $TOKEN $MASTER_IP
