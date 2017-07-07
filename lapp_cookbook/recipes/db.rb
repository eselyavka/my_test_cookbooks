#
# Cookbook:: lapp_cookbook
# Recipe:: db
#
# Copyright:: 2017, The Authors, All Rights Reserved.

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database node['lapp']['db']['name'] do
  connection(
    :host      => '127.0.0.1',
    :port      => 5432,
    :username  => 'postgres',
    :password  => node['postgresql']['password']['postgres']
  )
  action :create
end

postgresql_database_user node['lapp']['db']['user'] do
  connection postgresql_connection_info
  password node['lapp']['db']['password']
  database_name node['lapp']['db']['database']
  schema_name 'public'
  tables [:all]
  sequences [:all]
  functions [:all]
  privileges [:all]
  action [:create, :grant, :grant_schema, :grant_table, :grant_sequence, :grant_function]
end
