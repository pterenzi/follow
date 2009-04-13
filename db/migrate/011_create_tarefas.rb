class CreateTarefas < ActiveRecord::Migration
  def self.up
    create_table :tarefas, :force => true do |t|

      t.references :projeto 

      t.references :usuario 

      t.integer :tempo_est , :limit=>4, :null=>false

      t.integer :avaliacao , :limit=>4, :null=>false

      t.references :situacao 

    end
  end

  def self.down
    drop_table :tarefas  
  end
end
