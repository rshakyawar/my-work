class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id, :null => false
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :age
      t.string :gender
      t.string :occupation
      t.string :income
      t.string :size_waist
      t.string :size_inseam
      t.string :size_show
      t.string :size_shirt
      t.timestamps
    end

    add_index :profiles, :user_id, :unique => :true
  end

  def self.down
    drop_table :profiles
  end
end
