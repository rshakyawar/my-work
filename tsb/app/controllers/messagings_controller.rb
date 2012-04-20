# somple content of messagings_controller.rb
 require 'tropo-webapi-ruby'
 require 'uri'

class MessagingsController < ApplicationController

  def index
    msg = params[:session][:parameters][:msg]
    number_to_dial = params[:session][:parameters][:to]
    tropo = Tropo::Generator.new do
      message({:to => 'tel:+'+number_to_dial,:channel => 'TEXT',:network => 'SMS'}) do
        say     :value => "#{msg}"
      end
    end
    render :text => tropo.response
  end
  
  def send_message
    if versus_member_signed_in?
      mobile_msg = "theSTASHBOX.com"
      mobile_code = params[:country_code] || "1"
      mobile_no = mobile_code.to_s + params[:mobile_number]
      if params[:steal_code].blank?
        sms_share_text = URI.escape(return_sms_text)
      else
        sms_share_text = URI.escape(return_my_steal_email_text)
      end
      url = URI.parse("http://api.tropo.com/1.0/sessions?action=create&token=#{Settings.sms_tropo_token}&msg=#{sms_share_text}&to=#{mobile_no}")
      response = Net::HTTP.get_response(url)
      render :text=>response.body
    else
      render :text=>"Sorry! Member is logged in"
    end
  end
  
  def send_mail
    is_valid = is_valid_email?(params[:to_email])
  		user_mailer = UserMailer.send_mail_from_steal_deal_code(params[:to_email],return_my_steal_email_text).deliver! if !is_valid.nil?
  		if !user_mailer.blank? 
      render :json =>{:response=>true}.to_json, :status => :created
    else 
      render :json =>{:response=>false}.to_json, :status => :created
    end    
  end
  
  def send_multiple_mail
    invalid_email = false
    user_mailers = params[:to_email].split(",")
    user_mailers.each do |user_mailer|
     is_valid = is_valid_email?(user_mailer.strip)
   		mail_sended = UserMailer.send_mail_from_steal_deal(user_mailer,return_versus_twitter_text).deliver! if !is_valid.nil? 
   		 if is_valid.nil?
   		   invalid_email = false
   		   break
   		 else
   		   invalid_email = true
   		 end
    end
  		if !invalid_email.nil? and invalid_email
      render :json =>{:response=>true}.to_json, :status => :created
    else 
      render :json =>{:response=>false}.to_json, :status => :created
    end    
  end  
end

private

 def is_valid_email?(email)
  email_regex = %r{^[0-9a-z][0-9a-z._+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z]$}xi
  (email =~ email_regex)
 end 

  def return_versus_twitter_text
    versus = return_live_promo_versus
    email_txt = (versus.nil? or versus.popup_sending_text.nil? or versus.popup_sending_text.email_txt.nil?)? " " : versus.popup_sending_text.email_txt
    return email_txt
  end 
  
  def return_live_promo_versus
    Versus.live_promo_versus
  end
  
  def return_my_steal_email_text
    versus = return_live_promo_versus
    steal = Steal.find_by_versus_id(versus.id)
    return (steal.nil? or steal.code.nil?)? " " : steal.code
  end
  
  def return_sms_text
    versus = return_live_promo_versus
    steal = Steal.find_by_versus_id(versus.id)
    return (steal.nil? or steal.sms_text.nil?)? " " : steal.sms_text
  end  
