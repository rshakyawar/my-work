require 'atom/feed'

class SiteController < ApplicationController

  def index
    @subscriber = Subscriber.new
    @class = "home"
  end

  def blog
    @feed = Atom::Feed.new("http://thestashbox63.blogspot.com/feeds/posts/default")
    @feed.update!
    @submitted_asset = SubmittedAsset.new
    @class = "blog"
    @title = "The Stashbox - Blog"
  end

  def contact
    @title = "The Stashbox - Contact"
  end

  def email
  end

  def how_it_works
    @class = "howworks"
    @title = "The Stashbox - How it Works"
  end

  def hunt_membership
    @class = "huntmembership"
    @title = "The Stashbox - Hunt Down Membership"
  end

  def twitter
    @title = "The Stashbox - Twitter"
    @tweets = TwitterPoller.timeline
  end

  def members_login
    @class = "memberLog"
    @title = "The Stashbox - Member Login"
    redirect_to member_session_path
  end

  def membership
    @class = "memberLog"
    @title = "The Stashbox - Membership"
  end

  def who_we_are
    @title = "The Stashbox - Who we are"
  end

  def brandpartners
    redirect_to new_brand_partner_session_path and return
    img_block = params[:img_block]
    @selected_tab = img_block.blank? ?  Product::BLOCK_IMAGE_NAME["logo_one"] : ( Product::BLOCK_IMAGE_NAME[img_block].blank? ? Product::BLOCK_IMAGE_NAME["logo_one"] : Product::BLOCK_IMAGE_NAME[img_block] )
    @product = Product.first || Product.new
    render :layout => 'versus'
  end

  def brandpartners_save
    @product = Product.first
    if @product.nil?
      @product = Product.create(params[:product])
    else
      @product.update_attributes(params[:product])
    end
    redirect_to :action => :brandpartners ,:img_block=>params[:img_block]
  end

  def save_question_information
    @product = Product.first || Product.create
    question = @product.questions.find_by_question_no(params[:question][:question_no])
    if question 
      question.update_attributes(params[:question])
    else
      @product.questions.create(params[:question])
    end 
    redirect_to :action=>:brandpartners ,:img_block=>"versus_question",:q=>params[:question_button_no]
  end
  
  def retrive_question_information
   product = Product.first || Product.create
   question = product.questions.find_by_question_no(params[:question_no])
   render :json => (question.blank? ? {} : question.to_json)
  end
  
  def save_button_color
    @product = Product.first || Product.create
    @product.update_attributes(:bottom_banner_color=>params[:font_color])
    redirect_to :action=>:brandpartners ,:img_block=>"bottom_banner"
  end

  def forgot_password
    redirect_to new_brand_partner_password_path and return
  end

  def forgot_user_name	
    render :layout=>"devise_layout"
  end
  
  def give_forgot_password
    brand_partner = BrandPartner.find(:first,:conditions=>["email = ? or partner_name = ? ",params[:userNamePw],params[:userNamePw]])
    unless brand_partner.blank?
      UserMailer.deliver_send_mail_for_forgot_password(brand_partner)
    end
    render :action=>"forgot_password"
  end
  
  
  def give_forgot_username
    if params[:userEmail] == params[:confirmEmail] and !params[:userEmail].blank?
     brand_partner = BrandPartner.find_by_email(params[:userEmail])
     UserMailer.deliver_send_mail_for_forgot_user_name(brand_partner) unless brand_partner.blank?
    else
      flash[:notice] = "Please Enter valid email"
    end
    render :action=>"forgot_user_name",:layout=>"devise_layout"
  end

  def the_schwag	
	 render :layout=>"rewards_upload_layout"
	end

  def the_steal	
	 render :layout=>"rewards_upload_layout"
	end
	
	def emastrewards
	    render :layout=>"devise_layout"
	end
	def tsb_privacy
 end
 
 def tsb_term_of_uses
 end
end
