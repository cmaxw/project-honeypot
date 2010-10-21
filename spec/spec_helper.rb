require "rubygems"
require "bundler/setup"
require "rspec"
require "flexmock"
require File.dirname(__FILE__) + "/../lib/project_honeypot"

RSpec.configure do |config|
  config.mock_with :flexmock
end
