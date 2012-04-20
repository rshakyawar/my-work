class CreateRewardLinks < ActiveRecord::Migration
  def self.up
    create_table :reward_links do |t|
      t.integer :versus_id, :null => false
      t.string :deal_image_file_name
      t.string :deal_image_content_type
      t.integer :deal_image_file_size
      t.datetime :deal_image_updated_at
      t.string :steal_image_file_name
      t.string :steal_image_content_type
      t.integer :steal_image_file_size
      t.datetime :steal_image_updated_at
      t.string :schwag_image_file_name
      t.string :schwag_image_content_type
      t.integer :schwag_image_file_size
      t.datetime :schwag_image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :reward_links
  end
end
