class CreateLuckyWinners < ActiveRecord::Migration
  def self.up
    create_table :lucky_winners do |t|
      t.datetime :winning_time
      t.string :ip_address
      t.string :code
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lucky_winners
  end
end
