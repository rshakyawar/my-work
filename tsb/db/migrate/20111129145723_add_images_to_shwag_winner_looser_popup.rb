class AddImagesToShwagWinnerLooserPopup < ActiveRecord::Migration
  def self.up 
    add_column :shwag_winner_looser_popups, :real_file_name,    :string
    add_column :shwag_winner_looser_popups, :real_content_type, :string
    add_column :shwag_winner_looser_popups, :real_file_size,    :integer
    add_column :shwag_winner_looser_popups, :real_updated_at,   :datetime
   
    add_column :shwag_winner_looser_popups, :winner_file_name,    :string
    add_column :shwag_winner_looser_popups, :winner_content_type, :string
    add_column :shwag_winner_looser_popups, :winner_file_size,    :integer
    add_column :shwag_winner_looser_popups, :winner_updated_at,   :datetime   

    add_column :shwag_winner_looser_popups, :looser_file_name,    :string
    add_column :shwag_winner_looser_popups, :looser_content_type, :string
    add_column :shwag_winner_looser_popups, :looser_file_size,    :integer
    add_column :shwag_winner_looser_popups, :looser_updated_at,   :datetime   
   
  end

  def self.down
    remove_column :shwag_winner_looser_popups, :real_file_name
    remove_column :shwag_winner_looser_popups, :real_content_type
    remove_column :shwag_winner_looser_popups, :real_file_size
    remove_column :shwag_winner_looser_popups, :real_updated_at

    remove_column :shwag_winner_looser_popups, :winner_file_name
    remove_column :shwag_winner_looser_popups, :winner_content_type
    remove_column :shwag_winner_looser_popups, :winner_file_size
    remove_column :shwag_winner_looser_popups, :winner_updated_at

    remove_column :shwag_winner_looser_popups, :looser_file_name
    remove_column :shwag_winner_looser_popups, :looser_content_type
    remove_column :shwag_winner_looser_popups, :looser_file_size
    remove_column :shwag_winner_looser_popups, :looser_updated_at
           
  end
end
