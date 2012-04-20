class DeviseCreateBrandPartners < ActiveRecord::Migration
  def self.up
    create_table(:brand_partners) do |t|
      t.string :partner_name
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.timestamps
    end

    add_index :brand_partners, :email,                :unique => true
    add_index :brand_partners, :partner_name,                :unique => true
    add_index :brand_partners, :reset_password_token, :unique => true
    add_index :brand_partners, :confirmation_token,   :unique => true
    # add_index :brand_partners, :unlock_token,         :unique => true
    # add_index :brand_partners, :authentication_token, :unique => true
  end

  def self.down
    drop_table :brand_partners
  end
end
