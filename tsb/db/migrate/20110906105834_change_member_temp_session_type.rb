class ChangeMemberTempSessionType < ActiveRecord::Migration
  def self.up
    remove_column :members, :temp_session_id
    add_column :members, :temp_session_id, :string
  end

  def self.down
  end
end
