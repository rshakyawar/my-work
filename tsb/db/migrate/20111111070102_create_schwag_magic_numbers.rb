class CreateSchwagMagicNumbers < ActiveRecord::Migration
  def self.up
    create_table :schwag_magic_numbers do |t|
      t.references :versus
      t.string :magic_numbers

      t.timestamps
    end
  end

  def self.down
    drop_table :schwag_magic_numbers
  end
end
