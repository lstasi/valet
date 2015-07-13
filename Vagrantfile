require 'yaml'

hieraCommonValues = YAML.load_file("provision/hiera/common.yaml")

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-6.6-64-nocm"
  config.vm.provision "shell", path: "provision/install_puppet.sh"
  config.vm.provision "shell", path: "provision/install_repos.sh"
  config.vm.provision "puppet" do |puppet|
	puppet.options = "--verbose"
	puppet.manifests_path = "provision/puppet/manifests"
    puppet.module_path = "provision/puppet/modules"
    puppet.hiera_config_path = "provision/hiera/config/hiera.yaml"
	end
  config.vm.provider "virtualbox" do |v|
		v.memory = 4096
		v.cpus = 4
        v.customize ["modifyvm", :id, "--vram", "9"]
  end
  config.vm.network "private_network", ip: "192.168.56.10"
  
  config.vm.hostname = "dev.valet.net"
  config.vm.network "private_network", ip: "192.168.56.10"
  
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.hostsupdater.aliases = hieraCommonValues['applications']
  else
    puts "Hosts names won't be accessible from your host machine, because vagrant hostsupdater plugin is not installed"
    puts "To install plugin use:"
    puts "    vagrant plugin install vagrant-hostsupdater"
    puts ""
  end
  
end