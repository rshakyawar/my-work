class CreateSchwagWinners < ActiveRecord::Migration
  def self.up
    create_table :schwag_winners do |t|
      t.references :versus
      t.references :member
      t.string :magic_number
      t.string :winner_code

      t.timestamps
    end
  end

  def self.down
    drop_table :schwag_winners
  end
end
