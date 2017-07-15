name 'enterprise_chef'
maintainer 'Evgenii Seliavka'
maintainer_email 'eseliavka at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures enterprise_chef'
long_description 'Installs/Configures enterprise_chef'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'selinux', '~> 1.0.4'
