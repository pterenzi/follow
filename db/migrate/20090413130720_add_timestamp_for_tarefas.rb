class AddTimestampForTarefas < ActiveRecord::Migration
  def self.up
    add_column :tarefas, :created_at, :datetime
    add_column :tarefas, :updated_at, :datetime
  end

  def self.down
    remove_column :tarefas, :updated_at
    remove_column :tarefas, :created_at
  end
end
