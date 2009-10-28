class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.references :client
      t.string :name , :limit=>32
      t.timestamps
    end
    add_index :categories, :id
    add_index :categories, :client_id 
   
  end
  
  def self.down
    drop_table :categories  
  end
end
