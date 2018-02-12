# Multiplatform Docker Swarm

Set up a 2-node multiplatform Docker swarm, running one Linux node as the master
and one Windows node.

The Windows node runs Windows Server 2016.

Includes provisioners for Virtualbox and Hyper-V

## Usage:

```
  vagrant up
```

This should start two containers, both already joined to a Docker swarm.

Due to limitations of how VMWare and Docker work, it's not possible to assign
them predictable IPs. (Docker on Windows currently doesn't network properly
over a second network adapter)

Use `vagrant ssh master` and `ifconfig` to find out the master IP. The Linux
node will be the master, and the Windows node will be a worker.

Running `docker service ps` will show one Portainer service which will be
running on the swarm master. You can access this over http://`master-ip`:9000

To communicate with the swarm master via the command-line, you must first
set your DOCKER\_HOST environment variable to point to its IP address.

For example:
```
export DOCKER_HOST=192.168.34.10
docker ps
```
would list the containers running on the host.

