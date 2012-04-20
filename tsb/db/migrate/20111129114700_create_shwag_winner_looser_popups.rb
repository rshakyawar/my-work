class CreateShwagWinnerLooserPopups < ActiveRecord::Migration
  def self.up
    create_table :shwag_winner_looser_popups do |t|
      t.string :schwag_text

      t.timestamps
    end
  end

  def self.down
    drop_table :shwag_winner_looser_popups
  end
end
