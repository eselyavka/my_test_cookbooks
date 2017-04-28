package 'build-essential'
package 'tcl8.5'

bash 'install_stable_redis' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    rm -rf -- /tmp/stable-redis* &&
    wget http://download.redis.io/releases/redis-stable.tar.gz &&
    tar -xzf redis-stable.tar.gz &&
    cd redis-stable &&
    make &&
    make test &&
    make install &&
    echo -n | sudo /tmp/redis-stable/utils/install_server.sh &&
    rm -rf -- /tmp/stable-redis*
    EOH
    not_if { ::File.exist?('/usr/local/bin/redis-server') }
end

user 'redis' do
    comment 'A redis user'
    shell '/bin/bash'
    action :create
end

template '/etc/redis/6379.conf' do
    source '6379.conf.erb'
    mode '0644'
end

service 'redis_6379' do
    action [:start, :enable]
end
