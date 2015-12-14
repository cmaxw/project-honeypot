require "spec_helper"

describe ProjectHoneypot::Url do
  describe "with honeypot response" do
    before(:each) do 
      @url = ProjectHoneypot::Url.new("teachmetocode.com", "127.1.63.3") 
    end

    it "is safe" do
      expect(@url).to_not be_safe
    end

    it "has the correct latest activity" do
      expect(@url.last_activity).to eq(1)
    end

    it "has the correct score" do
      expect(@url.score).to eq(63)
    end

    it "has the correct offenses" do
      expect(@url.offenses).to include(:suspicious)
      expect(@url.offenses).to include(:harvester)
      expect(@url.offenses).to_not include(:comment_spammer)
      expect(@url).to be_suspicious
      expect(@url).to be_harvester
      expect(@url).to_not be_comment_spammer
    end
  end

  describe "with nil honeypot response" do
    subject { @url = ProjectHoneypot::Url.new("teachmetocode.com", nil) }
    it { should be_safe }
  end
end
