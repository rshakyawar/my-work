class AddIndexToInviteFriend < ActiveRecord::Migration
  def self.up
    add_index :invite_friends, :email
  end

  def self.down
    remove_index :invite_friends, :email
  end

end
