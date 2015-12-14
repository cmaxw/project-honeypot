module ProjectHoneypot
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        # Validate Request :: API_KEY present?, right environment, right method?
        if ProjectHoneypot.configuration.api_key.present? && ProjectHoneypot.configuration.environments.include?(ENV['RACK_ENV'])  && ProjectHoneypot.configuration.methods.include?(env['REQUEST_METHOD'])
          request = ProjectHoneypot.query({ip:  (env['HTTP_FASTLY_CLIENT_IP'] || env['REMOTE_ADDR']) })
          # IF no_tolerance, and request not safe?
          if ((!!(ProjectHoneypot.configuration.no_tolerance) && !(request.safe?)) ||
            # OR request score >= configuration score_tolerance
            (request.score.to_i >= ProjectHoneypot.configuration.score_tolerance.to_i) ||
            # OR request last_activity <= configuration score_tolerance
            (request.last_activity.to_i <= ProjectHoneypot.configuration.last_activity_tolerance.to_i))
            # THEN RETURN ERROR INSTEAD OF RESPONSE
            error(env)
          else
            respond(env)
          end
        else
          respond(env)
        end
      rescue
        respond(env)
      end
    end

    def error(env)
      [:error_status_code, :error_headers, :error_message].map{ |k| ProjectHoneypot.configuration.send(k) }
    end

    def respond(env)
      @status, @headers, @response = @app.call(env)
      [@status, @headers, self]
    end

    def each(&block)
      @response.each(&block)
    end
  end
end