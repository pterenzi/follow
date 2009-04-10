class CreateProjetos < ActiveRecord::Migration
  def self.up
  create_table :projetos, :force => true do |t|
  
  t.string :nome , :limit=>32
  
  t.string :descricao , :limit=>256
  
  t.date :data_inicio 
  
  t.date :data_fim 
  
  t.integer :prazo , :limit=>4
  
  t.boolean :ativo , :limit=>1
  
    end
  end
  
  def self.down
  drop_table :projetos  
  end
end
