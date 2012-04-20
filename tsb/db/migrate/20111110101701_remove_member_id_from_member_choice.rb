class RemoveMemberIdFromMemberChoice < ActiveRecord::Migration
  def self.up
    remove_column :member_choices, :member_id
  end

  def self.down
    add_column :member_choices, :member_id, :integer
  end
end
