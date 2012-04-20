class AddVersusIdToShwagWinnerLooserPopup < ActiveRecord::Migration
  def self.up
    add_column :shwag_winner_looser_popups, :versus_id, :integer
  end

  def self.down
    remove_column :shwag_winner_looser_popups, :versus_id
  end
end
