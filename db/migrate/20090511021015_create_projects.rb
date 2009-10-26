class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects, :force => true do |t|
      
      t.string :name , :limit=>32
      t.string :description , :limit=>256
      t.boolean :active 
      t.timestamps
    end
    add_index :projects, :id
  end
  
  def self.down
    drop_table :projects  
  end
end
