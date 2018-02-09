#
# Cookbook:: tomcat
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

# This is an example test, replace it with your own test.
describe port(80)  do
  it { should_not be_listening }
end

describe port(8080)  do
  it { should be_listening }
end

describe command ('curl localhost:8080') do
  its(:stdout) {should match(/Hello, World/)} 
end