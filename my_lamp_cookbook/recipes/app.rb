#
# Cookbook:: my_lamp_cookbook
# Recipe:: app
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template "#{node['lamp']['web']['document_root']}/index.php" do
  source 'index.php.erb'
  owner 'root'
  group 'root'
  mode 0644
end
