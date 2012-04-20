class AppTsbMemberIntoIcontact < ActiveRecord::Migration
  def self.up
    members = Member.find(:all)
    members.each do |member|
     if member.active?
       Icontact.add_contact_from_tsb_member(member, true)
     end
    end
  end

  def self.down
  end
end
