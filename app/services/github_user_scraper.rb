class GithubUserScraper

  class << self
    def scrape(user_params)
      github_url = user_params[:github_url]
      html_file = URI.open(github_url).read
      @html_doc = Nokogiri::HTML(html_file)
      User.new(set_input_hash(user_params[:name], github_url, @html_doc))
    end

    def update_gh_info_scrape(name, github_url)
      html_file = URI.open(github_url).read
      @html_doc = Nokogiri::HTML(html_file)
      set_input_hash(name, github_url, @html_doc)
    end

    def set_input_hash(name, github_url, html_doc)
      {
        name: name,
        github_url: github_url,
        nickname: html_doc.search('.p-nickname').text.strip,
        organization: html_doc.search('.p-org').text.strip,
        location: html_doc.search('.p-label').text.strip,
        followers: followers_and_following_to_i(html_doc.search('span.text-bold.color-fg-default').first.text.strip),
        following: followers_and_following_to_i(html_doc.search('span.text-bold.color-fg-default').last.text.strip),
        avatar_url: html_doc.search('.avatar.avatar-user.width-full.border.color-bg-default').attr('src').value,
        stars: html_doc.search('.UnderlineNav-item.js-responsive-underlinenav-item:last-child')
                       .first
                       .text
                       .strip
                       .scan(/\d/)
                       .join('')
                       .to_i,
        last_year_contributions: html_doc.search('.f4.text-normal.mb-2')
                                         .text
                                         .strip
                                         .scan(/\d/)
                                         .join('')
                                         .to_i
      }
    end

    def followers_and_following_to_i(string)
      if string.end_with?('k')
        string.gsub('k', '00').delete('.').to_i
      else
        string.to_i
      end
    end
  end
end
