class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :vision_id
      t.integer :account_id
      t.string :flickr_id
      t.text :description_en
      t.text :description_es
      t.text :description_jp
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
