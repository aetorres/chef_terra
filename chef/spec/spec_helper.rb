# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'
require 'net/ssh'


options = Net::SSH::Config.for(host)
options[:user] = 'ec2-user'
set :ssh_options, options

host = '54.201.181.111'
set :host,        options[:host_name] || host