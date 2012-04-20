class UpdateRecordSurveyThree < ActiveRecord::Migration
  def self.up
   connection.execute("update member_survey_threes set hopelessly_devoted_to = NULL , academic_accolades = NULL ,  shelling_it_out = NULL , punch_the_clock = NULL , guilty_by_vocation = NULL  , stork_inventory = NULL ")
  end

  def self.down
  end
end       

