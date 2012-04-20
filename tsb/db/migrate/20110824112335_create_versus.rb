class CreateVersus < ActiveRecord::Migration
  def self.up
    create_table :versus do |t|
      t.integer :brand_partner_id, :null => false
      t.string :contact_name
      t.string :contact_email
      t.string :detail
      t.integer :no_of_questions
      t.timestamps
    end
  end

  def self.down
    drop_table :versus
  end
end
