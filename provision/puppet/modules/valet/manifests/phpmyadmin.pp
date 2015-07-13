class valet::phpmyadmin {
  require valet::devtools
  include valet::php
  include valet::httpd

  /*
   * Install phpmyadmin from repo
   */
  package { "phpmyadmin": ensure => "latest",require => Package['php56w', 'httpd'] }

  /*
   * Set phpMyAdmin conf from template
   */
  file { '/etc/httpd/conf.d/phpMyAdmin.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/valet/etc/httpd/conf.d/phpMyAdmin.conf',
    notify  => Service['httpd'],
    require => Package['phpmyadmin', 'httpd']
  }
}