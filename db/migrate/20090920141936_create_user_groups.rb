class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.string :name
      t.boolean :active
      t.integer :client_id
      t.timestamps
    end
    add_index :user_groups, :id
    add_index :user_groups, :client_id
  end

  def self.down
    drop_table :user_groups
  end
end
