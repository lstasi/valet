class valet::redis {
  /*
   * Install Redis
   */
  package { ["redis"]:
    ensure  => "latest",
    require => Package['epel-release.noarch']
  }
}