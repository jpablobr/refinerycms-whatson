Given /^there is a whatson post titled "([^"]*)" and tagged "([^"]*)"$/ do |title, tag_name|
  @whatson_post = Factory.create(:whatson_post, :title => title, :tag_list => tag_name)
end

When /^I visit the tagged posts page for "([^"]*)"$/ do |tag_name|
  @whatson_post ||= Factory.create(:whatson_post, :tag_list => tag_name)
  tag = WhatsonPost.tag_counts_on(:tags).first
  visit tagged_posts_path(tag.id, tag_name.parameterize)
end

Then /^the whatson post should have the tags "([^"]*)"$/ do |tag_list|
  WhatsonPost.last.tag_list == tag_list.split(', ')
end
