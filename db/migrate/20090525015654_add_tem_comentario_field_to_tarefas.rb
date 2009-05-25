class AddTemComentarioFieldToTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :tem_comentario, :boolean
    for tarefa in Tarefa.all
      tem_comentario = false
      tarefa.save
    end
  end

  def self.down
    remove_column :tarefas, :tem_comentario
  end
end
