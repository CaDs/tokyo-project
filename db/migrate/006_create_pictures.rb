# frozen_string_literal: true

class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.references :vision, foreign_key: { on_delete: :cascade }
      t.references :account, foreign_key: { on_delete: :cascade }
      t.string :flickr_id
      t.string :longitude
      t.string :latitude
      t.text :description_en
      t.text :description_es
      t.text :description_jp
      t.boolean :is_published
      t.datetime :schedule_at
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :pictures
  end
end
