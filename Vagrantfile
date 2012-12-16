# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :router do |router_config|
    router_config.vm.box = "router"
    router_config.vm.host_name = "router"
    router_config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    # Network config
    router_config.vm.network :bridged, :adapter => 1, :bridge => "manage", :auto_config => false  # managment
    router_config.vm.network :bridged, :adapter => 2, :bridge => "ext", :auto_config => false # external
    router_config.vm.network :bridged, :adapter => 3, :bridge => "priv", :auto_config => false  # private
    router_config.vm.network :bridged, :adapter => 4, :bridge => "prod", :auto_config => false  # production

    # Ssh options
    router_config.ssh.port = 22
    router_config.ssh.host = "192.168.0.2"

    # Shared folders
    router_config.vm.share_folder "files", "/etc/puppet/files", "files" # Fix for puppet files

    # Update puppet before provision
    router_config.vm.provision :shell, :path => "update-puppet.sh"

    # Puppet
    router_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
        puppet.manifest_file = "router.pp"
    end
  end
end
