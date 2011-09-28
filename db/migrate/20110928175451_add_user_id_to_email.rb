class AddUserIdToEmail < ActiveRecord::Migration
  def self.up
    add_column :emails, :user_id, :integer
  end

  def self.down
    remove_column :emails, :user_id
  end
end
