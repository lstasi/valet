#PHP DevEnviroment

**You need Administrator/root privilege to run the environment**
**Or have write access to hots file**

## Software Requirements

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Git](https://git-scm.com/download/win) (optional)

## Install Vagrant Host Updater PlugIn

* vagrant plugin install vagrant-hostsupdater

## Starting virtual machinie

* From project folder run 
    *vagrant up*
* To reconfigure the machine run 
    *vagrant provision*
* To stop the machinie
    *vagrant halt*
* To access the machinie
    *vagrant ssh*
    
* You can also access the machine using the rsa.ppk file on the root of the project. Use localhost port 2222
* Once the virtual box is running you should be able to access 192.168.56.10

## Application Configuration

 Applications are defined on provision/hiera/common.yaml 
 The application array list will deploy each line as an [Silex](http://silex.sensiolabs.org/) microservice
 Each application is deploy in /service/*application name*

## Access the applications

 You can access the virtual machine with the host-only network at 192.168.56.10
 There are multiple entries on the local hosts file mapped by Vagrant host updater plugin
  
## Database

 Each application has their own database. Database schema is empty. Database name is application name replacing . by _
 You can acces the server database with phpMyAdmin, installed at http://192.168.56.10/phpmyadmin
 User Admin has access to all databases
 User/Password: root/secret admin/password
 
## Redis
 
 You can also use Redis, that installed and running at 127.0.0.1 port 6379
 
## Varnish

 There is a varnish server with in a Docker container. By defult is not running.
 To run the container, just execute sudo /vagrant/varnish/run.sh
 You can access varnish on port 8081 for example http://192.168.56.10:8081
 
## Jenkins

 Jenkins server is running on port 8080, http://192.168.56.10:8080/
 Each application has their own job, that run phpunit test on silex src folder.
 