Given /^there is a category titled "([^"]*)"$/ do |title|
  @category = Factory.create(:whatson_category, :title => title)
end

Then /^the whatson post should have ([\d]*) categor[yies]{1,3}$/ do |num_category|
  WhatsonPost.last.categories.count.should == num_category.to_i
end

Then /^the whatson post should have the category "([^"]*)"$/ do |category|
  WhatsonPost.last.categories.first.title.should == category
end