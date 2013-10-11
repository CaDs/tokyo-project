class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :account_id
      t.string :title
      t.text :body
      t.boolean :is_published
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
