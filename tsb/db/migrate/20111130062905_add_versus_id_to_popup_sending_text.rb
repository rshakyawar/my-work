class AddVersusIdToPopupSendingText < ActiveRecord::Migration
  def self.up
    add_column :popup_sending_texts, :versus_id, :integer
  end

  def self.down
    remove_column :popup_sending_texts, :versus_id
  end
end
