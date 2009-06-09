class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios, :force => true do |t|
      t.references :user
      t.string :descricao, :size=>255
      t.references :task

      t.timestamps
    end
  end

  def self.down
    drop_table :comentarios
  end
end
