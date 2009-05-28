class CreatePausas < ActiveRecord::Migration
  def self.up
    create_table :pausas, :force => true do |t|
      t.datetime :data
      t.references :tarefa
      t.string :justificativa
      t.boolean :aceito
      t.string :comentario_solicitante
      t.datetime :reinicio
      t.boolean :padrao
      t.references :pausa_padrao
      t.timestamps
    end
  end

  def self.down
    drop_table :pausas
  end
end
