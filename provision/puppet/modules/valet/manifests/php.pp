class valet::php {
  /*
   * Install php 5.6
   */
  package { ["php56w", "php56w-opcache", "php56w-mysql", "php56w-pecl-redis", "php56w-pecl-xdebug"]: ensure => "latest" }

  /*
   * Set php.ini from template
   */
  file { '/etc/php.ini':
    ensure  => 'file',
    source  => 'puppet:///modules/valet/etc/php.ini',
    notify  => Service['httpd'],
    require => Package['php56w']
  }

  /*
   * Manual install php-unit
   */
  exec { 'php-unit-install':
    command => "curl https://phar.phpunit.de/phpunit.phar -o /bin/phpunit.phar",
    path    => "/usr/bin:/bin:/usr/sbin:/sbin",
    creates => "/bin/phpunit.phar",
    require => Package['php56w']
  }

  /*
   * Change phpunit mod
   */
  file { "/bin/phpunit.phar":
    mode    => "755",
    require => Exec['php-unit-install']
  }

  /*
   *  php-unit symlink
   */
  file { "/bin/phpunit":
    ensure  => 'link',
    target  => "/bin/phpunit.phar",
    require => Exec['php-unit-install']
  }
}