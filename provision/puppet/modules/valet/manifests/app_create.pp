class valet::app_create {
  require valet::app_list
  require valet::composer
  $app_list = $valet::app_list::applications

  /*
   * Run Create Application
   */
  create_app { $app_list: }
}

define create_app () {
  /*
   * Apache Application Vhost from template
   */
  file { "/etc/httpd/conf.d/sites.d/$name.conf":
    ensure  => 'file',
    content => template("valet/vhost.conf.erb"),
    notify  => Service['httpd'],
    require => File['/etc/httpd/conf.d/sites.d']
  }

  /*
   * DB folder Script
   */
  file { "/var/www/html/services/${name}/db":
    ensure  => 'directory',
    require => Exec["build-app-${name}"]
  }
  /*
   * Create DB Name, replace dot for dash
   */
  $db_name = inline_template('<%= @name.gsub(/\./, "_") %>')

  /*
   * Database Create Script for application usting template
   */
  file { "/var/www/html/services/${name}/db/create_db.sql":
    ensure  => 'file',
    content => template("valet/create_db.sql.erb"),
    require => File["/var/www/html/services/${name}/db"]
  }

  /*
   * Create Jenkins Job Folder
   */
  file { "/var/lib/jenkins/jobs/${name}":
    ensure  => 'directory',
    owner   => "jenkins",
    group   => "jenkins",
    require => File["/var/lib/jenkins/jobs"]
  }

  /*
   * Jenkins Job Configuration File
   */
  file { "/var/lib/jenkins/jobs/${name}/config.xml":
    ensure  => 'file',
    owner   => "jenkins",
    group   => "jenkins",
    content => template("valet/jenkins_config.xml.erb"),
    require => File["/var/lib/jenkins/jobs/${name}"]
  }

  /*
   * Create Silex Skeleton Application using Composer
   */
  exec { "build-app-${name}":
    command     => "composer create-project fabpot/silex-skeleton ${name} ~2.0dev",
    user        => "vagrant",
    path        => "/usr/bin:/bin:/usr/sbin:/sbin",
    environment => ["HOME=/home/vagrant"],
    cwd         => "/var/www/html/services/",
    creates     => "/var/www/html/services/${name}/",
    timeout     => 1200,
    require     => [Package['php56w'], File['/bin/composer']]
  }

  /*
   * Crate Application Database
   */
  exec { "Create Database ${db_name}":
    command => "mysql -psecret < /var/www/html/services/${name}/db/create_db.sql",
    creates => "/var/lib/mysql/${db_name}",
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    require => [
      Package[
        'mysql-server',
        'mysql'],
      Exec['Setup Root Password'],
      File["/var/www/html/services/${name}/db/create_db.sql"]]
  }

  /*
   * Ant build.xml for Jenkins Job
   */
  file { "/var/www/html/services/${name}/build.xml":
    ensure  => 'file',
    content => template("valet/jenkins_build.xml.erb"),
    require => Exec["build-app-${name}"]
  }
}