class CreateMemberVotes < ActiveRecord::Migration
  def self.up
    create_table :member_votes do |t|
      t.integer :question_id
      t.string :selected_option
      t.integer :member_id

      t.timestamps
    end
  end

  def self.down
    drop_table :member_votes
  end
end
