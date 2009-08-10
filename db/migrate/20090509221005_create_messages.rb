class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages, :force => true do |t|
      t.integer :written_by
      t.integer :written_to
      t.timestamps
    end
  end
  
  def self.down
  drop_table :messages  
  end
end
