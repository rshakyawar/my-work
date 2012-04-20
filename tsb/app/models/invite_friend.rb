class InviteFriend < ActiveRecord::Base
  FRIENDS_SIZE = 5
  belongs_to :member
  validates_format_of :email, :with => /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,}$/i
  validates_presence_of :email
  after_create :email_invite_friend

  def email_invite_friend
    unique_membership_code = ActiveSupport::SecureRandom.hex(4)
    if unique_membership_code
      generated_membership_code = MembershipCode.create(:value=>unique_membership_code,:number_of_uses=>1)
      UserMailer.send_mail_inviting_friend(member.email, email, generated_membership_code.value).deliver!
    end
  end

end
