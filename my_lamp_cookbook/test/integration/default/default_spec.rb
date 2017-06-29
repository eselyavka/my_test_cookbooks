# # encoding: utf-8

# Inspec test for recipe my_lamp_cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/chef/secret.key') do
  it { should be_file }
end

describe file('/etc/chef/secret.key') do
  it { should be_mode 0600 }
end
