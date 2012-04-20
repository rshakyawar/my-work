class MemberDeviseLoginColumn < ActiveRecord::Migration
  def self.up
    remove_column :members, :email
    change_table(:members) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
    end
  end

  def self.down
  end
end
