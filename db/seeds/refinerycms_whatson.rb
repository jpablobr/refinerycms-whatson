::User.find(:all).each do |user|
  if user.plugins.where(:name => 'refinerycms_whatson').blank?
    user.plugins.create(:name => "refinerycms_whatson",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(::User)

if defined?(::Page)
  page = ::Page.create(
    :title => "Whatson",
    :link_url => "/whatson",
    :deletable => false,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => "^/whatsons?(\/|\/.+?|)$"
  )

  ::Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end