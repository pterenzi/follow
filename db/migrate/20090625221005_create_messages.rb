class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages, :force => true do |t|
      t.string :content
      t.datetime :readed
      t.integer :written_by
      t.integer :user_id
      t.timestamps
    end
     add_index :messages, :id
     add_index :messages, :written_by
     add_index :messages, :user_id
  end
  
  def self.down
    drop_table :messages  
  end
end
