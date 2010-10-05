class RemoveCategory < ActiveRecord::Migration
  def self.up
    drop_table :categories
    remove_column :users, :category_id
  end

  def self.down
  end
end
