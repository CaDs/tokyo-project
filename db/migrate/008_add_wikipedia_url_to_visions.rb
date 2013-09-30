class AddWikipediaUrlToVisions < ActiveRecord::Migration
  def self.up
    add_column :visions, :wiki_url, :string
  end

  def self.down
    remove_column :visions, :wiki_url
  end
end
