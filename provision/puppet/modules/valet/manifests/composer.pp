class valet::composer () {
  /*
   * Manual Install composer
   */
  exec { 'composer-install':
    command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin",
    path    => "/usr/bin:/bin:/usr/sbin:/sbin",
    creates => "/bin/composer.phar",
    require => Package['php56w']
  }

  /*
   * Composer symlink
   */
  file { "/bin/composer":
    ensure  => 'link',
    target  => "/bin/composer.phar",
    require => Exec['composer-install']
  }
}