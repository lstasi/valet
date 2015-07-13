class valet::app {
  /*
   * Include class for Application
   */
  include valet::db_setup
  include valet::httpd
  include valet::iptables
  include valet::app_create
  include valet::php
  include valet::redis
  include valet::docker
  include valet::jenkins

  /*
   * Configure Service to start and run on boot
   */
  service { ["httpd", "mysqld", "redis", "docker", "jenkins","iptables"]:
    ensure  => running,
    enable  => true,
    require => Package["mysql-server", "httpd", "redis", "docker-io", "jenkins"]
  }

}