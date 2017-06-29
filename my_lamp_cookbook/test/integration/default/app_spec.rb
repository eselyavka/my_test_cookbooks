# # encoding: utf-8

# Inspec test for recipe my_lamp_cookbook::app

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/var/www/default/public_html/index.php') do
  it { should be_file }
end

describe file('/var/www/default/public_html/index.php') do
  it { should be_mode 0644 }
end
