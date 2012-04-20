require "icontact"
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:stash_name]

  # Setup accessible (or protected) attributes for your model
       attr_accessible  :member_survey_one_attributes, :member_survey_two_attributes, :member_survey_three_attributes, :accept_term_conditions, :first_name, :last_name, :stash_name, :stash_word, :b_day, :my_mail_goes_to, :zip ,:membership_code_id, :created_at, :updated_at,  :temp_session_id, :city ,:state, :email, :encrypted_password, :reset_password_token, :remember_token, :remember_created_at, :sign_in_count, :current_sign_in_at ,:last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :failed_attempts, :unlock_token, :locked_at, :password, :password_confirmation, :gender
 
  has_one :member_survey_one, :dependent=> :destroy
  has_one :member_survey_two, :dependent=> :destroy
  has_one :member_survey_three, :dependent=> :destroy
  has_many :schwag_shots, :dependent=> :destroy
  has_many :schwag_winners, :dependent=> :destroy
  has_many :invite_friends, :dependent=> :destroy
  belongs_to :membership_code

 accepts_nested_attributes_for :member_survey_one, :allow_destroy => :true
 accepts_nested_attributes_for :member_survey_two, :allow_destroy => :true
 accepts_nested_attributes_for :member_survey_three, :allow_destroy => :true
   
  after_save :save_icontact, :update_guest_record

  def send_thank_you_email
    UserMailer.member_thank_you(self).deliver!
  end

  def send_congrats_email
    UserMailer.member_congrats(self).deliver!
  end

  def activate_member
    self.active = (membership_code_id.blank? ? false : true )
    self.save
  end

  def active?
    return true if self.active
    return false
  end

  def save_icontact
    if self.active?
      Icontact.add_contact_from_tsb_member(self, true) rescue ""
    end
  end

  def update_guest_record
    return true if self.email.blank?
    delete_guest
  end

  def delete_guest
    Subscriber.where(:email=>self.email).each do |subscriber|
      subscriber.destroy
    end
    GuestEmail.where(:email=>self.email).each do |guest_email|
      guest_email.destroy
    end
  end
  
  def played_shots_and_next_shot versus
    schwag_shot = schwag_shots.where(:versus_id =>versus.id)
    if schwag_shot.blank?
      return 0, true
    else
      return schwag_shot[0].shot_count, schwag_shot[0].ready_to_next
    end
  end
  
  def schwag_looser? versus
    schwag_shot = schwag_shots.where(:versus_id =>versus.id)
    return false if schwag_shot.blank?
    return schwag_shot[0].shot_count > (Settings.schwag_shot.to_i - 1)
  end
  
end
