node default {
  class { 'cassandra':
    version             => '2.0.11',
    seeds               => [$::fqdn, 'cassandra02.local'],
    num_tokens          => 1,
    topology_default    => 'Cassandra:rack1', 
    topology            => ["${::fqdn}=Cassandra:rack1"],
    opscenter_ip        => '192.168.180.1',
    opscenter_version   => '5.0.1',
    cluster_name        => 'goldgriff',
    partitioner         => 'org.apache.cassandra.dht.RandomPartitioner', 
    max_heap_size       => '2G',
    heap_newsize        => '800M',
    endpoint_snitch     => 'PropertyFileSnitch',
    listen_address      => $::fqdn,
  }
}
