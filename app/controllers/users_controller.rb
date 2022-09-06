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
    github_url = params[:user][:github_url]
    html_file = URI.open(github_url).read
    html_doc = Nokogiri::HTML(html_file)

    nickname = html_doc.search(".p-nickname").text.strip
    organization = html_doc.search(".p-org").text.strip
    location = html_doc.search(".p-label").text.strip
    followers_and_following = html_doc.search("span.text-bold.color-fg-default").text.strip
    if followers_and_following.include?("k")
      array_of_numbers = followers_and_following.split("k")
    else
      array_of_numbers = followers_and_following.split("")
    end
    followers = array_of_numbers[0].to_i
    following = array_of_numbers[1].to_i
    stars = html_doc.search(".UnderlineNav-item.js-responsive-underlinenav-item:last-child").first.text.strip.scan(/\d/).join('').to_i
    last_year_contributions = html_doc.search(".f4.text-normal.mb-2").text.strip.scan(/\d/).join('').to_i
    avatar_url = html_doc.search(".avatar.avatar-user.width-full.border.color-bg-default").attr('src').value

    @user = User.new(
                      name: params[:user][:name],
                      github_url: params[:user][:github_url],
                      nickname: nickname,
                      organization: (organization if organization.present?),
                      location: (location if location.present?),
                      followers: followers,
                      following: following,
                      stars: stars,
                      last_year_contributions: last_year_contributions,
                      avatar_url: avatar_url
                    )

    if @user.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.update(users_params)
    redirect_to root_path
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

    # def users_params
    #   params.require(:user).permit(:name, :nickname, :github_url, :organization, :location)
    # end

    def set_user
      @user = User.find(params[:id])
    end
end
