class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.integer :usuario_id
      t.string :descricao, :size=>255
      t.integer :tarefa_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comentarios
  end
end
