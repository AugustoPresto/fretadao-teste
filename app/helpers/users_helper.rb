module UsersHelper
  def users_list
    if @users.class == Array
      @users.collect do |user|
        tag.div(class: "d-flex justify-content-between") do
          concat tag.p("#{user.name}") +
          link_to("#{user.github_url}", user.github_url, target: "blank") +
          link_to("View user", user_path(user.id)) +
          link_to("Edit user", edit_user_path(user.id))
        end
      end.join.html_safe
    else
      tag.span("#{@users}", class: "d-flex justify-content-center")
    end
  end
end
