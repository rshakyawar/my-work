class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :title
      t.string :font_style
      t.string :font_color
      t.references :product
      t.integer :question_no

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
