# -*- mode: ruby -*-
# vi: set ft=ruby :

begin
    require 'vagrant-hiera'
rescue LoadError
    puts "Please install vagrant-hiera before running your virtual box-es"
end

Vagrant::Config.run do |config|
  config.vm.define :router do |router_config|
    router_config.vm.box = "router"
    router_config.vm.host_name = "router"
    router_config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    router_config.vm.customize ["modifyvm", :id, "--memory", "256"]

    # Network config
    router_config.vm.network :bridged, :adapter => 1, :bridge => "manage", :mac => "080027000001", :auto_config => false  # managment
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

    # Hiera
    begin
        router_config.hiera.config_path = "./puppet"
        router_config.hiera.config_file = "hiera.yaml"
        router_config.hiera.data_path = "./puppet/hieradata"
    rescue NoMethodError
        puts "Please install vagrant-hiera before running your virtual box-es"
    end
  end

  config.vm.define :prod do |prod_config|
    prod_config.vm.box = "prod"
    prod_config.vm.host_name = "prod"
    prod_config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    prod_config.vm.customize ["modifyvm", :id, "--memory", "128"]

    # Network config
    prod_config.vm.network :bridged, :adapter => 1, :bridge => "manage", :mac => "080027000004", :auto_config => false  # managment
    prod_config.vm.network :bridged, :adapter => 4, :bridge => "prod", :auto_config => false # production

    # Ssh options
    prod_config.ssh.port = 22
    prod_config.ssh.host = "192.168.0.7"

    # Shared folders
    prod_config.vm.share_folder "files", "/etc/puppet/files", "files" # Fix for puppet files

    # Update puppet before provision
    prod_config.vm.provision :shell, :path => "update-puppet.sh"

    # Puppet
    prod_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
        puppet.manifest_file = "prod.pp"
    end
  end

  config.vm.define :priv do |priv_config|
    priv_config.vm.box = "priv"
    priv_config.vm.host_name = "priv"
    priv_config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    priv_config.vm.customize ["modifyvm", :id, "--memory", "128"]

    # Network config
    priv_config.vm.network :bridged, :adapter => 1, :bridge => "manage", :mac => "080027000005", :auto_config => false  # managment
    priv_config.vm.network :bridged, :adapter => 3, :bridge => "priv", :auto_config => false # private

    # Ssh options
    priv_config.ssh.port = 22
    priv_config.ssh.host = "192.168.0.8"

    # Shared folders
    priv_config.vm.share_folder "files", "/etc/puppet/files", "files" # Fix for puppet files

    # Update puppet before provision
    priv_config.vm.provision :shell, :path => "update-puppet.sh"

    # Puppet
    priv_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
        puppet.manifest_file = "priv.pp"
    end
  end

end
