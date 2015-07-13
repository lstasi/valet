class valet::app_list {
  /*
   * Read Application List from Hiera
   * Hiera is on /vagrant/provision/hiera/common.yaml
   */
  $applications=hiera('applications')
}