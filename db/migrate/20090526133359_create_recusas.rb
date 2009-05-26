class CreateRecusas < ActiveRecord::Migration
  def self.up
    create_table :recusas do |t|  
      t.integer :tarefa_id
      t.integer :usuario_id
      t.string :comentario_user
      t.string :comentario_solicitante
      t.timestamps
    end
  end

  def self.down
    drop_table :recusas
  end
end
