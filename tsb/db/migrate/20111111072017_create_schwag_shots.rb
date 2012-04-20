class CreateSchwagShots < ActiveRecord::Migration
  def self.up
    create_table :schwag_shots do |t|
      t.references :versus
      t.references :member
      t.integer :shot_count
      t.boolean :ready_to_next_question
      t.string :fb_twit_token

      t.timestamps
    end
  end

  def self.down
    drop_table :schwag_shots
  end
end
