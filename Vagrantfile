# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'

REQUIRED_PLUGINS = %w(vagrant-reload)

missing_plugins = REQUIRED_PLUGINS.reject { |p| Vagrant.has_plugin? p }
abort("The following plugins are required, and not installed:\n\n  " + missing_plugins.join("\n  ")) unless missing_plugins.empty?

def windows_vm_config(windows)
  windows.vm.box = "symbols/windows_server_1709_docker"
  windows.vm.communicator = "winrm"

  # private network provides known IP addresses for the swarm master and
  # nodes
  # windows.vm.network "private_network", ip: ip

  windows.vm.provider "vmware_workstation" do |v|
    v.gui = false
    v.vmx["memsize"] = "3072"
    v.vmx["numvcpus"] = "2"
    v.vmx["vhv.enable"] = "TRUE"
  end

  windows.vm.provider "hyperv" do |hv|
    hv.memory = "2048"
    hv.cpus = 2
  end

  windows.vm.provision "shell",
    path: "disable-firewall.ps1"

  windows.vm.provision "shell",
    path: "enable-hyperv.ps1"

  windows.vm.provision :reload

  windows.vm.provision "shell",
    inline: "sleep 30"

  windows.vm.provision "shell",
    path: "chocolatey.ps1"

  windows.vm.provision "shell",
    path: "ssh-server.ps1"

  windows.vm.provision "file", source: "daemon-windows.json", destination: "/ProgramData/Docker/config/daemon.json"

  windows.vm.provision "shell",
    path: "docker-join.ps1"
end

def linux_vm_config(linux, is_master = nil)
  linux.vm.box = 'symbols/gentoo-docker'

  # private network provides known IP addresses for the swarm master and
  # nodes
  # linux.vm.network "private_network", ip: ip

  linux.vm.provider "vmware_workstation" do |v|
    v.gui = false
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = "2"
    v.vmx["vhv.enable"] = "TRUE"
  end

  linux.vm.provider "hyperv" do |hv, override|
    hv.memory = "1024"
    hv.cpus = 2

    override.vm.synced_folder('.', '/vagrant', type: 'smb', mount_options: ['vers=1.0'])
  end

  linux.vm.provision 'shell', path: 'config-docker.sh'

  linux.vm.provision 'shell', path: (is_master ? 'provision-master.sh' : 'provision-worker.sh')
end

Vagrant.configure('2') do |config|
  config.vm.define("master") { |linux| linux_vm_config(linux, true) }

  config.vm.define("worker", autostart: false) { |linux| linux_vm_config(linux) }

  config.vm.define("windows") { |windows| windows_vm_config(windows) }

  config.vm.define("windows2", autostart: false) { |windows| windows_vm_config(windows) }
end

