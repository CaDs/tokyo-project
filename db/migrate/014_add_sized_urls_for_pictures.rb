# frozen_string_literal: true

class AddSizedUrlsForPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :thumb_size_url, :string
    add_column :pictures, :medium_size_url, :string
    add_column :pictures, :large_size_url, :string
  end

  def self.down
    remove_column :pictures, :thumb_size_url, :string
    remove_column :pictures, :medium_size_url, :string
    remove_column :pictures, :large_size_url, :string
  end
end
