#
# Cookbook:: lapp_cookbook
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory node['lapp']['web']['document_root'] do
  recursive true
end

httpd_config 'my-default' do
  name 'my-default'
  source 'default.conf.erb'
  action :create
end

httpd_service 'default' do
  mpm 'prefork'
  action [:create, :start]
  subscribes :restart, '[httpd_config[my-default],httpd_module[php5]]'
end

httpd_module 'php5' do
  action :create
end
