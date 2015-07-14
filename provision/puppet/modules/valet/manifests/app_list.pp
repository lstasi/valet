class valet::app_list {
  /*
   * Read Application List from Hiera
   * Hiera is on /vagrant/provision/hiera/common.yaml
   */
  $applications=hiera('applications')
  
  $applications_list = []
  $result_usr = inline_template(' <% @applications.each do |key,app|
                                     @applications_list.push(key)
                                  end %>')
  
}