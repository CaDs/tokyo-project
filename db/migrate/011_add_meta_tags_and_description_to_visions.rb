class AddMetaTagsAndDescriptionToVisions < ActiveRecord::Migration
  def self.up
    add_column :visions, :meta_keywords, :string
    add_column :visions, :meta_description, :string
  end

  def self.down
    remove_column :visions, :meta_keywords
    remove_column :visions, :meta_description
  end
end
