class AddUserIdFieldToPause < ActiveRecord::Migration
  def self.up
    add_column :pauses, :user_id, :integer
    add_index :pauses, :user_id
  end

  def self.down
    remove_column :pauses, :user_id
    drop_index :user_id
  end
end
