class AddPrimaryKeyToCategorizations < ActiveRecord::Migration
  def self.up
    unless ::Categorization.column_names.include?("id")
      add_column :whatson_categories_whatson_posts, :id, :primary_key
    end
  end

  def self.down
    remove_column :whatson_categories_whatson_posts, :id
  end
end

