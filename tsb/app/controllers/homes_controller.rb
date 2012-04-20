class HomesController < ApplicationController
  layout "promo_versus"
  before_filter :current_promo_versus, :only=>[:home,:create_member_choice, :save_count_choice,:thank_you_page,:the_deal_live,:the_steal_live,:the_schwag_live,:guest_login]

  def home
    @product = @question.product
  end

  def save_count_choice
    @question.member_count = @question.member_count.to_i + 1
    @question.save
    unless @question_no.to_i == 3
      redirect_to versus_question_path(@question_no.to_i + 1)
    else
      redirect_to versus_thank_you_path # This is would be thank_you path
    end
  end
  
  def thank_you_page
    @product = @question.product
    @reward_link = @product.versus.reward_link || @product.versus.build_reward_link
  end

  def the_deal_live
   @versus = @question.product.versus
   @reward_link = @versus.reward_link || @versus.versus.build_reward_link
   @deal = @versus.deal || @versus.build_deal
  end
  
  def the_steal_live
   @versus = @question.product.versus
   @reward_link = @versus.reward_link || @versus.versus.build_reward_link
   @steal = @versus.steal || @versus.build_steal
  end
  
  def the_schwag_live
   @versus = @question.product.versus
   @reward_link = @versus.reward_link || @versus.versus.build_reward_link
   @schwag = @versus.schwag || @versus.build_schwag
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
        redirect_to versus_thank_you_path and return # This is would be thank_you path
      else
        redirect_to tsb_join_path and return
      end
    end
  end
  

end
