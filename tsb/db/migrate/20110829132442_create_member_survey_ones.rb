class CreateMemberSurveyOnes < ActiveRecord::Migration
  def self.up
    create_table :member_survey_ones do |t|
      t.string :sms
      t.string :calls
      t.string :email
      t.string :social_networking
      t.string :humans
      t.references :member

      t.timestamps
    end
  end

  def self.down
    drop_table :member_survey_ones
  end
end
