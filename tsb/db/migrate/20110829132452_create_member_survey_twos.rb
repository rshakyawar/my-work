class CreateMemberSurveyTwos < ActiveRecord::Migration
  def self.up
    create_table :member_survey_twos do |t|
      t.string :books
      t.string :travel
      t.string :fashion
      t.string :tv_film
      t.string :nightlife
      t.string :home
      t.string :food
      t.string :gaming
      t.string :music
      t.string :gallery
      t.string :beauty_grooming
      t.string :health_fitness
      t.references :member

      t.timestamps
    end
  end

  def self.down
    drop_table :member_survey_twos
  end
end
