class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy update_gh_info]

  def index
    return unless params[:query].present?

    @users = User.search_all_fields(params[:query])
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    # Checks if provided URL is valid, creates user by scraping GH URL
    # and generates shortened link
    @user = User.new
    if valid_github_url?(user_params[:github_url])
      @user = GithubUserScraper.scrape(user_params)
      Bitlink.create_bitlink(@user) if @user.present?
      redirect_to user_path(@user) if @user.save
    else
      flash[:alert] = 'Please provide a valid GitHub URL'
      redirect_to new_user_path
    end
  end

  def edit; end

  def update
    # if GH URL is changed, updates the whole user instance
    if @user.github_url != params[:user][:github_url]
      @user.update(user_params)
      @user.update_gh_info_job
    else
      @user.update(user_params)
    end
    redirect_to user_path(@user)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def update_gh_info
    @user.update_gh_info_job
    redirect_back(fallback_location: user_path(@user))
  end

  private

  def user_params
    params.require(:user).permit(:name, :github_url)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def valid_github_url?(url)
    url.match?(/\A((http|https):\/\/)?(www.)?github.com/)
  end
end
