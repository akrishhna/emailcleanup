class CreateEmailstatuses < ActiveRecord::Migration
  def self.up
    create_table :emailstatuses do |t|
      t.string :emailid
      t.string :status, :default => "Not verfied"
      t.references :email

      t.timestamps
    end
  end

  def self.down
    drop_table :emailstatuses
  end
end
