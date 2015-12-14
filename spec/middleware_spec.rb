require "spec_helper"

describe ProjectHoneypot::Middleware do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      map '/' do
        use ProjectHoneypot::Middleware
        run Proc.new {|env| [200, {'Content-Type' => 'text/html'}, ['Hello World']] }
      end
    end.to_app
  end

  before(:all){
    ENV['RACK_ENV'] = 'production'
    @api_key = 'ABCD12345'
    @ip = '1.2.3.4'
    ProjectHoneypot.configure do |config|
      config.api_key = @api_key
    end
  }

  describe "good request" do
    before(:each){
      allow(Net::DNS::Resolver).to receive_message_chain(:start, :answer).and_return([nil])
    }
    
    it 'says Hello World' do
      allow(ProjectHoneypot::Base).to receive(:lookup).and_return([nil])
      post '/', {}, 'REMOTE_ADDR' => @ip
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Hello World')
    end
  end
  
  describe "bad request" do
    before(:each){
      allow(Net::DNS::Resolver).to receive_message_chain(:start, :answer).and_return(["somedomain.httpbl.org A Name 127.82.64.5"])
    }
    
    it 'says WARNING' do
      post '/', {}, 'REMOTE_ADDR' => @ip
      expect(last_response).to_not be_ok
      expect(last_response.body).to include('WARNING: This IP Address has been flagged for suspicious behavior. Be advised.')
    end
  end
end
