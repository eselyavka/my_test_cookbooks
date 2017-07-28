#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: kerberos
#
# Copyright:: 2017, The Authors, All Rights Reserved.


template '/tmp/kerberos-selection' do
  source 'kerberos-selection.erb'
  mode '0644'
end

bash 'set_kerberos_selection' do
    code "cat /tmp/kerberos-selection | debconf-set-selections"
    not_if "dpkg -l | grep -iq krb5-kdc"
end

apt_update

package %w(krb5-kdc krb5-admin-server)

cookbook_file '/usr/sbin/krb5_newrealm' do
    source 'krb5_newrealm'
    mode '0755'
    owner 'root'
    group 'root'
    action :create
end

bash 'create_realm' do
    code "krb5_newrealm -P secret"
    not_if "test -f /var/lib/krb5kdc/principal"
end
