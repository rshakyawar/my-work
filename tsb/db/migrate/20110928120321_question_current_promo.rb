class QuestionCurrentPromo < ActiveRecord::Migration
  def self.up
    add_column :questions, :current_promo_versus, :boolean
    add_column :questions, :promo_versus_order, :integer
    add_column :questions, :activated_at, :datetime
  end

  def self.down
    remove_column :questions, :current_promo_versus
    remove_column :questions, :promo_versus_order
    remove_column :questions, :activated_at
  end
end
