module ProjectHoneypot
  class Url
    attr_reader :ip_address, :last_activity, :score, :offenses
    def initialize(ip_address, honeypot_response)
      @ip_address = ip_address
      @safe = honeypot_response.nil?
      process_score(honeypot_response)
    end

    def safe?
      @safe
    end

    def comment_spammer?
      @offenses.include?(:comment_spammer)
    end

    def harvester?
      @offenses.include?(:harvester)
    end

    def suspicious?
      @offenses.include?(:suspicious)
    end

    private

    def process_score(honeypot_response)
      if honeypot_response.nil?
        @last_activity = nil
        @score = 0
        @offenses = []
      else
        hp_array = honeypot_response.split(".")
        @last_activity = hp_array[1].to_i
        @score = hp_array[2].to_i
        @offenses = set_offenses(hp_array[3])
      end
    end

    def set_offenses(offense_code)
      offense_code = offense_code.to_i
      offenses = []
      offenses << :comment_spammer if offense_code/4 == 1
      offense_code = offense_code % 4
      offenses << :harvester if offense_code/2 == 1
      offense_code = offense_code % 2
      offenses << :suspicious if offense_code == 1
      offenses
    end
  end
end
