xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title RefinerySetting.find_or_set(:site_name, "Company Name")
    xml.description RefinerySetting.find_or_set(:site_name, "Company Name") + " Whatson Posts"
    xml.link whatson_root_url

    @whatson_posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link whatson_post_url(post)
      end
    end
  end
end