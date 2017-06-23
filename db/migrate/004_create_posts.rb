# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.references :account, foreign_key: { on_delete: :cascade }
      t.string :title
      t.text :body
      t.boolean :is_published
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :posts
  end
end
