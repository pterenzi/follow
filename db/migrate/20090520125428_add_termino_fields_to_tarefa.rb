class AddTerminoFieldsToTarefa < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :termino_at, :datetime
    add_column :tarefas, :comentario_termino, :string
  end

  def self.down
    remove_column :tarefas, :comentario_termino
    remove_column :tarefas, :termino_at
  end
end
