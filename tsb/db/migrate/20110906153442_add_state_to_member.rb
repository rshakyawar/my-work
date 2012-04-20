class AddStateToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :state, :string
  end

  def self.down
    remove_column :members, :state
  end
end
