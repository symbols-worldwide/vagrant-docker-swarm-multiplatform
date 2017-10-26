#!/bin/bash

docker network create --driver overlay swarmy

docker service create -d --constraint "node.platform.os == Linux" --network swarmy --name bashy --publish mode=host,target=8080,published=8080 --replicas 1 --endpoint-mode dnsrr alpine /bin/sh -c "sleep 999999"

docker service create -d --constraint "node.platform.os == Windows" --network swarmy --name shelly --publish mode=host,target=8080,published=8080 --replicas 1 --endpoint-mode dnsrr microsoft/nanoserver powershell -c Start-Sleep -s 999999
