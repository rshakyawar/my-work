class AddIndexToGuestEmail < ActiveRecord::Migration
  def self.up
    add_index :guest_emails, :email
  end

  def self.down
    remove_index :guest_emails, :email
  end

end
