class valet::db_setup {
  /*
   * Install mysql-server
   */
  package { ["mysql-server", "mysql",]: ensure => "latest" }

  /*
   * Set password for rot user in mysql
   */
  exec { "Setup Root Password":
    command => 'mysqladmin password "secret"; if [ $? -eq 0 ]; then touch /provisioned/mysql.root; fi',
    creates => "/provisioned/mysql.root",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => Service['mysqld']
  }
}
