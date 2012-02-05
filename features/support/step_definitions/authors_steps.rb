Then /^there should be (\d+) whatson posts?$/ do |num|
  WhatsonPost.all.size == num
end

Then /^the whatson post should belong to me$/ do
  WhatsonPost.first.author.login == User.last.login
end