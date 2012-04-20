class GuestController < ApplicationController
  layout "promo_versus"
  before_filter :current_promo_versus, :only=>[:home,:create_member_choice, :save_count_choice,:thank_you_page]
  
  def home
    @product = @question.product
  end
  
  def save_count_choice
    @question.member_count = @question.member_count.to_i + 1
    GuestVote.create(:question_id=>@question.id,:selected_option=>params[:guest_vote])
    @question.save
    unless @question_no.to_i == 3
      redirect_to versus_question_path(@question_no.to_i + 1)
    else
      redirect_to guest_thank_you_path # This is would be thank_you path
    end
  end
  
  def thank_you_page
    @product = @question.product
    @reward_link = @product.versus.reward_link || @product.versus.build_reward_link
    @guest_email=GuestEmail.new
    render :layout=>"application"
  end
  
  def save_guest_information
   @guest_email=GuestEmail.new(:email=>params[:email])
   if @guest_email.save
    redirect_to tsb_join_path
   else
    render :action=>"thank_you_page",:layout=>"application"
   end
  end
  
  def send_membership_code_to_guest
    guest_email=GuestEmail.new(:email=>params[:guest_user][:email])
    if guest_email.save
      UserMailer.send_mail_guest_user("info@thestashbox.com", guest_email.email, "tsbloveswayne").deliver!
      render :json =>"Email has been send".to_json, :status => :created
    else
      render :json =>guest_email.errors, :status => :unprocessable_entity
    end
  end
  
  private

  def current_promo_versus
    @question_no = params[:question_no]
    @versus = Versus.live_promo_versus
    redirect_to tsb_join_path and return if @versus.blank?
    @questions = @versus.questions
    redirect_to tsb_join_path and return if @questions.blank?
    @question = if @question_no.blank?
      @question_no = 1
      @questions.find_by_question_no(1)
    else
      @questions.find_by_question_no(@question_no)
    end
    if @question.blank?
      if [1,2,3].include?(@question_no.to_i) 
        redirect_to guest_thank_you_path and return # This is would be thank_you path
      else
        redirect_to tsb_join_path and return
      end
    end
  end
            
end
