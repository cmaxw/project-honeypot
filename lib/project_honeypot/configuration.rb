module ProjectHoneypot

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key
    attr_accessor :methods, :environments, :offenses, :no_tolerance, :score_tolerance, :last_activity_tolerance
    attr_accessor :error_status_code, :error_headers, :error_message

    def initialize
      @api_key = nil
      @methods = ['POST', 'PUT', 'PATCH', 'DELETE']
      @environments = ['production']
      @offenses = ['comment_spammer', 'harvester', 'suspicious']
      @no_tolerance = true
      @score_tolerance = 1
      @last_activity_tolerance = 1
      @error_status_code = 422
      @error_headers = {'Cache-Control' => 'no-cache'}
      @error_message = ["WARNING: This IP Address has been flagged for suspicious behavior. Be advised."]
    end
  end
end