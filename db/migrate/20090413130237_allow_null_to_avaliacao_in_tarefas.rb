class AllowNullToAvaliacaoInTarefas < ActiveRecord::Migration
  def self.up
    change_column :tarefas, :avaliacao, :integer, :null=>true
  end

  def self.down
    change_column :tarefas, :avaliacao, :string
  end
end
