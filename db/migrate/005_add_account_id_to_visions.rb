class AddAccountIdToVisions < ActiveRecord::Migration
  def self.up
    add_column :visions, :account_id, :integer
  end

  def self.down
    remove_column :visions, :account_id
  end
end
