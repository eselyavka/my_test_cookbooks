name 'lapp_cookbook'
maintainer 'Evgenii Seliavka'
maintainer_email 'eselyavka at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures lapp_cookbook'
long_description 'Installs/Configures lapp_cookbook'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'timezone', '~> 0.0.1'
depends 'ntp', '~> 3.3.1'
depends 'httpd', '~> 0.4.5'
depends 'postgresql', '~> 6.1.1'
depends 'database', '~> 6.1.1'
