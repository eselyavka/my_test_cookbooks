# # encoding: utf-8

# Inspec test for recipe lapp_cookbook::php

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'php5' do
  it { should be_installed }
end

describe package 'php5-pgsql' do
  it { should be_installed }
end

describe package 'libapache2-mod-php5' do
  it { should be_installed }
end

describe command "php5 -r 'echo 1;'" do
  its(:stdout) { should eq '1' }
end
