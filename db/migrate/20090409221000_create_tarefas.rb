class CreateTarefas < ActiveRecord::Migration
  def self.up
    create_table :tarefas, :force => true do |t|

      t.references :projeto 
      t.references :user
      t.references :solicitante
      t.string :descricao,:size=>255
      t.integer :tempo_est , :limit=>4, :null=>false
      t.boolean :alerta_usuario, :default=>false
      t.boolean :alerta_solicitante, :default=>false
      t.datetime :termino_at
      t.string :comentario_termino_user
      t.string :comentario_termino_solicitante
      t.boolean :recusada, :default=>false
      t.boolean :tem_comentario, :default=>false
      t.timestamps

    end
  end

  def self.down
    drop_table :tarefas  
  end
end
