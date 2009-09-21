class CreateUserUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups_users, :id=>false do |t|
      t.integer :user_id
      t.integer :user_group_id
    end
  end

  def self.down
    drop_table :user_groups_users
  end
end
