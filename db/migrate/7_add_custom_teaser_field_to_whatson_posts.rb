class AddCustomTeaserFieldToWhatsonPosts < ActiveRecord::Migration
  def self.up
    add_column :whatson_posts, :custom_teaser, :text
  end

  def self.down
    remove_column :whatson_posts, :custom_teaser
  end
end

