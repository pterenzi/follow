class AddJustificativaRecusaFieldToTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :justificativa_recusa, :string
  end

  def self.down
    remove_column :tarefas, :justificativa_recusa
  end
end
