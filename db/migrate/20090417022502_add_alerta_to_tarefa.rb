class AddAlertaToTarefa < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :alerta, :boolean, :default=>false
  end

  def self.down
    remove_column :tarefas, :alerta
  end
end
