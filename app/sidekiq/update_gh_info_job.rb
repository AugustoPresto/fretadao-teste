class UpdateGhInfoJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    pp user
  end
end
