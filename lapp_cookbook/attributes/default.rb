default['lapp']['web']['document_root'] = '/var/www/default/public_html'

default['postgresql']['enable_pgdg_apt'] = true
default['postgresql']['version'] = "9.5"
default['postgresql']['dir'] = '/etc/postgresql/9.5/main'
default['postgresql']['server']['service_name'] = 'postgresql'
default['postgresql']['client']['packages'] = ["postgresql-client-9.5", "libpq-dev"]
default['postgresql']['server']['packages'] = ["postgresql-9.5"]
default['postgresql']['contrib']['packages'] = ["postgresql-contrib-9.5"]
default['postgresql']['password']['postgres'] = 'secret'


default['lapp']['db']['name'] = 'requests'
default['lapp']['db']['user'] = 'web'
default['lapp']['db']['password'] = 'secret'
default['tz'] = 'Europe/Moscow'
default['lapp']['db']['database'] = 'requests'
default['lapp']['chef_etc_dir'] = '/etc/chef'
default['lapp']['secret_key_name'] = 'secret.key'
