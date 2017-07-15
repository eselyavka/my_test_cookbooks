name 'openvpn'
maintainer 'Evgenii Seliavka'
maintainer_email 'evg.selyavka at gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures openvpn'
long_description 'Installs/Configures openvpn'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'timezone', '~> 0.0.1'
depends 'ntp', '~> 3.3.1'
depends 'sysctl', '~> 0.8.1'
depends 'iptables', '~> 4.2.0'
