class Members::MemberAuthenticationController < Members::BaseController
  layout "promo_versus"
  before_filter :authenticate_versus_member!
  before_filter :member_sign_in
  before_filter :current_promo_versus
  before_filter :current_versus_question, :only=>[:home, :save_count_choice]
  before_filter :done_versus_survey, :only=>[:home]
  before_filter :validate_versus_survey, :only=>[:thank_you_page, :the_steal_live, :schwag_for_game]
  before_filter :validate_schwag_winners, :only=>[:schwag_for_game]
  before_filter :validate_schwag_shots, :only=>[:schwag_for_game]
  
  def home; end
  
  def save_count_choice
    save_member_votes
    redirect_to member_question_path next_question
  end
  
  def thank_you_page
    @reward_link = @product.versus.reward_link || @product.versus.build_reward_link
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
    render :layout=>"thankyou_deal_steal_layout"
  end
  
  def the_deal_live
    redirect_to members_thank_you_page_path
  end
  
  def the_steal_live
    @reward_link = @versus.reward_link || @versus.build_reward_link
    @steal = @versus.steal || @versus.build_steal
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
    @fb_sending_text = @versus.popup_sending_text.fb_text unless @versus.popup_sending_text.nil?  # This line of code could have use from helper
    render :layout=>"thankyou_deal_steal_layout"
  end
  
  def schwag_for_game
    @shwag_winner_looser_popup = @versus.shwag_winner_looser_popup|| @versus.build_shwag_winner_looser_popup
    @fb_sending_text = @versus.popup_sending_text.fb_text unless @versus.popup_sending_text.nil?  # This line of code could have use from helper
    @schwag = @versus.schwag || @versus.build_schwag
    schwag_shot_ob = current_versus_member.schwag_shots.where(:versus_id =>@versus.id).first 
    @fb_twit_token = schwag_shot_ob.fb_twit_token if !schwag_shot_ob.blank? and schwag_shot_ob.shot_count < 3       
    render :layout=>"promo_versus_schwag"
  end
  
  def schwag_shot
    game_result = SchwagShot.shot_result(@versus, current_versus_member, params[:choose_shot])
    schwag_shot_ob = current_versus_member.schwag_shots.where(:versus_id =>@versus.id)
    if !schwag_shot_ob.blank? and game_result == "loose" and schwag_shot_ob[0].shot_count > 2  # "loose", "thank_you", "win" should be constant
      render :json =>{:response=>"thank_you"}.to_json, :status => :created
    else
      render :json =>{:response=>game_result}.to_json, :status => :created
    end
  end
  
  def shared_from_twitt
    schwag_shot = current_versus_member.schwag_shots.where(:versus_id =>@versus.id)
    schwag_shot[0].ready_to_next_true unless schwag_shot.blank?
    redirect_to members_the_schwag_path
  end 
  
end
