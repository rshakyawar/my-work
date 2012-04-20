require 'uri'
module ApplicationHelper
  FILE_DIMENSION = {"logo_one"=>'172x75', "logo_two"=>'120x55', "top_banner"=>'760x75' ,"bottom_banner"=>'614x75' ,"background"=>'760x300',"versus_left"=>'200x200',"versus_right"=>'200x200',"versus_question"=>"760x82",
  "reward_link"=>"221x214","real"=>"196x254","winner"=>"171x184","looser"=>"171x184","fb_image"=>"90x40","steal"=>"290x270","schwag"=>"43x41"}
  IMAGE_FORMAT = ['jpg/png/gif']
  DISPLAY_NONE_CSS_CLASS = "none_display"
    
  def session_question
    session[:current_question] || 1
  end

  def get_file_dimension input
    return FILE_DIMENSION[input]
  end
  
  def get_twitter_url  
    twitter_url = "https://twitter.com/share?original_referer=http://#{Settings.site_base_uri}/members/shared_from_twitt&text=#{URI.escape(return_versus_twitter_text)}&url=."   
    return twitter_url 
  end
  
  def get_twitter_steal_url   
    twitter_steal_url = "https://twitter.com/share?original_referer=http://#{Settings.site_base_uri}/members/the_steal&text=#{URI.escape(return_versus_twitter_text)}&url=."  
    return twitter_steal_url 
  end  

  def get_twitter_deal_url  
    twitter_deal_url = "https://twitter.com/share?original_referer=http://#{Settings.site_base_uri}/members/the_deal&text=#{URI.escape(return_versus_twitter_text)}&url=."   
    return twitter_deal_url 
  end
    
  def rgb_schwag_button(ready_to_next, played_shots)
    if ready_to_next
      return "_green", "", "" if played_shots == 0
      return "_red", "_green", "" if played_shots == 1
      return "_red", "_red", "_green" if played_shots == 2
      return "_red", "_red", "_red" if played_shots == 3
    else
      return "_red", "", "" if played_shots == 1
      return "_red", "_red", "" if played_shots == 2
      return "_red", "_red", "_red" if played_shots == 3
    end
  end
  
  def remaining_shots(ready_to_next, played_shots)
    if ready_to_next
      return "second + third" if played_shots == 0
      return "third" if played_shots == 1
      return "third" if played_shots == 2
      return "third" if played_shots == 3
    else
      return "second + third" if played_shots == 1
      return "third" if played_shots == 2
      return "third" if played_shots == 3
    end
  end
  
  def return_hh
    "hh..."
  end
  
  def return_versus_twitter_text
    versus = Versus.live_promo_versus
    twitter_text = (versus.nil? or versus.popup_sending_text.nil?)? " " : versus.popup_sending_text.twitter_text
    return twitter_text
  end  
  
  def select_magic_number_class(index, magic_numbers)
    return DISPLAY_NONE_CSS_CLASS if magic_numbers.include?("@@" + index.to_s + "--")
    return ""
  end
  
  def de_select_magic_number_class(index, magic_numbers)
    return "" if magic_numbers.include?("@@" + index.to_s + "--")
    return DISPLAY_NONE_CSS_CLASS
  end

  def get_member_survey_two(member)
    if member.member_survey_two.blank?
      member.build_member_survey_two
    else
      member.member_survey_two
    end
  end

  def get_member_survey_three(member)
    if member.member_survey_three.blank?
      member.build_member_survey_three
    else
      member.member_survey_three
    end
  end
  
  def survey_expert input_array
    return input_array.inject(""){|result,ele|  result + ele + "@ " }
  end

end

