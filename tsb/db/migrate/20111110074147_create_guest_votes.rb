class CreateGuestVotes < ActiveRecord::Migration
  def self.up
    create_table :guest_votes do |t|
      t.integer :question_id
      t.string :selected_option

      t.timestamps
    end
  end

  def self.down
    drop_table :guest_votes
  end
end
