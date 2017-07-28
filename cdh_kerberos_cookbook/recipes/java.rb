#
# Cookbook:: cdh_kerberos_cookbook
# Recipe:: java
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bash 'add_java_repo' do
  user 'root'
  code <<-EOH
    apt-get install debconf-utils &&
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections &&
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections &&
    add-apt-repository #{node['cdh_kerberos_cookbook']['java']['repo']} &&
    apt-get update &&
    apt-get -y install #{node['cdh_kerberos_cookbook']['java']['installer']} &&
    apt-get -y install #{node['cdh_kerberos_cookbook']['java']['jce']} &&
    echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
  EOH
  not_if 'grep -q JAVA_HOME -- /etc/environment'
end
