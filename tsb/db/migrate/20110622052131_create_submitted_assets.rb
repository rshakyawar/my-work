class CreateSubmittedAssets < ActiveRecord::Migration
  def self.up
    create_table :submitted_assets do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :url, :string
      t.column :whatisit, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :submitted_assets
  end
end
