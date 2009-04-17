class RemoveExecutorFromTarefas < ActiveRecord::Migration
  def self.up
  #  remove_column :tarefas, :usuario_executor_id
  end

  def self.down
  #  add_column :tarefas, :usuario_executor_id, :integer
  end
end
