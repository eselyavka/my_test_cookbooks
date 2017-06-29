default['lamp']['web']['document_root'] = '/var/www/default/public_html'

default['postgresql']['enable_pgdg_apt'] = true
default['postgresql']['version'] = "9.5"
default['postgresql']['dir'] = '/etc/postgresql/9.5/main'
default['postgresql']['server']['service_name'] = 'postgresql'
default['postgresql']['client']['packages'] = ["postgresql-client-9.5", "libpq-dev"]
default['postgresql']['server']['packages'] = ["postgresql-9.5"]
default['postgresql']['contrib']['packages'] = ["postgresql-contrib-9.5"]
default['postgresql']['password']['postgres'] = 'secret'


default['lamp']['db']['name'] = 'requests'
default['lamp']['db']['user'] = 'web'
default['lamp']['db']['password'] = 'secret'
default['tz'] = 'Europe/Moscow'
default['lamp']['db']['database'] = 'requests'
default['lamp']['chef_etc_dir'] = '/etc/chef'
default['lamp']['secret_key_name'] = 'secret.key'
