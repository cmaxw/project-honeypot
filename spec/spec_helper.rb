require "rubygems"
require "bundler/setup"
require "rspec"
require 'rack/test'
require "flexmock"
require "project-honeypot"

RSpec.configure do |config|
  config.mock_with :flexmock
end