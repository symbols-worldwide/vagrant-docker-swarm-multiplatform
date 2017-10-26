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

The Linux node, which will be the swarm master, will be listening on
`192.168.34.10`. The Windows node, which will be a swarm worker, will be
listening on `192.168.34.12`.

Running `docker service ps` will show one Portainer service which will be
running on the swarm master. You can access this over http://192.168.34.10:9000

Portainer provides a gui to view running containers, services, stacks and so on.
You will want to read the Docker documentation on how these work, for the
details. Note that it's still preferable to deploy services from the command-
line interface as Portainer doesn't (yet) allow you to make some settings
(`dnsrr` routing mode, and `host` publishing mode) required to make Windows
containers work.

To communicate with the swarm master via the command-line, you must first
set your DOCKER\_HOST environment variable to point to its IP address.

For example:
```
export DOCKER_HOST=192.168.34.10
docker ps
```
would list the containers running on the host.

Running the `test.sh` script included in this repository will create a Windows
and Linux service, each running 'sleep' for a long time. This enables you to
see them working, confirm they replicate correctly and run commands inside
them using `docker exec`.

