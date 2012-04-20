class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer :versus_id, :null => false
      t.string :deal_image_file_name
      t.string :deal_image_content_type
      t.integer :deal_image_file_size
      t.datetime :deal_image_updated_at
      t.string :price
      t.string :description
      t.string :code
      t.string :e_commerce_link
      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
