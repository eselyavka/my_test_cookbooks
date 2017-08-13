#
# Cookbook:: kafka_cookbook
# Recipe:: kafka
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user 'kafka' do
    comment 'kafka user'
    shell '/bin/bash'
    manage_home true
    action :create
end

kafka_bn = File.basename(node['kafka_cookbook']['url'])
kafka_bn_no_ext = File.basename(kafka_bn, File.extname(kafka_bn))

remote_file "/tmp/#{kafka_bn}" do
    source "#{node['kafka_cookbook']['url']}"
    action :create
end

bash 'unpack_to_opt' do
    user 'root'
    cwd '/opt'
    code <<-EOH
    tar -xzvf /tmp/#{kafka_bn} && \
    ln -s /opt/#{File.basename(kafka_bn, File.extname(kafka_bn))} #{node['kafka_cookbook']['link']} && \
    chown -R kafka:kafka #{node['kafka_cookbook']['link']}/
    EOH
    not_if { File.exists?(node['kafka_cookbook']['link']) }
end

cookbook_file "#{node['kafka_cookbook']['link']}/config/server.properties"do
    source 'server.properties'
    owner 'kafka'
    group 'kafka'
    mode '0644'
    action :create
end

bash 'start_kafka' do
    user 'kafka'
    environment 'KAFKA_HEAP_OPTS' => '-Xmx256m -Xms256m'
    code "#{node['kafka_cookbook']['link']}/bin/kafka-server-start.sh -daemon #{node['kafka_cookbook']['link']}/config/server.properties"
    not_if 'pgrep -f kafka'
end
