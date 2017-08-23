#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: cdh-kerberos
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user_ubuntu = 'ubuntu'
file_ubuntu = "/home/#{user_ubuntu}/#{user_ubuntu}.keytab"

users=%w(hdfs mapred yarn HTTP)
users.push(user_ubuntu)

users.each do |user|
   principal = "#{user}/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}@#{node['cdh_kerberos_cookbook']['kerberos']['realm']}"
    bash 'create_principals' do
        user 'root'
        code <<-EOH
        kadmin.local -q "addprinc -randkey #{principal}"
        EOH
        not_if "kadmin.local -q 'getprinc -terse #{principal}' 2>/dev/null | tail -1 | awk '{gsub(/\"/, \"\", $1); if ($1 == \"#{principal}\") {exit 0} else {exit 1}}'"
    end
end

bash "create_keytab_for_#{user_ubuntu}" do
  user 'root'
  code <<-EOH
  kadmin.local -q "xst -norandkey -k #{file_ubuntu} #{user_ubuntu}/#{node['cdh_kerberos_cookbook']['kerberos']['domain']} HTTP/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}" && chown #{user_ubuntu}:#{user_ubuntu} #{file_ubuntu} && chmod 0400 #{file_ubuntu}
  EOH
  not_if { ::File.exists?(file_ubuntu) }
end

users.pop
users.pop

users.each do |user|
    file = "/etc/hadoop/conf/#{user}.keytab"
    bash 'create_keytabs' do
        user 'root'
        code <<-EOH
        kadmin.local -q "xst -norandkey -k #{file} #{user}/#{node['cdh_kerberos_cookbook']['kerberos']['domain']} HTTP/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}" && chown #{user}:hadoop #{file} && chmod 0400 #{file}
        EOH
        not_if { ::File.exists?(file) }
    end
end


cookbook_file '/etc/hadoop/conf/core-site.xml' do
    source 'core-site.xml'
    mode '0644'
    owner 'root'
    group 'hadoop'
    action :create
end

template '/etc/hadoop/conf/hdfs-site.xml' do
    source 'hdfs-site.xml.erb'
    owner 'root'
    group 'hadoop'
    mode '0644'
end

template '/etc/hadoop/conf/ssl-server.xml' do
    source 'ssl-server.xml.erb'
    owner 'root'
    group 'hadoop'
    mode '0644'
end

template '/etc/hadoop/conf/ssl-client.xml' do
    source 'ssl-client.xml.erb'
    owner 'root'
    group 'hadoop'
    mode '0644'
end

bash 'generate_certs' do
    user 'root'
    code <<-EOH
    keytool -genkey -noprompt \
            -alias #{node['cdh_kerberos_cookbook']['kerberos']['domain']} \
            -dname "CN=#{node['cdh_kerberos_cookbook']['kerberos']['domain']}, OU=#{node['cdh_kerberos_cookbook']['tls']['crt']['ou']}, O=#{node['cdh_kerberos_cookbook']['tls']['crt']['o']}, L=#{node['cdh_kerberos_cookbook']['tls']['crt']['l']}, S=#{node['cdh_kerberos_cookbook']['tls']['crt']['s']}, C=#{node['cdh_kerberos_cookbook']['tls']['crt']['c']}" \
            -keystore #{node['cdh_kerberos_cookbook']['tls']['keystore']['file']} \
            -storepass #{node['cdh_kerberos_cookbook']['tls']['keystore']['passwd']} \
            -keypass #{node['cdh_kerberos_cookbook']['tls']['keystore']['key']['passwd']} &&
    keytool -exportcert -keystore #{node['cdh_kerberos_cookbook']['tls']['keystore']['file']} \
            -alias #{node['cdh_kerberos_cookbook']['kerberos']['domain']} -storepass #{node['cdh_kerberos_cookbook']['tls']['keystore']['passwd']} | \
    keytool -import -keystore #{node['cdh_kerberos_cookbook']['tls']['truststore']['file']} -alias #{node['cdh_kerberos_cookbook']['kerberos']['domain']} -noprompt -storepass #{node['cdh_kerberos_cookbook']['tls']['truststore']['passwd']}
    EOH
    not_if { ::File.exists?(node['cdh_kerberos_cookbook']['tls']['truststore']['file']) && ::File.exists?(node['cdh_kerberos_cookbook']['tls']['keystore']['file']) }
end

bash 'format_nn' do
    user 'hdfs'
    code <<-EOH
    hdfs namenode -format
    EOH
    not_if { ::File.exists?('/var/lib/hadoop-hdfs/cache/hdfs/') }
end

service 'hadoop-hdfs-namenode' do
  action :start
end

service 'hadoop-hdfs-secondarynamenode' do
  action :start
end

service 'hadoop-hdfs-datanode' do
  action :start
end

bash 'kinit' do
    user 'hdfs'
    code <<-EOH
    kinit -k -t /etc/hadoop/conf/hdfs.keytab hdfs/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}@#{node['cdh_kerberos_cookbook']['kerberos']['realm']} && hdfs dfs -mkdir -p /user/hdfs /user/#{user_ubuntu}
    EOH
end

bash "kinit_#{user_ubuntu}" do
    user 'ubuntu'
    code <<-EOH
    kinit -k -t #{file_ubuntu} #{user_ubuntu}/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}@#{node['cdh_kerberos_cookbook']['kerberos']['realm']}
    EOH
end

bash 'init_hdfs' do
    user 'root'
    code <<-EOH
    /usr/lib/hadoop/libexec/init-hdfs.sh
    EOH
    not_if 'su -s /bin/bash hdfs -c "/usr/bin/hadoop fs -test -e /tmp"'
end
