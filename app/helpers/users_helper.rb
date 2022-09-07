module UsersHelper
  def users_list
    if @users.class == String
      tag.span(@users, class: "d-flex justify-content-center")
    elsif @users.blank?
      tag.span
    else
      render_users_list
    end
  end

  def render_users_list
    @users.collect do |user|
      tag.div(class: "d-flex justify-content-between") do
        concat tag.p("#{user.name}") +
        link_to("#{user.bitlink.short_url}", user.bitlink.short_url, target: "blank") +
        link_to("View user", user_path(user.id)) +
        link_to("Edit user", edit_user_path(user.id))
      end
    end.join.html_safe
  end

  def user_details
    image_tag(@user.avatar_url, width: "200px", height: "200px", class: "rounded-circle") +
    tag.p("Name: #{@user.name}", class: "mt-3") +
    tag.p("GitHub nickname: #{@user.nickname}") +
    tag.p(link_to("Visit GitHub profile", @user.bitlink.short_url, target: "blank")) +
    tag.p("Seguidores: #{@user.followers}") +
    tag.p("Seguindo: #{@user.following}") +
    tag.p("Estrelas: #{@user.stars}")
  end
end
