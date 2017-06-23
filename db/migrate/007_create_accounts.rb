# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :crypted_password
      t.string :role
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :accounts
  end
end
