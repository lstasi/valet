class valet::httpd {
  /*
   * Install Apache Server
   */
  package { "httpd": ensure => "latest" }

  /*
   * Main configuration file for Apache
   */
  file { '/etc/httpd/conf/httpd.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/valet/etc/httpd/conf/httpd.conf',
    notify  => Service['httpd'],
    require => Package['httpd']
  }

  /*
   * Vhost folder for Apache
   */
  file { '/etc/httpd/conf.d/sites.d':
    ensure  => 'directory',
    require => Package['httpd']
  }

  /*
   * Root Folder for default virtual host in Apache
   */
  file { "/var/www/html/services":
    ensure  => 'link',
    target  => "/vagrant/services",
    require => Package['httpd']
  }
}