class UsersController < ApplicationController
  def index
    if params[:query].present?
      @users = User.search_all_fields(params[:query])
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def users_params
      params.require(:user).permit(:name, :nickname, :github_url, :organization, :location)
    end
end
