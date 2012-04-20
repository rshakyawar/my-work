class CreateInviteFriends < ActiveRecord::Migration
  def self.up
    create_table :invite_friends do |t|
      t.references :member
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :invite_friends
  end
end
