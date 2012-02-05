class Categorization < ActiveRecord::Base

  set_table_name 'whatson_categories_whatson_posts'
  belongs_to :whatson_post
  belongs_to :whatson_category

end