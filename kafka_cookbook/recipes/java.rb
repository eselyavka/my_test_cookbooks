#
# Cookbook:: kafka_cookbook
# Recipe:: java
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bash 'add_java_repo' do
  user 'root'
  code <<-EOH
    apt-get install debconf-utils &&
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections &&
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections &&
    add-apt-repository #{node['kafka_cookbook']['java']['repo']} &&
    apt-get update &&
    apt-get -y install #{node['kafka_cookbook']['java']['installer']} &&
    echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
  EOH
  not_if 'grep -q JAVA_HOME -- /etc/environment'
end
