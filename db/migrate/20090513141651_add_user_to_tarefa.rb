class AddUserToTarefa < ActiveRecord::Migration
  def self.up
   # add_column :tarefas, :user_id, :integer
    tarefas = Tarefa.all
    for tarefa in tarefas
      tarefa.user_id = tarefa.usuario_id
      tarefa.save
    end
  end

  def self.down
    remove_column :tarefas, :user_id
  end
end
