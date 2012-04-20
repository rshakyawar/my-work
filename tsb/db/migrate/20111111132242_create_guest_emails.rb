class CreateGuestEmails < ActiveRecord::Migration
  def self.up
    create_table :guest_emails do |t|
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :guest_emails
  end
end
