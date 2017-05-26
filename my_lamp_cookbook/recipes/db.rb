#
# Cookbook:: my_lamp_cookbook
# Recipe:: db
#
# Copyright:: 2017, The Authors, All Rights Reserved.

postgresql_database 'requests' do
  connection(
    :host      => '127.0.0.1',
    :port      => 5432,
    :username  => 'postgres',
    :password  => node['postgresql']['password']['postgres']
  )
  action :create
end
