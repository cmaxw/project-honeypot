require "spec_helper"

describe ProjectHoneypot::Base do
  describe "with honeypot response" do
    before(:each) do
      allow(Net::DNS::Resolver).to receive_message_chain(:start, :answer).and_return(["somedomain.httpbl.org A Name 127.1.63.5"])
      @base = ProjectHoneypot::Base.new("abcdefghijklmnop")
    end

    it "returns a Url object" do
      expect(Net::DNS::Resolver).to receive(:start).once
      url = @base.lookup("127.10.10.5")
      expect(url).to be_a ProjectHoneypot::Url
      expect(url.last_activity).to eq(1)
      expect(url.score).to eq(63)
    end

    it "looks up non-ip addresses" do
      expect(Net::DNS::Resolver).to receive(:start).twice
      url = @base.lookup("iamspam.com")
    end
  end
end
