require 'factory_girl'

Factory.define(:whatson_post, :class => WhatsonPost) do |f|
  f.sequence(:title) { |n| "Top #{n} Shopping Centers in Chicago" }
  f.body "These are the top ten shopping centers in Chicago. You're going to read a long whatson post about them. Come to peace with it."
  f.draft false
  f.tag_list "chicago, shopping, fun times"
  f.published_at Time.now
end
