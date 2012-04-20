class CreateMemberSurveyThrees < ActiveRecord::Migration
  def self.up
    create_table :member_survey_threes do |t|
      t.string :hopelessly_devoted_to
      t.string :academic_accolades
      t.string :shelling_it_out
      t.string :punch_the_clock
      t.string :guilty_by_vocation
      t.string :stork_inventory
      t.references :member

      t.timestamps
    end
  end

  def self.down
    drop_table :member_survey_threes
  end
end
