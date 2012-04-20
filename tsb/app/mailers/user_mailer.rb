class UserMailer < ActionMailer::Base
  default :from => "tsbteam@thestashbox.com"


  def beta_signup_response(user)
    @user = user
    mail(:to => user.email,
         :subject => "Thanks for your interest in TheStashbox!") do |format|
      format.html { render 'beta_signup_response.html.haml' }
    end
  end

  def member_congrats(user)
    @user = user
    mail(:to => user.email,
         :subject => "Congrats on becoming a TSB member!") do |format|
      format.html { render 'member_congrats.html.haml' }
    end
  end

  def member_thank_you(user)
    @user = user
    mail(:to => user.email,
         :subject => "Thank You For Applying To The STASHBOX") do |format|
      format.html { render 'member_thank_you.html.haml' }
    end
  end
 
  def send_mail_for_forgot_user_name(brand_partner_obj)
    mail(:to => brand_partner_obj.email,
        :from => "tsbteam@thestashbox.com",
        :subject =>"forgot Username",
        :username => brand_partner_obj.partner_name,
        :email_message => "I am forgot my username please send my username")
  end 

  def send_mail_inviting_friend(member_email, friend_email, membership_code)
    mail(:to => friend_email,
        :from => member_email,
        :subject =>"thestashbox Invitation",
        :email_message => "Invitation",
        :my_membership_code=> membership_code)
  end 
  
  def send_mail_guest_user(member_email, friend_email, membership_code)
    mail(:to => friend_email,
        :from => member_email,
        :subject =>"thestashbox Invitation",
        :email_message => "Invitation",
        :my_membership_code=> membership_code)
  end 

  def send_mail_for_forgot_stashname(member_email)
    mail(:to => member_email.email,
        :from => "tsbteam@thestashbox.com",
        :subject =>"forgot stashname",
        :stash_name => member_email.stash_name)
  end 
  
  def send_mail_from_steal_deal_code(recipent,email_body)
    mail(:to => recipent,
        :from => "tsbteam@thestashbox.com",
        :subject =>"My Steal Code",
        :body => email_body)
  end   
  
  def send_mail_from_steal_deal(recipent,email_body)
    mail(:to => recipent,
        :from => "tsbteam@thestashbox.com",
        :subject =>"The Steal",
        :email_body => email_body) do |format|
          format.html        
        end
  end 
end
