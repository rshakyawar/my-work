class MemberSurveyTwo < ActiveRecord::Base

  MINIMUM_SELECTION = 3
  SURVEY_TWO_ATTRIBUTES = %w(books travel fashion tv_film nightlife home food gaming music gallery beauty_grooming health_fitness)
  belongs_to :member

  serialize :books, Array
  serialize :travel, Array
  serialize :fashion, Array
  serialize :tv_film, Array
  serialize :nightlife, Array
  serialize :home, Array
  serialize :food, Array
  serialize :gaming, Array
  serialize :music, Array
  serialize :gallery, Array
  serialize :beauty_grooming, Array
  serialize :health_fitness, Array

  validate :three_present
 
  def three_present
    selection = 0
    SURVEY_TWO_ATTRIBUTES.each do |attr| 
      self[attr] = self[attr][0].to_s.split("@") if (!self[attr].blank? and self[attr].size == 1)
    end
    SURVEY_TWO_ATTRIBUTES.each {|attr| selection += 1 if self[attr].blank? }
    errors_minimum_selection_add_to_base selection
  end
  
  def errors_minimum_selection_add_to_base selection
    errors.add_to_base("Please select at least three options") if selection > SURVEY_TWO_ATTRIBUTES.size - MINIMUM_SELECTION
  end
end
