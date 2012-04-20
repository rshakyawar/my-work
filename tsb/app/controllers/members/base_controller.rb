class Members::BaseController < ApplicationController

  private

  def member_sign_in
    sign_in_as_member_from_versus_member if versus_member_signed_in? and !member_signed_in?
  end
  
  def sign_in_as_member_from_versus_member
    sign_in @member = current_versus_member, :bypass => true
  end

  def live_promo_versus    
    redirect_to_tsb_join if (@versus = Versus.live_promo_versus).blank?
    redirect_to_tsb_join if (@questions = @versus.questions).blank?
    @product = @versus.product
  end
  
  def current_versus_question
    @question_no = ( params[:question_no] || 1)
    @question = @questions.find_by_question_no(@question_no)
    redirect_to members_thank_you_page_path and return if @question.blank?
  end

  def check_versus_survey?
    return @questions.size == @questions.select { |question| !question.member_votes.where(:member_id=>current_versus_member.id).blank? }.size
  end
  
  def check_versus_question
    versus_questions_for_vote = @questions.select{|question| question.member_votes.where(:member_id=>current_versus_member.id).blank?}
    return false if versus_questions_for_vote.blank?
    return versus_questions_for_vote[0].question_no
  end
  
  def save_member_votes
    @question.save_member_vote current_versus_member, params[:member_vote]
  end
  
  def done_versus_survey
    redirect_to members_thank_you_page_path and return if check_versus_survey?
  end
  
  def validate_versus_survey
    question_no = check_versus_question
    redirect_to member_question_path(question_no) and return if question_no
  end
  
  def validate_schwag_winners
    schwag_winner = current_versus_member.schwag_winners.where(:versus_id =>@versus.id)
    redirect_to :action=>:thank_you_page, :winner=>true and return unless schwag_winner.blank?
  end
  
  def validate_schwag_shots
    member_schwag_looser?
    member_schwag_shot_status
  end
  
  def member_schwag_shot_status
    @played_shots, @is_ready_to_next_click = current_versus_member.played_shots_and_next_shot @versus
  end
  
  def member_schwag_looser?
    redirect_to :action=>:thank_you_page, :shot_pop_up=>true and return if current_versus_member.schwag_looser? @versus
  end
  
  def next_question
    @question_no.to_i + 1
  end
  
  def current_promo_versus
    live_promo_versus
  end

  def redirect_to_tsb_join
    redirect_to tsb_join_path and return
  end

end
