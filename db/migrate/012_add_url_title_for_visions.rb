class AddUrlTitleForVisions < ActiveRecord::Migration
  def self.up
    add_column :visions, :url_title, :string
  end

  def self.down
    remove_column :visions, :url_title
  end
end
