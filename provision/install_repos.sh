#!/bin/bash
if [ ! -f "/provisioned/webtatic_installed" ]
then
  echo "Install webtatic repository"
	sudo rpm -ivh https://mirror.webtatic.com/yum/el6/latest.rpm
	mkdir -p /provisioned
	touch /provisioned/webtatic_installed
else
	echo "Webtatic already installed"
fi

if [ ! -f "/provisioned/jenkins_repo_installed" ]
then
  echo "Install Jenkins repository"
	sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
	sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	mkdir -p /provisioned
	touch /provisioned/jenkins_repo_installed
else
	echo "Jenkins Repo already installed"
fi
