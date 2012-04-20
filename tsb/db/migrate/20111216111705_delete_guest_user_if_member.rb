class DeleteGuestUserIfMember < ActiveRecord::Migration
  def self.up
    Member.all.each do |member|
      member.update_guest_record
    end
  end

  def self.down
  end
end
