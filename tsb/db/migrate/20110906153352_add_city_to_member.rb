class AddCityToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :city, :string
  end

  def self.down
    remove_column :members, :city
  end
end
