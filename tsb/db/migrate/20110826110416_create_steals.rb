class CreateSteals < ActiveRecord::Migration
  def self.up
    create_table :steals do |t|
      t.integer :versus_id, :null => false
      t.string :steal_image_file_name
      t.string :steal_image_content_type
      t.integer :steal_image_file_size
      t.datetime :steal_image_updated_at
      t.string :reg_price
      t.string :sal_price
      t.string :description
      t.string :code
      t.string :e_commerce_link
      t.timestamps
    end
  end

  def self.down
    drop_table :steals
  end
end
