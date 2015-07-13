class valet::phpmyadmin {
  require valet::devtools

  /*
   * Install phpmyadmin from repo
   */
  package { "phpmyadmin": ensure => "latest" }

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