module ProjectHoneypot
  class InstallGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))
    def copy_initializer
      copy_file 'project_honeypot.rb', 'config/initializers/project_honeypot.rb'
    end
  end
end