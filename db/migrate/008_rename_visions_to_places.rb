class RenameVisionsToPlaces < ActiveRecord::Migration
  def self.up
    rename_table :visions, :places
  end

  def self.down
    rename_table :places, :visions
  end
end
