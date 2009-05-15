class AddCategoriaToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :categoria_id, :integer
  end

  def self.down
    remove_column :users, :categoria_id
  end
end
