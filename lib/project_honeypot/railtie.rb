module ProjectHoneypot
  class Railtie < Rails::Railtie
    initializer "project_honeypot.configure_rails_initialization" do
      Rails.application.middleware.use ProjectHoneypot::Middleware
    end
    generators do
      require "generators/install_generator"
    end
  end
end
