class valet::iptables {
  /*
   * Add httpd and 8080,8081 in Firewall, iptables
   */
  file { '/etc/sysconfig/system-config-firewall':
    ensure => 'file',
    owner  => root,
    group  => root,
    mode   => '600',
    source => 'puppet:///modules/valet/etc/sysconfig/system-config-firewall',
    notify => Service['iptables'],
  }
    /*
   * Add httpd and 8080,8081 in Firewall, iptables
   */
  file { '/etc/sysconfig/iptables':
    ensure => 'file',
    owner  => root,
    group  => root,
    mode   => '600',
    source => 'puppet:///modules/valet/etc/sysconfig/iptables',
    notify => Service['iptables'],
  }
}