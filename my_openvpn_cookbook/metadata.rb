name 'my_openvpn'
maintainer 'Evgenii Seliavka'
maintainer_email 'test@example.com'
license 'All Rights Reserved'
description 'Installs/Configures my_openvpn'
long_description 'Installs/Configures my_openvpn'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'timezone', '~> 0.0.1'
depends 'ntp', '~> 3.3.1'
depends 'sysctl', '~> 0.8.1'
depends 'iptables', '~> 4.2.0'
