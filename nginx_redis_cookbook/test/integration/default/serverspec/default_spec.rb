require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/tmp/hello.txt') do
      it { should be_file }
      its(:content) { should match /Chef/ }
end

describe package('nginx') do
      it { should be_installed }
end

describe service('nginx') do
      it { should be_enabled }
      it { should be_running }
end

describe user('redis') do
      it { should exist }
end
