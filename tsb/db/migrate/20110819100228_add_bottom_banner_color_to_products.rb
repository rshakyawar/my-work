class AddBottomBannerColorToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :bottom_banner_color, :string
  end

  def self.down
    remove_column :products, :bottom_banner_color
  end
end
