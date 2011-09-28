class AddCurrentuserFilenameToEmail < ActiveRecord::Migration
  def self.up
    add_column :emails, :currentuser_filename, :string
  end

  def self.down
    remove_column :emails, :currentuser_filename
  end
end
