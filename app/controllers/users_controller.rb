class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    if params[:query].present?
      @users = User.search_all_fields(params[:query])
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to root_path
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

    def users_params
      params.require(:user).permit(:name, :nickname, :github_url, :organization, :location)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
