require 'factory_girl'

Factory.define(:whatson_category) do |f|
  f.sequence(:title) { |n| "Shopping #{n}" }
end
