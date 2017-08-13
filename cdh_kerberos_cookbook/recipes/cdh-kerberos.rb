#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: cdh-kerberos
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w(hdfs mapred yarn HTTP).each do |user|
   principal = "#{user}/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}@#{node['cdh_kerberos_cookbook']['kerberos']['realm']}"
    bash 'create_principals' do
        user 'root'
        code <<-EOH
        kadmin.local -q "addprinc -randkey #{principal}"
        EOH
        not_if 'kadmin.local -q "getprinc -terse #{principal}" 2>/dev/null | tail -1 | awk \'{gsub(/"/, "", $1); if ($1 == "#{principal}") {exit 0} else {exit 1}}\''
    end
end

%w(hdfs mapred yarn).each do |user|
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

cookbook_file '/etc/default/hadoop-hdfs-datanode' do
    source 'hadoop-hdfs-datanode'
    mode '0644'
    owner 'root'
    group 'root'
end

service 'hadoop-hdfs-datanode' do
  action :start
end

bash 'kinit' do
    user 'hdfs'
    code <<-EOH
    kinit -k -t /etc/hadoop/conf/hdfs.keytab hdfs/#{node['cdh_kerberos_cookbook']['kerberos']['domain']}@#{node['cdh_kerberos_cookbook']['kerberos']['realm']}
    EOH
end

bash 'init_hdfs' do
    user 'root'
    code <<-EOH
    /usr/lib/hadoop/libexec/init-hdfs.sh
    EOH
    not_if 'su -s /bin/bash hdfs -c "/usr/bin/hadoop fs -test -e /user"'
end
