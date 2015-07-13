class valet::docker {
  /*
   * Install Docker Package
   */
  package { ["docker-io"]:
    ensure  => "latest",
    require => Package['epel-release.noarch']
  }

  /*
   * Docker Configuration file. add default dns server
   */
  file { "/etc/default/docker":
    ensure  => 'file',
    source  => 'puppet:///modules/valet/etc/default/docker',
    notify  => Service['docker'],
    require => Package['docker-io']
  }

}