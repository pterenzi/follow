class CreateSituacaos < ActiveRecord::Migration
  def self.up
  create_table :situacaos, :force => true do |t|
  
  t.string :descricao , :limit=>32
  
  t.string :sigla , :limit=>8
  
    end
  end
  
  def self.down
  drop_table :situacaos  
  end
end
