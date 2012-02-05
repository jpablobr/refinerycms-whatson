class AddUserIdToWhatsonPosts < ActiveRecord::Migration
  
  def self.up
    add_column :whatson_posts, :user_id, :integer
  end
  
  def self.down
    remove_column :whatson_posts, :user_id
  end
  
end