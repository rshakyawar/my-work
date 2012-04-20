class PushMemberIntoIcontact < ActiveRecord::Migration
  def self.up
    subscribers = Subscriber.find(:all)
    subscribers.each do |subscriber|
      Icontact.add_contact_from_memberobj(subscriber, true)
    end
  end

  def self.down
  end
end
