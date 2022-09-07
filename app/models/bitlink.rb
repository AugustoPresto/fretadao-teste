class Bitlink < ApplicationRecord
  belongs_to :user

  class << self
    def create(user)
      Bitlink.create(
                      short_url: generate_short_url(user.github_url),
                      long_url: user.github_url,
                      user: user
                    )
    end

    def generate_short_url(github_url)
      client = Bitly::API::Client.new(token: ENV["BITLY_TOKEN"])
      bitlink = client.shorten(long_url: github_url)
      bitlink.link
    end
  end
end
