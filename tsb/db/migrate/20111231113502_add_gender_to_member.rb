class AddGenderToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :gender, :string
  end

  def self.down
    remove_column :members, :gender
  end
end
