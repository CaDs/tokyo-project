class AddScheduleAtToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :schedule_at, :datetime
  end

  def self.down
    remove_column :pictures, :schedule_at
  end
end
