#
# Cookbook:: enterprise-chef
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

selinux_state "SELinux Disable" do
  action :disabled
  notifies :request_reboot, 'reboot[selinux_requires_reboot]', :immediately
end

reboot 'selinux_requires_reboot' do
  reason 'selinux will be disable only after reboot'
  action :nothing
end

package_url = node['enterprise-chef']['url']
package_name = ::File.basename(package_url)
package_checksum = node['enterprise-chef']['checksum']
package_local_path = "#{Chef::Config[:file_cache_path]}/#{package_name}"

remote_file package_local_path do
    source package_url
    checksum package_checksum
end

rpm_package package_name do
    source package_local_path
    notifies :run, 'execute[chef_server_reconfigure]', :immediately
end

execute 'chef_server_reconfigure' do
    command 'chef-server-ctl reconfigure'
    action :nothing
end
