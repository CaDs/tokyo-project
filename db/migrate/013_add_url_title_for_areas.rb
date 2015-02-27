class AddUrlTitleForAreas < ActiveRecord::Migration
  def self.up
    add_column :areas, :url_title, :string
  end

  def self.down
    remove_column :areas, :url_title
  end
end
