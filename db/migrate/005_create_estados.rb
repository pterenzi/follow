class CreateEstados < ActiveRecord::Migration
  def self.up
  create_table :estados, :force => true do |t|
  
  t.string :sigla , :limit=>2
  
  t.string :estado , :limit=>64
  
    end
  end
  
  def self.down
  drop_table :estados  
  end
end
