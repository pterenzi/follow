class AddNomeFiledToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nome, :string
  end

  def self.down
    remove_column :users, :nome
  end
end
