require "spec_helper"

describe ProjectHoneypot::Base do
  describe "with honeypot response" do
    before(:each) do
      flexmock(Net::DNS::Resolver, :start => flexmock("answer", :answer => ["somedomain.httpbl.org A Name 127.1.63.5"]))
      @base = ProjectHoneypot::Base.new("abcdefghijklmnop")
    end

    it "returns a Url object" do
      url = @base.lookup("127.10.10.5")
      url.should be_a ProjectHoneypot::Url
      url.last_activity.should == 1
      url.score.should == 63
    end

    it "looks up non-ip addresses" do
      url = @base.lookup("iamspam.com")
      Net::DNS::Resolver.should_receive(:start).with("iamspam.com")
    end
  end
end
