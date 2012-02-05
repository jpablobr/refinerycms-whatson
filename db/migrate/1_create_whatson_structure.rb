class CreateWhatsonStructure < ActiveRecord::Migration

  def self.up
    create_table :whatson_posts, :id => true do |t|
      t.string :title
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.timestamps
    end

    add_index :whatson_posts, :id

    create_table :whatson_comments, :id => true do |t|
      t.integer :whatson_post_id
      t.boolean :spam
      t.string :name
      t.string :email
      t.text :body
      t.string :state
      t.timestamps
    end

    add_index :whatson_comments, :id

    create_table :whatson_categories, :id => true do |t|
      t.string :title
      t.timestamps
    end

    add_index :whatson_categories, :id

    create_table :whatson_categories_whatson_posts, :id => false do |t|
      t.integer :whatson_category_id
      t.integer :whatson_post_id
    end

    add_index :whatson_categories_whatson_posts, [:whatson_category_id, :whatson_post_id], :name => 'index_whatson_categories_whatson_posts_on_bc_and_bp'

    load(Rails.root.join('db', 'seeds', 'refinerycms_whatson.rb').to_s)
  end

  def self.down
    UserPlugin.destroy_all({:name => "refinerycms_whatson"})

    Page.delete_all({:link_url => "/whatson"})

    drop_table :whatson_posts
    drop_table :whatson_comments
    drop_table :whatson_categories
    drop_table :whatson_categories_whatson_posts
  end

end
