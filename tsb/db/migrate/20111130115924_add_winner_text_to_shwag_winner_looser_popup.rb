class AddWinnerTextToShwagWinnerLooserPopup < ActiveRecord::Migration
  def self.up
    add_column :shwag_winner_looser_popups, :winner_text, :string
  end

  def self.down
    remove_column :shwag_winner_looser_popups, :winner_text
  end
end
