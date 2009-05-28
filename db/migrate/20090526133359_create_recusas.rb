class CreateRecusas < ActiveRecord::Migration
  def self.up
    create_table :recusas, :force => true do |t|  
      t.references :tarefa
      t.references :user
      t.string :comentario_user
      t.string :comentario_solicitante
      t.timestamps
    end
  end

  def self.down
    drop_table :recusas
  end
end
