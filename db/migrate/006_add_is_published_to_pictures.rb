class AddIsPublishedToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :is_published, :boolean
  end

  def self.down
    remove_column :pictures, :is_published
  end
end
