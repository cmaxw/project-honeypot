ProjectHoneypot.configure do |config|
  config.api_key = ENV['HONEYPOT_API_KEY']
  config.methods = ['POST', 'PUT', 'PATCH', 'DELETE'] # default
  config.environments = ['production'] # default
  config.no_tolerance = true # default

  ## - or -
  # config.no_tolerance = false
  # config.score_tolerance = 32  # greater than 32 threat score
  # config.last_activity_tolerance = 1000  # less than a 1000 days
  
  ## - additional configuration options
  # config.error_status_code = 422
  # config.error_headers = {'Cache-Control' => 'no-cache'}
  # config.error_message = ["WARNING: This IP Address has been flagged for suspicious behavior. Be advised."]
end