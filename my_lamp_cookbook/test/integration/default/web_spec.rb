# # encoding: utf-8

# Inspec test for recipe my_lamp_cookbook::web

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'apache2' do
  it { should be_installed }
end

describe service 'apache2-default' do
  it { should be_enabled }
  it { should be_running }
end

describe command "curl -o/dev/null -s -L -m 120 -X GET -w '%{http_code}' http://localhost" do
  its(:stdout) { should eq '200' }
end

describe port 80 do
  it { should be_listening }
end
