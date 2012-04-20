require "icontact"
class GuestEmail < ActiveRecord::Base
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
  after_create :post_icontact
  
  def post_icontact
    begin
     Icontact.add_guest_user(self, true)
    rescue
    end
  end
  
end
