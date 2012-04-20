class BrandPartners::RewardController < ApplicationController
  layout "rewards_upload_layout"
  before_filter :authenticate_brand_partner!
  before_filter :current_versus
  uses_tiny_mce
  require 'tropo-webapi-ruby'
  require 'uri'
       
  def show_reward_link
    @reward_link = @versus.reward_link || @versus.build_reward_link
  end
  
  def show_thank_you_popup
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
  end

  def create_thank_you_popup
    @shwag_winner_looser_popup = @versus.build_shwag_winner_looser_popup(params[:shwag_winner_looser_popup])  
    if @shwag_winner_looser_popup.save
      redirect_to :action => :show_thank_you_popup , :versus_id=>@versus.id
    else
      render :action => :show_thank_you_popup
    end
  end

  def update_thank_you_popup
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup  
    if @shwag_winner_looser_popup.save_update_attributes(params) 
      redirect_to :action => :show_thank_you_popup , :versus_id=>@versus.id
    else
      render :action => :show_thank_you_popup
    end
  end

  def show_popup_sending_text
   @popup_sending_text = @versus.popup_sending_text|| @versus.build_popup_sending_text  
  end  
  
  def create_popup_sending_text
    @popup_sending_text = @versus.build_popup_sending_text(params[:popup_sending_text])  
    if @popup_sending_text.save
      redirect_to :action => :show_popup_sending_text , :versus_id=>@versus.id
    else
      render :action => :show_popup_sending_text
    end  
  end  

  def update_popup_sending_text
    @popup_sending_text = @versus.popup_sending_text.update_attributes(params[:popup_sending_text])  
    unless @popup_sending_text.blank?
      redirect_to :action => :show_popup_sending_text , :versus_id=>@versus.id
    else
      render :action => :show_popup_sending_text
    end    
  end  
      
  def create_reward_link
    @reward_link = @versus.build_reward_link(params[:reward_link])
    if @reward_link.save
      redirect_to :action => :show_reward_link , :versus_id=>@versus.id
    else
      render :action => :show_reward_link
    end
  end

  def update_reward_link
    @reward_link = @versus.reward_link   
    @reward_link.steal_bracket_text = params[:bracket_text] if params[:current_link]=="steal_image"
    @reward_link.schwag_bracket_text = params[:bracket_text] if params[:current_link]=="schwag_image"
    if @reward_link.save_update_attributes(params)
      redirect_to :action => :show_reward_link , :versus_id=>@versus.id
    else
      render :action => :show_reward_link
    end
  end

  def show_deal
    @deal = @versus.deal || @versus.build_deal
  end

  def create_deal
    @deal = @versus.build_deal(params[:deal])
    if @deal.save
      redirect_to :action => :show_deal , :versus_id=>@versus.id
    else
      render :action => :show_deal
    end
  end

  def update_deal
    @deal = @versus.deal
    if @deal.save_update_attributes(params)
      redirect_to :action => :show_deal , :versus_id=>@versus.id
    else
      render :action => :show_deal
    end
  end

  def show_steal
    @steal = @versus.steal || @versus.build_steal
    @popup_sending_text = @versus.popup_sending_text
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
  end

  def create_steal
    @steal = @versus.build_steal(params[:steal])
    if @steal.save
      redirect_to :action => :show_steal , :versus_id=>@versus.id
    else
      render :action => :show_steal
    end
  end

  def update_steal
    @steal = @versus.steal
    if @steal.save_update_attributes(params)
      redirect_to :action => :show_steal , :versus_id=>@versus.id
    else
      render :action => :show_steal
    end
  end

  def show_schwag
    @schwag = @versus.schwag || @versus.build_schwag
    @popup_sending_text = @versus.popup_sending_text
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
  end

  def create_schwag
    @schwag = @versus.build_schwag(params[:schwag])
    @versus.save_schwag_magic_number params[:schwag_magic_numbers] rescue ""
    if @schwag.save
      redirect_to :action => :show_schwag , :versus_id=>@versus.id
    else
      render :action => :show_schwag
    end
  end

  def update_schwag
    @schwag = @versus.schwag
    @versus.save_schwag_magic_number params[:schwag_magic_numbers] rescue ""
    if @schwag.save_update_attributes(params)
      redirect_to :action => :show_schwag , :versus_id=>@versus.id
    else
      render :action => :show_schwag
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
  end  
end

  
  private

  def current_versus
    @versus = current_brand_partner.versuses.find(params[:versus_id])
    redirect_to brand_partners_versus_new_path and return if @versus.nil? or @versus.product.nil?
    @product = @versus.product
  end

 def is_valid_email?(email)
  email_regex = %r{^[0-9a-z][0-9a-z._+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z]$}xi
  (email =~ email_regex)
 end 

  def return_versus_twitter_text
    email_txt = (@versus.nil? or @versus.popup_sending_text.nil? or @versus.popup_sending_text.email_txt.nil?)? " " : @versus.popup_sending_text.email_txt
    return email_txt
  end 
  
  
  def return_my_steal_email_text
    steal = Steal.find_by_versus_id(params[:versus_id])
    return (steal.nil? or steal.code.nil?)? " " : steal.code
  end
  
  def return_sms_text
    steal = Steal.find_by_versus_id(params[:versus_id])
    return (steal.nil? or steal.sms_text.nil?)? " " : steal.sms_text
  end   
