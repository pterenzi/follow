class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.integer :level
      t.timestamps
    end
    add_column :users, :role_id, :integer
    add_index :roles, :id
    Role.create(:name=>"Gestor", :level=>0);
    Role.create(:name=>"Adminstrador", :level=>1)
    Role.create(:name=>"Gerente", :level=>2)
    Role.create(:name=>"Usuário",  :level=>3)
  end

  def self.down
    remove_column :users, :role
    drop_table :roles
  end
end
