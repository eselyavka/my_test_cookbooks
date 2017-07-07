# # encoding: utf-8

# Inspec test for recipe lapp_cookbook::db

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'postgresql-9.5' do
  it { should be_installed }
end

describe service 'postgresql' do
  it { should be_enabled }
  it { should be_running }
end

describe command "sudo -u postgres psql -Upostgres -qAt -c 'SELECT 1' template1" do
  its(:stdout) { should match /1/ }
end

describe port 5432 do
  it { should be_listening }
end
