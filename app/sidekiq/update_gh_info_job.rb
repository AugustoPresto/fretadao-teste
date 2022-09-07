class UpdateGhInfoJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    user.update!(GithubUserScraper.update_gh_info_scrape(user.name, user.github_url))
  end
end
