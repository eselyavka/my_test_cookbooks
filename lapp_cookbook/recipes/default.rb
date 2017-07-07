#
# Cookbook:: lapp_cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

secret_key="#{node['lapp']['chef_etc_dir']}/#{node['lapp']['secret_key_name']}"

apt_update 'update' do
  action :update
end

file "#{secret_key}" do
  mode '0600'
  owner 'root'
  group 'root'
  verify "test -f #{secret_key}"
end

cookbook_file "#{secret_key}" do
  source "#{node['lapp']['secret_key_name']}"
end

ruby_block 'setup_secrets' do
  block do
    postgres_pass=data_bag_item('passwords', 'db', IO.read("#{secret_key}"))
    node.override['postgresql']['password']['postgres'] = postgres_pass['postgres']
    node.override['lapp']['db']['password'] = postgres_pass['web']
  end
  subscribes :run, "cookbook_file[#{secret_key}]", :immediate
end
