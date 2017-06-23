# frozen_string_literal: true

class CreateVisions < ActiveRecord::Migration
  def self.up
    create_table :visions do |t|
      t.references :area, foreign_key: { on_delete: :cascade }
      t.references :account, foreign_key: { on_delete: :cascade }
      t.string :title
      t.string :wiki_url
      t.string :meta_keywords
      t.string :meta_description
      t.string :url_title
      t.text :short_description
      t.text :body
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :visions
  end
end
