#
# Cookbook:: my_lamp_cookbook
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package ['php5', 'php5-pgsql', 'libapache2-mod-php5'] do
    notifies :restart, 'httpd_service[default]', :delayed
end
