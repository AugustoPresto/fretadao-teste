module UsersHelper
  FORM_TITLES = {
    "users" => {
                "new" => { title: "Create your GitHub user",
                           btn_text: "Create user!" },
                "edit" => { title: "Edit user",
                            btn_text: "Update" }
               }
  }

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
      tag.div(class: "d-flex justify-content-between align-items-center border-bottom") do
        concat tag.p(user.name, class: "my-2") +
        link_to(user.bitlink.short_url, user.bitlink.short_url, target: "blank") +
        link_to("View user", user_path(user.id)) +
        link_to("Edit user", edit_user_path(user.id))
      end
    end.join.html_safe
  end

  def user_details
    image_tag(@user.avatar_url, width: "200px", height: "200px", class: "rounded-circle") +
    tag.p("Name: #{@user.name}", class: "mt-3") +
    tag.p("GitHub nickname: #{@user.nickname}") +
    gh_profile_link_div +
    tag.p("Followers: #{@user.followers}") +
    tag.p("Following: #{@user.following}") +
    tag.p("Stars: #{@user.stars}") +
    tag.p("Last year contributions: #{@user.last_year_contributions}") +
    display_organization +
    display_location
  end

  def gh_profile_link_div
    tag.div(class: "d-flex justify-content-center") do
      tag.p("GitHub profile: ", class: "px-1") +
      link_to(@user.bitlink.short_url, @user.bitlink.short_url, target: "blank")
    end
  end

  def display_organization
    @user.organization.present? ? tag.p("Organization: #{@user.organization}") : nil
  end

  def display_location
    @user.location.present? ? tag.p("Location: #{@user.location}") : nil
  end

  def create_or_edit_title
    tag.h3("#{FORM_TITLES.dig(controller_name, action_name, :title)}", class: "text-center")
  end

  def form_button_text(f)
    f.submit("#{FORM_TITLES.dig(controller_name, action_name, :btn_text)}", class: "btn btn-outline-success mt-2")
  end

  def user_page_btns
    link_to("Update GH info", update_gh_info_path(@user), class: "btn btn-outline-success") +
    link_to("Edit user", edit_user_path(@user), class: "btn btn-outline-secondary") +
    link_to("Delete user", user_path(@user), method: :delete, class: "btn btn-outline-danger", data: { confirm: 'Are you sure?' })
  end
end
