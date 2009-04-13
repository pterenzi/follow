class AddTipoDeUsuarioATarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :usuario_executor_id, :integer
  end

  def self.down
    remove_column :tarefas, :usuario_executor_id
  end
end
