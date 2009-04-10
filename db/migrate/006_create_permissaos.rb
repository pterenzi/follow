class CreatePermissaos < ActiveRecord::Migration
  def self.up
  create_table :permissaos, :force => true do |t|
  
  t.string :descricao , :limit=>64
  
    end
  end
  
  def self.down
  drop_table :permissaos  
  end
end
