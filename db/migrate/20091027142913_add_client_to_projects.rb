class AddClientToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :client_id, :integer
    add_index :projects, :client_id
  end

  def self.down
    remove_column :projects, :client_id
    remove_index :projects, :client_id
  end
end
