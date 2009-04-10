class CreateProjetosUsuarios < ActiveRecord::Migration
  def self.up
  create_table :projetos_usuarios, :force => true do |t|
  
  t.references :usuarios 
  
  t.references :projetos 
  
    end
  end
  
  def self.down
  drop_table :projetos_usuarios  
  end
end
