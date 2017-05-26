name 'my_lamp_cookbook'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures my_lamp_cookbook'
long_description 'Installs/Configures my_lamp_cookbook'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/my_lamp_cookbook/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/my_lamp_cookbook'

depends 'timezone', '~> 0.0.1'
depends 'ntp', '~> 3.3.1'
depends 'httpd', '~> 0.4.5'
depends 'postgresql', '~> 6.1.1'
depends 'database', '~> 6.1.1'
