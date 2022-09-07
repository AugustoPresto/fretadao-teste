require 'rails_helper'

RSpec.describe Bitlink, type: :model do
  let!(:user) { create(:user, name: "AugustoPresto", github_url: "http://www.github.com/AugustoPresto") }

  describe ".create_bitlink" do
    it "Creates a Bitlink instance" do
      bitlink = described_class.create_bitlink(user)
      expect(bitlink).to be_a(Bitlink)
      expect(bitlink.short_url).not_to be_empty
    end
  end

  describe ".generate_short_url" do
    it "Creates a shortened URL" do
      short_link = described_class.generate_short_url(user.github_url)
      expect(short_link).to include("bit.ly") 
    end
  end
end
