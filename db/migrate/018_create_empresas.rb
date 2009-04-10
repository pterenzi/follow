class CreateEmpresas < ActiveRecord::Migration
  def self.up
  create_table :empresas, :force => true do |t|
  
  t.string :nome , :limit=>64
  
  t.string :razao , :limit=>128
  
  t.integer :tipo , :limit=>4
  
  t.string :contato , :limit=>64
  
  t.string :contato_fone , :limit=>32
  
  t.string :contato_cell , :limit=>32
  
  t.string :contato_email , :limit=>128
  
  t.string :fone , :limit=>32
  
  t.string :endereco , :limit=>128
  
  t.string :bairro , :limit=>32
  
  t.string :municipio , :limit=>32
  
  t.string :uf , :limit=>2
  
  t.string :cnpj , :limit=>32
  
  t.string :insc_est , :limit=>64
  
  t.string :insc_mun , :limit=>64
  
  t.string :site , :limit=>128
  
  t.string :banco , :limit=>32
  
  t.string :agencia , :limit=>32
  
  t.string :conta , :limit=>32
  
    end
  end
  
  def self.down
  drop_table :empresas  
  end
end
