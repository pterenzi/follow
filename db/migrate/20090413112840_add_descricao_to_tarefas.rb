class AddDescricaoToTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :descricao, :string, :size=>255
  end

  def self.down
    remove_column :tarefas, :descricao
  end
end
