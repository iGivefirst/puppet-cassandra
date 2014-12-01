require 'spec_helper'

describe 'cassandra::agent' do

  let(:params) do
    { 
      :opscenter_ip => '192.168.2.1', 
      :opscenter_version   => '5.0.1',
    }
  end


  it 'does contain class cassandra::agent' do
    should contain_class('cassandra::agent').with({
      :opscenter_ip => '192.168.2.1', 
      :opscenter_version   => '5.0.1',
    })
  end

  it 'does contain package datastax-agent' do
    should contain_package('datastax-agent')
  end

  it 'file /var/lib/datastax-agent/conf/address.yaml' do
    should contain_file('/var/lib/datastax-agent/conf/address.yaml').with({
      :ensure  => 'file',
      :path    => '/var/lib/datastax-agent/conf/address.yaml',
      :owner   => 'opscenter-agent',
      :group   => 'opscenter-agent',
      :content => /stomp_interface: 192.168.2.1/,
    })
  end

  it 'does contain service agent' do
    should contain_service('datastax-agent').with({
      :ensure     => 'running',
      :enable     => 'true',
    })
  end
   
end
