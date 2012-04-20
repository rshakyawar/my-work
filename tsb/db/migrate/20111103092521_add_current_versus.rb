class AddCurrentVersus < ActiveRecord::Migration
  def self.up
    add_column :versus, :live_versus, :boolean, :default => false
  end

  def self.down
    remove_column :versus, :live_versus
  end
end
