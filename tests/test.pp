node default {
  class { 'cassandra':
    version           => '2.0.11',
    seeds             => ['cassandra01.local', 'cassandra02.local'],
    num_tokens        => 1,
    initial_token     => $my_intial_token
    topology_default  => 'Cassandra:rack1', 
    topology          => ["${::fqdn}=Cassandra:rack1"],
    opscenter_ip      => '192.168.180.1',
    opscenter_version => '5.0.1',
    cluster_name      => 'goldgriff',
    partitioner       => 'org.apache.cassandra.dht.RandomPartitioner', 
    max_heap_size     => '2G',
    heap_newsize      => '800M',
    endpoint_snitch   => 'PropertyFileSnitch',
    listen_address    => $::fqdn,
  }
}
