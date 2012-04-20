class AddFbImageToShwagWinnerLooserPopup < ActiveRecord::Migration
  def self.up 
    
    add_column :shwag_winner_looser_popups, :fb_image_file_name,    :string
    add_column :shwag_winner_looser_popups, :fb_image_content_type, :string
    add_column :shwag_winner_looser_popups, :fb_image_file_size,    :integer
    add_column :shwag_winner_looser_popups, :fb_image_updated_at,   :datetime       
   
  end

  def self.down
  
    remove_column :shwag_winner_looser_popups, :fb_image_file_name
    remove_column :shwag_winner_looser_popups, :fb_image_content_type
    remove_column :shwag_winner_looser_popups, :fb_image_file_size
    remove_column :shwag_winner_looser_popups, :fb_image_updated_at    
  
  end
end
