class CreateMemberChoices < ActiveRecord::Migration
  def self.up
    create_table :member_choices do |t|
      t.string :email
      t.string :selected_option
      t.references :question

      t.timestamps
    end
  end

  def self.down
    drop_table :member_choices
  end
end
