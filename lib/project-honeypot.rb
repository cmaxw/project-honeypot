require 'net/dns'
require File.dirname(__FILE__) + "/project_honeypot/url.rb"
require File.dirname(__FILE__) + "/project_honeypot/base.rb"

module ProjectHoneypot
  def self.lookup(api_key, url)
    searcher = Base.new(api_key)
    searcher.lookup(url)
  end
end
