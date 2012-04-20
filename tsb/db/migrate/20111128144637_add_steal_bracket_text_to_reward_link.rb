class AddStealBracketTextToRewardLink < ActiveRecord::Migration
  def self.up
    add_column :reward_links, :steal_bracket_text, :string
  end

  def self.down
    remove_column :reward_links, :steal_bracket_text
  end
end
