require 'yaml'

hieraCommonValues = YAML.load_file("provision/hiera/common.yaml")
vagrant           = hieraCommonValues['vagrant_vm']

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-6.6-64-nocm"
  config.vm.provision "shell", path: "provision/install_puppet.sh"
  config.vm.provision "shell", path: "provision/install_repos.sh"
  
  if Vagrant.has_plugin?("vagrant-winnfsd")
    #config.winnfsd.logging = "on"
    config.winnfsd.uid = 99
    config.winnfsd.gid = 99
  end
    
  config.vm.synced_folder ".", "/vagrant",  type: "nfs", nfs_export: true
  
  vagrant['synced_folder'].each do |key, folder|
      config.vm.synced_folder  "#{folder['source']}", "#{folder['target']}", 
        #mount_options: folder['mount_options'],
        type: "nfs",
        create: true,
        nfs_export: true
  end
  
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = ["vm", "/mnt/provision/puppet/manifests"]
    puppet.hiera_config_path = "provision/hiera/config/hiera.yaml"
    puppet.options << "--modulepath=/mnt/provision/puppet/modules"
    unless ENV['PUPPET_DEBUG'].nil?
      puppet.options << "--debug"
    end
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