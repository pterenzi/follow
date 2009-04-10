class CreateUsuarios < ActiveRecord::Migration
  def self.up
  create_table :usuarios, :force => true do |t|
  
  t.references :categorias 
  
  t.string :nome , :limit=>32
  
  t.string :cargo , :limit=>32
  
  t.string :pass , :limit=>64
  
  t.string :endereco , :limit=>128
  
  t.string :bairro , :limit=>32
  
  t.string :municipio , :limit=>32
  
  t.string :uf , :limit=>2
  
  t.string :cpf , :limit=>32
  
  t.string :email , :limit=>128
  
  t.string :gerente , :limit=>32
  
    end
  end
  
  def self.down
  drop_table :usuarios  
  end
end
