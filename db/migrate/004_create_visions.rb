class CreateVisions < ActiveRecord::Migration
  def self.up
    create_table :visions do |t|
      t.string :title
      t.string :picture_url
      t.text :short_description
      t.text :body
      t.integer :area_id
      t.timestamps
    end
  end

  def self.down
    drop_table :visions
  end
end
