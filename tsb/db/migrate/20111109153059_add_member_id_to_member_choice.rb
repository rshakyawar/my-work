class AddMemberIdToMemberChoice < ActiveRecord::Migration
  def self.up
    add_column :member_choices, :member_id, :integer
  end

  def self.down
    remove_column :member_choices, :member_id
  end
end
