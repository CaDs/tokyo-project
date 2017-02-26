class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.references :ward, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :url_title
      t.string :description
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :areas
  end
end
