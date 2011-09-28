class AddMailToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :mail, :string
  end

  def self.down
    remove_column :emails, :mail
  end
end
