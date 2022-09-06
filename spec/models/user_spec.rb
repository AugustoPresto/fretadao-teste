require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  let!(:user1) { create(:user, name: "AugustoPresto", github_url: "http://www.github.com/AugustoPresto") }
  let!(:user2) { create(:user, name: "Augusto", github_url: "http://www.github.com/Presto") }
  let!(:user3) { create(:user, name: "Roberto Alvarez", github_url: "http://www.github.com/robertoalvarez") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe ".search_all_fields" do
    it "Returns all results with given query" do
      users = User.search_all_fields("Augusto")
      expect(users.size).to eq(2) 
      expect(users).to all(be_a(User))
    end

    it "Returns 'No matches found' when no user is found" do
      users = User.search_all_fields("matz")
      expect(users).to eq("No matches found")
    end
  end
end
