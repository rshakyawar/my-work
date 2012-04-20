class AddIndexToMember < ActiveRecord::Migration
  def self.up
    add_index :members, :email
  end

  def self.down
    remove_index :members, :email
  end

end
