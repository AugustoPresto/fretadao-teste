require "rails_helper"

RSpec.describe GithubUserScraper do
  let!(:user1) { build(:user, name: "AugustoPresto", github_url: "http://www.github.com/AugustoPresto") }

  before(:each) do
    @scraped_user = GithubUserScraper.scrape(user1.name, user1.github_url)
  end

  describe ".scrape" do
    it "Scrapes given GitHub URL and returns a User instance" do
      expect(@scraped_user).to be_a(User) 
      expect(@scraped_user.stars).to eq(3) 
    end
    
    it "Doesn't save User instance" do
      expect(User.all.count).to eq(0)
    end
  end
end
