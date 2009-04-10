class CreateCategorias < ActiveRecord::Migration
  def self.up
  create_table :categorias, :force => true do |t|
  
  t.string :nome , :limit=>32
  
    end
  end
  
  def self.down
  drop_table :categorias  
  end
end
