class CreateRecados < ActiveRecord::Migration
  def self.up
  create_table :recados, :force => true do |t|
  
  t.references :usuarios 
  
    end
  end
  
  def self.down
  drop_table :recados  
  end
end
