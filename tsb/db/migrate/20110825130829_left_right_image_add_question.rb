class LeftRightImageAddQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :versus_left_file_name,    :string
    add_column :questions, :versus_left_content_type, :string
    add_column :questions, :versus_left_file_size,    :integer
    add_column :questions, :versus_left_updated_at,   :datetime

    add_column :questions, :versus_right_file_name,    :string
    add_column :questions, :versus_right_content_type, :string
    add_column :questions, :versus_right_file_size,    :integer
    add_column :questions, :versus_right_updated_at,   :datetime
  end

  def self.down
    remove_column :questions, :versus_left_file_name
    remove_column :questions, :versus_left_content_type
    remove_column :questions, :versus_left_file_size
    remove_column :questions, :versus_left_updated_at

    remove_column :questions, :versus_right_file_name
    remove_column :questions, :versus_right_content_type
    remove_column :questions, :versus_right_file_size
    remove_column :questions, :versus_right_updated_at
  end
end
