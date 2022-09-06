FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    github_url { Faker::Internet.url }
  end
end
