class AddTermPolicyMember < ActiveRecord::Migration
  def self.up
    add_column :members, :accept_term_conditions, :boolean, :default => false  
  end

  def self.down
    remove_column :members, :accept_term_conditions
  end
end
