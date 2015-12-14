require 'net/dns'
require File.dirname(__FILE__) + "/project_honeypot/url.rb"
require File.dirname(__FILE__) + "/project_honeypot/base.rb"
require File.dirname(__FILE__) + "/project_honeypot/configuration.rb"
require File.dirname(__FILE__) + "/project_honeypot/railtie.rb"
require File.dirname(__FILE__) + "/project_honeypot/middleware.rb"

module ProjectHoneypot

  def self.lookup(api_key, url)
    searcher = Base.new(api_key)
    searcher.lookup(url)
  end

  def self.query(opts={})
    fail ArgumentError, 'You must specify an IP Address.' unless opts[:ip].present?
    Base.new(opts[:api_key] || nil).lookup(opts[:ip])
  end
end
