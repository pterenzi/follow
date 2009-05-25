class AddRecusadoFieldToTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :recusado, :boolean
  end

  def self.down
    remove_column :tarefas, :recusado
  end
end
