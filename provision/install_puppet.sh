#!/bin/bash
if [ ! -f "/provisioned/puppet_installed" ]
then
  echo "Install puppet repository"
	sudo rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
	echo "Install puppet"
	sudo yum install puppet -y
	mkdir -p /provisioned
	touch /provisioned/puppet_installed
else
	echo "Puppet already installed"
fi
