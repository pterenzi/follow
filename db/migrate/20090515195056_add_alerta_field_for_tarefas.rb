class AddAlertaFieldForTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :alerta_usuario, :boolean, :default=>false
    add_column :tarefas, :alerta_solicitante, :boolean, :default=>false
    #remove_column :tarefas, :alerta
  end

  def self.down
    remove_column :tarefas, :alerta_solicitante
    remove_column :tarefas, :alerta_usuario
    #add_column :tarefas, :alerta, :boolean
  end
end
