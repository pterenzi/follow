class CreateCategoriasPermissaos < ActiveRecord::Migration
  def self.up
  create_table :categorias_permissaos, :force => true do |t|
  
  t.references :categorias 
  
  t.references :permissaos 
  
    end
  end
  
  def self.down
  drop_table :categorias_permissaos  
  end
end
