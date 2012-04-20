require "icontact"

class Subscriber < ActiveRecord::Base
  after_create :send_welcome_email

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i

  private

  def send_welcome_email
    Icontact.add_contact_from_memberobj(self, true)
    UserMailer.beta_signup_response(self).deliver!
  end
end
