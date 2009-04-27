class CreatePausas < ActiveRecord::Migration
  def self.up
    create_table :pausas do |t|
      t.datetime :data
      t.references :tarefa
      t.string :justificativa
      t.boolean :aceito
      t.string :comentario_solicitante

      t.timestamps
    end
  end

  def self.down
    drop_table :pausas
  end
end
