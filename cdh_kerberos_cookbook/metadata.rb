name 'cdh_kerberos_cookbook'
maintainer 'Evgenii Seliavka'
maintainer_email 'eselyavka at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures cdh_kerberos_cookbook'
long_description 'Installs/Configures cdh_kerberos_cookbook'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'system', '~> 0.11.3'
depends 'ntp', '~> 3.3.1'
depends 'java', '~> 1.50.0'
