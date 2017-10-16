$swarm = ${env:SWARM}
$master = ${env:MASTER_IP}
$token = Get-Content c:\vagrant\tmp\swarm-worker.token
echo "Found swarm name: $swarm"
echo "Master IP: $master"
echo "Worker token: $token"

docker swarm join --token $token $master

