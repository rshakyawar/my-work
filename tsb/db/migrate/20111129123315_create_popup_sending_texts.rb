class CreatePopupSendingTexts < ActiveRecord::Migration
  def self.up
    create_table :popup_sending_texts do |t|
      t.string :fb_text
      t.string :twitter_text
      t.string :sms_text
      t.string :email_txt

      t.timestamps
    end
  end

  def self.down
    drop_table :popup_sending_texts
  end
end
