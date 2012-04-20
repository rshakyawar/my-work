class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.text :email
      t.string :stash_name
      t.string :stash_word
      t.date :b_day
      t.string :my_mail_goes_to
      t.string :zip
      t.integer :membership_code_id
      t.integer :temp_session_id

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
