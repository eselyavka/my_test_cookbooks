#
# Cookbook:: kafka_cookbook
# Recipe:: zookeeper
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_package %w(zookeeper zookeeper-bin zookeeperd)

service 'zookeeper' do
    action [ :enable, :start ]
end
