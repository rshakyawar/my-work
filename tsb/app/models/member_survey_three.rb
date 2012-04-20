class MemberSurveyThree < ActiveRecord::Base
  serialize :hopelessly_devoted_to, Array
  serialize :academic_accolades, Array
  serialize :shelling_it_out, Array
  serialize :punch_the_clock, Array
  serialize :guilty_by_vocation, Array
  serialize :stork_inventory, Array

  SURVEY_HOPLESSLY_DEVOTED_TO_ATTRIBUTES = %w(hopelessly_devoted_to)
  belongs_to :member
  
  validate :brack_hoplessly
 
  def brack_hoplessly
    selection = 0
    SURVEY_HOPLESSLY_DEVOTED_TO_ATTRIBUTES.each do |attr| 
      self[attr] = self[attr][0].to_s.split("@") if (!self[attr].blank? and self[attr].size == 1)
    end
    SURVEY_HOPLESSLY_DEVOTED_TO_ATTRIBUTES.each {|attr| selection += 1 if self[attr].blank? }
  end
    
end     

