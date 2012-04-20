class AddFbImageLinkToShwagWinnerLooserPopup < ActiveRecord::Migration
  def self.up
    add_column :shwag_winner_looser_popups, :fb_image_link, :string
  end

  def self.down
    remove_column :shwag_winner_looser_popups, :fb_image_link
  end
end
