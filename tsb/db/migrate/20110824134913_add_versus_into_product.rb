class AddVersusIntoProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :versus_id, :integer
  end

  def self.down
    remove_column :products, :versus_id
  end
end
