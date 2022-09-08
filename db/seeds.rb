# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def add_user(user_info)
  name = user_info[:name]
  nickname = user_info[:nickname]
  github_url = user_info[:github_url]
  followers = user_info[:followers]
  following = user_info[:following]
  stars = user_info[:stars]
  last_year_contributions = user_info[:last_year_contributions]
  avatar_url = user_info[:avatar_url]
  organization = user_info[:organization]
  location = user_info[:location]
end

users = [
  {
    name: "Falando de Viagem",
    github_url: "https://github.com/falandodeviagem",
    nickname: "Super",
    organization: "Falando de Viagem",
    location: "Rio de Janeiro",
    followers: 6,
    following: 7,
    avatar_url: "https://avatars.githubusercontent.com/u/5899820?v=4",
    stars: 100,
    last_year_contributions: 0
  },
  {
    name: "Marcus Gonçalves",
    github_url: "https://github.com/marcusGoncalvess",
    nickname: "marcusGoncalvess",
    organization: "Full-Stack Developer at Opdv",
    location: "Brazil, RS, Porto Alegre",
    followers: 66,
    following: 19,
    avatar_url: "https://avatars.githubusercontent.com/u/57052394?v=4",
    stars: 28,
    last_year_contributions: 3
  },
  {
    name: "Daniela Espírito Santo",
    github_url: "https://github.com/aliensixteen-dev",
    nickname: "aliensixteen",
    organization: "Alien Code",
    location: "Luanda, Angola",
    followers: 11,
    following: 26,
    avatar_url: "https://avatars.githubusercontent.com/u/34215388?v=4",
    stars: 4,
    last_year_contributions: 2
  },
]

users.each do |user|
  puts "Creating user..."
  User.create(user)
end

User.all.each do |user|
  puts "Creating bitlink..."
  Bitlink.create_bitlink(user)
end
