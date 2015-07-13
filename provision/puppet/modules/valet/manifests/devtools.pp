class valet::devtools {
  /*
   * Install epel releases repository
   */
  package { "epel-release.noarch": ensure => "latest" }

  /*
   * Instal htop to monitorize server resources
   */
  package { "htop":
    ensure  => "latest",
    require => Package['epel-release.noarch']
  }

}