# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.define "master" do |master|
    master.vm.box = 'symbols/gentoo-docker'

    # private network provides known IP addresses for the swarm master and
    # nodes
    master.vm.network "private_network", ip: '192.168.34.10'

    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
    end

    master.vm.provider "hyperv" do |hv|
      hv.memory = "1024"
      hv.cpus = 2
    end

    master.vm.provision 'shell',
      path: 'provision-master.sh',
      env: { SWARM: 'devbox', MASTER_IP: '192.168.34.10' }
  end

  config.vm.define "windows" do |windows|
    windows.vm.box = "symbols/windows_2016_docker_core"
    windows.vm.communicator = "winrm"

    # private network provides known IP addresses for the swarm master and
    # nodes
    windows.vm.network "private_network", ip: '192.168.34.11'

    windows.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end

    windows.vm.provider "hyperv" do |hv|
      hv.memory = "2048"
      hv.cpus = 2
    end

    windows.vm.provision "shell",
      path: "docker-join.ps1",
      env: { SWARM: 'devbox', MASTER_IP: '192.168.34.10' }
  end
end

