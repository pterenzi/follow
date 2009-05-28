class CreateTableAvaliacao < ActiveRecord::Migration
  def self.up
    create_table :avaliacao, :force => true do |t|
      t.references :tarefa
      t.references :user
      t.integer :nota
      t.string :comentario
      
      t.timestamps
    end
  end

  def self.down
    drop_table :avaliacao
  end
end
