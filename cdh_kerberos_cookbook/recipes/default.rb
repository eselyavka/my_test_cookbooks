#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update 'update' do
  action :update
end
