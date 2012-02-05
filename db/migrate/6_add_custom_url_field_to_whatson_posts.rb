class AddCustomUrlFieldToWhatsonPosts < ActiveRecord::Migration
  def self.up
    add_column :whatson_posts, :custom_url, :string
  end

  def self.down
    remove_column :whatson_posts, :custom_url
  end
end
