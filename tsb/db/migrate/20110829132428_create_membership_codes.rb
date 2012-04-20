class CreateMembershipCodes < ActiveRecord::Migration
  def self.up
    create_table :membership_codes do |t|
      t.string :limit
      t.string :value
      t.datetime :activated_at
      t.integer :number_of_uses

      t.timestamps
    end
  end

  def self.down
    drop_table :membership_codes
  end
end
