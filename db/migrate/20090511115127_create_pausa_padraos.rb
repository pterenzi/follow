class CreatePausaPadraos < ActiveRecord::Migration
  def self.up
    create_table :pausa_padraos, :force => true do |t|
      t.string :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :pausa_padraos
  end
end
