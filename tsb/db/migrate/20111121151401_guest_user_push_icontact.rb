class GuestUserPushIcontact < ActiveRecord::Migration
  def self.up
    guest_emails = GuestEmail.find(:all)
    guest_emails.each do |guest_email|
      Icontact.add_guest_user(guest_email, true)
    end
    old_guests = MemberChoice.find(:all)
    old_guests.each do |old_guest|
      Icontact.add_guest_user(old_guest, true)
    end
  end

  def self.down
  end
end
