Stop-Service docker
Start-Service docker

Sleep 5

$master = Get-Content c:\vagrant\tmp\master.ip
$token = Get-Content c:\vagrant\tmp\swarm-worker.token

docker swarm join --token $token $master
sc.exe config docker start="delayed-auto"
