class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.integer :level
      t.timestamps
    end
    add_column :users, :role, :integer
    add_index :roles, :id
  end

  def self.down
    remove_column :users, :role
    drop_table :roles
  end
end
