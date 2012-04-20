class AddImagesForProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :logo_two_file_name,    :string
    add_column :products, :logo_two_content_type, :string
    add_column :products, :logo_two_file_size,    :integer
    add_column :products, :logo_two_updated_at,   :datetime

    add_column :products, :top_banner_file_name,    :string
    add_column :products, :top_banner_content_type, :string
    add_column :products, :top_banner_file_size,    :integer
    add_column :products, :top_banner_updated_at,   :datetime

    add_column :products, :bottom_banner_file_name,    :string
    add_column :products, :bottom_banner_content_type, :string
    add_column :products, :bottom_banner_file_size,    :integer
    add_column :products, :bottom_banner_updated_at,   :datetime
  end

  def self.down
    remove_column :products, :logo_two_file_name
    remove_column :products, :logo_two_content_type
    remove_column :products, :logo_two_file_size
    remove_column :products, :logo_two_updated_at

    remove_column :products, :top_banner_file_name
    remove_column :products, :top_banner_content_type
    remove_column :products, :top_banner_file_size
    remove_column :products, :top_banner_updated_at

    remove_column :products, :bottom_banner_file_name
    remove_column :products, :bottom_banner_content_type
    remove_column :products, :bottom_banner_file_size
    remove_column :products, :bottom_banner_updated_at
  end
end
