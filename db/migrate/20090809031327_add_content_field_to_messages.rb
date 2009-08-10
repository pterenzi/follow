class AddContentFieldToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :content, :string
    add_index :messages, :written_by
    add_index :messages, :written_to
  end

  def self.down
    remove_column :messages, :content
    remove_index :messages, :written_by
    remove_index :messages, :written_to
  end
end
