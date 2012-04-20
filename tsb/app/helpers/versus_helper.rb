module VersusHelper

  def display_question(params_question_no)
    if @question.title.blank? or @question.title.to_s == "QUESTION"
      blank_question = "QUESTION"
      return blank_question 
    else
      return @question.title.to_s
    end
  end

  def apply_css_for_question(question_no,passed_param)
    return "shadow_question" if question_no.to_i == passed_param
  end

  def brand_partner_versus
    current_brand_partner.versuses
  end

end

