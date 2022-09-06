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
end

def render_users_list
  @users.collect do |user|
    tag.div(class: "d-flex justify-content-between") do
      concat tag.p("#{user.name}") +
      link_to("#{user.github_url}", user.github_url, target: "blank") +
      link_to("View user", user_path(user.id)) +
      link_to("Edit user", edit_user_path(user.id))
    end
  end.join.html_safe
end
