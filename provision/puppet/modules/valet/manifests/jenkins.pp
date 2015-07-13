class valet::jenkins {
  /*
   * Install Jenkins
   */
  package { ["jenkins"]:
    ensure  => "latest",
    require => Package['java-1.7.0-openjdk']
  }

  /*
   * Install Open Java 1.7
   */
  package { ["java-1.7.0-openjdk"]: ensure => "latest", }

  /*
   * Install Ant to run Jenkins Jobs
   */
  package { ["ant"]:
    ensure  => "latest",
    require => Package['java-1.7.0-openjdk']
  }

  /*
   * Install Jenkins Plugins
   */
  file { '/var/lib/jenkins/plugins':
    ensure  => 'directory',
    source  => 'puppet:///modules/valet/jenkins-plugins',
    recurse => true,
    owner   => "jenkins",
    group   => "jenkins",
    notify  => Service['jenkins'],
    require => Package['jenkins']
  }

  /*
   * Create Jenkins Job folder to deploy job configurations
   */
  file { "/var/lib/jenkins/jobs":
    ensure => 'directory',
    owner  => "jenkins",
    group  => "jenkins",
    require => Package['jenkins']
  }

}