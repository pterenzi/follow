class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects, :force => true do |t|
      
      t.string :name , :limit=>32
      t.string :description , :limit=>256
      t.date :start_date 
      t.date :end_date 
      t.integer :term , :limit=>4
      t.boolean :active 
      t.timestamps
    end
  end
  
  def self.down
    drop_table :projects  
  end
end
