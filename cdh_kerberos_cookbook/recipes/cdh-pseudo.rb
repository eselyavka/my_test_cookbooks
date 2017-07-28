#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: cdh-pseudo
#
# Copyright:: 2017, The Authors, All Rights Reserved.

remote_file '/etc/apt/sources.list.d/cloudera.list' do
  source 'https://archive.cloudera.com/cdh5/ubuntu/xenial/amd64/cdh/cloudera.list'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

remote_file '/etc/apt/trusted.gpg.d/archive.key' do
  source 'https://archive.cloudera.com/cdh5/ubuntu/xenial/amd64/cdh/archive.key'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  not_if 'test -f /etc/apt/trusted.gpg.d/archive.key'
end

bash 'add-cdh-key' do
  code "apt-key add /etc/apt/trusted.gpg.d/archive.key"
end

apt_update 'update' do
    action :update
end

apt_package 'hadoop-conf-pseudo'
