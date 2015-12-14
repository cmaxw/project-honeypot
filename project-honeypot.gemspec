Gem::Specification.new do |s|
  s.name = %q{project-honeypot}
  s.version = "0.1.4"
  s.date = %q{2015-07-02}
  s.authors = ["Charles Max Wood"]
  s.email = %q{chuck@teachmetocode.com}
  s.summary = %q{Project-Honeypot provides a programatic interface to the Project Honeypot services.}
  s.homepage = %q{http://teachmetocode.com/}
  s.description = %q{Project-Honeypot provides a programatic interface to the Project Honeypot services. It can be used to identify spammers, bogus commenters, and harvesters. You will need a FREE api key from http://projecthoneypot.org}
  s.add_dependency('net-dns2')
  s.files = [ "README.rdoc", 
              "MIT-LICENSE", 
              "lib/project-honeypot.rb",
              "lib/project_honeypot/url.rb",
              "lib/project_honeypot/base.rb",
              "lib/project_honeypot/middleware.rb"]
end
