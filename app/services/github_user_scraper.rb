class GithubUserScraper

  class << self
    def scrape(name, url)
      github_url = url
      html_file = URI.open(github_url).read
      @html_doc = Nokogiri::HTML(html_file)

      nickname = @html_doc.search(".p-nickname").text.strip
      organization = @html_doc.search(".p-org").text.strip
      location = @html_doc.search(".p-label").text.strip
      followers = followers_and_following_to_i(@html_doc.search("span.text-bold.color-fg-default").first.text.strip)
      following = followers_and_following_to_i(@html_doc.search("span.text-bold.color-fg-default").last.text.strip)
      avatar_url = @html_doc.search(".avatar.avatar-user.width-full.border.color-bg-default").attr("src").value
      stars = @html_doc.search(".UnderlineNav-item.js-responsive-underlinenav-item:last-child").first
                                                                                               .text
                                                                                               .strip
                                                                                               .scan(/\d/)
                                                                                               .join("")
                                                                                               .to_i
      last_year_contributions = @html_doc.search(".f4.text-normal.mb-2").text
                                                                        .strip
                                                                        .scan(/\d/)
                                                                        .join("")
                                                                        .to_i

      user = User.new(
                      name: name,
                      github_url: github_url,
                      nickname: nickname,
                      organization: (organization if organization.present?),
                      location: (location if location.present?),
                      followers: followers,
                      following: following,
                      stars: stars,
                      last_year_contributions: last_year_contributions,
                      avatar_url: avatar_url
                    )
    end

    def followers_and_following_to_i(string)
      if string.end_with?("k")
        string.gsub('k', '00').delete('.').to_i
      else
        string.to_i
      end
    end
  end
 
end
