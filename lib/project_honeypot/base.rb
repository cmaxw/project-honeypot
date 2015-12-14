module ProjectHoneypot 
  class Base
    def initialize(api_key = nil)
      @api_key = api_key || ProjectHoneypot.configuration.api_key
      fail ArgumentError, 'You must specify an api_key.' if @api_key.nil?
    end

    def lookup(ip_address)
      ip_address = url_to_ip(ip_address)
      reversed_ip = ip_address.split(".").reverse.join(".")
      honeypot_score = extract_ip_address(Net::DNS::Resolver.start("#{@api_key}.#{reversed_ip}.dnsbl.httpbl.org"))
      Url.new(ip_address, honeypot_score)
    end

    private 

    def url_to_ip(url)
      return url if url.match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
      extract_ip_address(Net::DNS::Resolver.start(url))
    end

    def extract_ip_address(dns_response)
      dns_response.answer.first.to_s.split.last
    end
  end
end
