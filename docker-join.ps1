Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

Stop-Service docker
Start-Service docker

$swarm = ${env:SWARM}
$master = ${env:MASTER_IP}
$token = Get-Content c:\vagrant\tmp\swarm-worker.token
echo "Found swarm name: $swarm"
echo "Master IP: $master"
echo "Worker token: $token"

[Environment]::SetEnvironmentVariable("DOCKER_HOST", "127.0.0.1", "Machine")
$env:DOCKER_HOST = "127.0.0.1"

sc.exe config docker start="delayed-auto"

docker swarm join --token $token $master

Restart-Computer -Force

