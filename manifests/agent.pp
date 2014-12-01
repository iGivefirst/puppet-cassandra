class cassandra::agent(
  $opscenter_ip,
  $opscenter_version,
) {

  validate_bool(is_ip_address($opscenter_ip))

  $agent_conf = '/var/lib/datastax-agent/conf/address.yaml'
  
  file { $agent_conf:
    ensure  => file,
    content => template("${module_name}/address.yaml.erb"),
    owner   => 'opscenter-agent',
    group   => 'opscenter-agent',
  }

  notify {"Running template ${module_name} $agent_conf":}

  
  package { 'datastax-agent':
    ensure => $opscenter_version,
  }

  service { 'datastax-agent':
    ensure     => running,
    enable     => true,
    subscribe  => File[$agent_conf],
    require    => File[$agent_conf],
  }

}
