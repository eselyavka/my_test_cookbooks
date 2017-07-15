name 'nginx_redis_cookbook'
maintainer 'Evgenii Seliavka'
maintainer_email 'eselyavka at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures nginx_redis_cookbook'
long_description 'Installs/Configures nginx_redis_cookbook'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'timezone', '~> 0.0.1'
depends 'ntp', '~> 3.3.1'
