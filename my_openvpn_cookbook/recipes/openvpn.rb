#
# Cookbook:: my_openvpn
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sysctl::default'
include_recipe 'iptables::default'

package ['openvpn', 'easy-rsa']

sysctl_param 'net.ipv4.ip_forward' do
  value 1
end

iptables_rule 'enable_nat' do
  lines '-A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE'
  table :nat
end

bash 'copy easy-rsa' do
  user "root"
  code "cp -r /usr/share/easy-rsa/ /etc/openvpn"
  not_if { ::File.directory?("/etc/openvpn/easy-rsa") }
end

template '/etc/openvpn/easy-rsa/vars' do
  source 'vars.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'generate dh' do
  user 'root'
  code "openssl dhparam -out /etc/openvpn/dh#{node['bit_count']}.pem #{node['bit_count']}"
  creates "/etc/openvpn/dh#{node['bit_count']}.pem"
end

bash 'setup CA' do
  files = %w[server.crt server.key ca.crt]
  user 'root'
  cwd '/etc/openvpn/easy-rsa'
  code <<-EOH
  source vars &&
  ./clean-all &&
  ./build-ca --batch &&
  ./build-key-server --batch #{node['key_name']} &&
  cp ./keys/{#{files.join(",")}} ../
  EOH

  files.each do |f|
    not_if { ::File.exist?(::File.join("/etc/openvpn", f)) }
  end
end

directory '/var/log/ovpn' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/openvpn/server.conf' do
  source 'server.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[openvpn]', :immediate
end

service 'openvpn' do
    action [:start, :enable]
end
