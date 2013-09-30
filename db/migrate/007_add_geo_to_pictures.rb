class AddGeoToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :longitude, :string
    add_column :pictures, :latitude, :string
  end

  def self.down
    remove_column :pictures, :longitude
    remove_column :pictures, :latitude
  end
end
