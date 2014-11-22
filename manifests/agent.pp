class cassandra::agent(
  $opscenter_ip,
  $opscenter_version,
) {

  validate_bool(is_ip_address($opscenter_ip), 'no ip address for opscenter defined')
  
  file { "/var/lib/datastax-agent/conf/address.yaml":
    ensure  => file,
    content => template("${module_name}/address.yaml.erb"),
  }
  
  package { 'datastax-agent':
    ensure => $opscenter_version,
  }

  service { 'datastax-agent':
    ensure     => running,
    enable     => true,
    subscribe  => File['/var/lib/datastax-agent/conf/address.yaml'],
    require    => File['/var/lib/datastax-agent/conf/address.yaml'],
  }
}
