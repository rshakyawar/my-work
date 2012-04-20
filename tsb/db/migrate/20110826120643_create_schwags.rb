class CreateSchwags < ActiveRecord::Migration
  def self.up
    create_table :schwags do |t|
      t.integer :versus_id, :null => false
      t.string :schwag_image_file_name
      t.string :schwag_image_content_type
      t.integer :schwag_image_file_size
      t.datetime :schwag_image_updated_at
      t.string :description
      t.integer :no_of_items
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :schwags
  end
end
