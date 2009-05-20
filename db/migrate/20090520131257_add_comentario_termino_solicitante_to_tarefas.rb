class AddComentarioTerminoSolicitanteToTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :comentario_termino_solicitante, :string
  end

  def self.down
    remove_column :tarefas, :comentario_termino_solicitante
  end
end
