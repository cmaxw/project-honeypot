require "spec_helper"

describe ProjectHoneypot::Url do
  describe "with honeypot response" do
    before(:each) do 
      @url = ProjectHoneypot::Url.new("teachmetocode.com", "127.1.63.3") 
    end

    it "is safe" do
      @url.should_not be_safe
    end

    it "has the correct latest activity" do
      @url.last_activity.should == 1
    end

    it "has the correct score" do
      @url.score.should == 63
    end

    it "has the correct offenses" do
      @url.offenses.should include(:suspicious)
      @url.offenses.should include(:harvester)
      @url.offenses.should_not include(:comment_spammer)
      @url.should be_suspicious
      @url.should be_harvester
      @url.should_not be_comment_spammer
    end
  end

  describe "with nil honeypot response" do
    subject { @url = ProjectHoneypot::Url.new("teachmetocode.com", nil) }
    it { should be_safe }
  end
end
