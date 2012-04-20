class AddMemberCountToVersusQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :member_count, :integer  
  end

  def self.down
    remove_column :questions, :member_count
  end
end
