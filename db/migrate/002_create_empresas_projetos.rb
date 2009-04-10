class CreateEmpresasProjetos < ActiveRecord::Migration
  def self.up
  create_table :empresas_projetos, :force => true do |t|
  
  t.references :empresas 
  
  t.references :projetos 
  
  t.string :nome , :limit=>64
  
    end
  end
  
  def self.down
  drop_table :empresas_projetos  
  end
end
